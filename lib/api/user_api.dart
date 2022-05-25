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
  static const String userRout = "/creator_user";

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
      await _dio.post("$userRout/create", data: regData.toMap());
    } on DioError catch (e) {
      return UserModel(name: "", email: "", id: -1, accessToken: "", error: e);
    }

    LoginModel login = await _loginService.getToken(email, password);

    UserModel user = await getUserByEmail(email);

    if (user.error != null) {
      return user;
    }

    await setUser(user: user, accessToken: login.accessToken);

    return _user!;
  }

  //###################### Get #################################
  Future<LoginModel> getToken(email, password) async {
    return await _loginService.getToken(email, password);
  }

  Future<UserModel> setUser({
    UserModel? user,
    String? email,
    required String accessToken,
  }) async {
    if (user == null) {
      UserModel userRes = await getUserByEmail(email!);
      //if ther is an error, return withoue setting
      if (userRes.hasError) {
        return userRes;
      } else {
        _user = userRes;
      }
    } else {
      _user = user;
    }

    await _userBox.put("name", _user!.name);
    await _userBox.put("email", _user!.email);
    await _userBox.put("accessToken", accessToken);
    await _userBox.put("id", _user!.id);

    return _user!;
  }

  Future<UserModel> getCurrentUser() async {
    try {
      var res = await _dio.get("$userRout/current");
      return UserModel.fromMap(res.data);
    } on DioError catch (e) {
      return UserModel(name: "", email: "", id: -1, accessToken: "", error: e);
    }
  }

  Future<UserModel> getUserByEmail(String email) async {
    try {
      var res = await _dio.get("$userRout/by_email/$email");
      return UserModel.fromMap(res.data);
    } on DioError catch (e) {
      return UserModel(name: "", email: "", id: -1, accessToken: "", error: e);
    }
  }
}
