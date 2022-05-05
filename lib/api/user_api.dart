import 'package:chat_bot_creator/api/models/login_model.dart';
import 'package:chat_bot_creator/api/models/registration_model.dart';
import 'package:chat_bot_creator/api/models/user_model.dart';
import 'package:chat_bot_creator/api/services/login_service.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class UserAPI {
  final Dio _dio;
  final LoginService _loginService;
  late Box _userBox;
  UserModel? _user;

  UserAPI(this._dio, this._loginService) : super();

  Future init() async {
    _userBox = await Hive.openBox("user");
  }

  String? get name => _user?.name;
  String? get email => _user?.email;
  bool get isAutheticated => _userBox.get("accessToken") == null ? false : true;

  //###################### Create #################################
  Future<UserModel> createUser(
    String name,
    String email,
    String password,
  ) async {
    RegistrationModel regData = RegistrationModel(
      name: name,
      email: email,
      password: password,
    );

    try {
      await _dio.post("/user/create", data: regData.toMap());
    } on DioError catch (e) {
      return UserModel(name: "", email: "", id: -1, accessToken: "", error: e);
    }

    await _loginService.getToken(email, password);

    UserModel user = await getUserByEmail(email);

    if (user.error != null) {
      return user;
    }

    await setUser(user: user);

    return _user!;
  }

  //###################### Get #################################
  Future<LoginModel> getToken(email, password) async {
    print("PEGANDO TOKEN");
    return await _loginService.getToken(email, password);
  }

  Future<UserModel> setUser({
    UserModel? user,
    String? email,
    String? accessToken,
  }) async {
    if (user == null) {
      print("PEGANDO USER POR EMAIL");
      _user = await getUserByEmail(email ?? "");
    }

    await _userBox.put("name", _user!.name);
    await _userBox.put("email", _user!.email);
    await _userBox.put("accessToken", accessToken);
    await _userBox.put("id", _user!.id);

    return _user!;
  }

//TODO
  Future<UserModel> getCurrentUser() async {
    try {
      var res = await _dio.get("/user/current");
      return UserModel.fromMap(res.data);
    } on DioError catch (e) {
      return UserModel(name: "", email: "", id: -1, accessToken: "", error: e);
    }
  }

  Future<UserModel> getUserByEmail(String email) async {
    try {
      var res = await _dio.get("/user/by_email/$email");
      return UserModel.fromMap(res.data);
    } on DioError catch (e) {
      return UserModel(name: "", email: "", id: -1, accessToken: "", error: e);
    }
  }
}
