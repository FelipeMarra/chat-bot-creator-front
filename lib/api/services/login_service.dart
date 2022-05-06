import 'package:chat_bot_creator/api/models/login_model.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:oauth_dio/oauth_dio.dart';

class LoginService {
  final Dio _dio;
  final String baseUrl;
  late OAuth _oauth;
  late Box _userBox;

  LoginService(this._dio, this.baseUrl);

  Future init() async {
    _userBox = await Hive.openBox("user");

    _oauth = OAuth(
      tokenUrl: "$baseUrl/login/",
      clientId: '',
      clientSecret: '',
      storage: OAuthSecureStorage(_userBox),
    );

    _dio.interceptors.add(BearerInterceptor(_oauth));
  }

  Future<LoginModel> getToken(email, password) async {
    String? accessToken;
    try {
      OAuthToken token = await _oauth.requestTokenAndSave(
        PasswordGrant(
          username: email,
          password: password,
        ),
      );

      accessToken = token.accessToken;

      if (accessToken == null) {
        throw Exception("ACCESS TOKEN IS NULL");
      }

      return LoginModel(accessToken: accessToken);
    } on DioError catch (e) {
      return LoginModel(accessToken: accessToken ?? "", error: e);
    }
  }
}

class OAuthSecureStorage extends OAuthStorage {
  final Box userBox;
  final accessTokenKey = 'accessToken';
  final refreshTokenKey = 'refreshToken';

  OAuthSecureStorage(this.userBox);

  @override
  Future<OAuthToken> fetch() async {
    return OAuthToken(
      accessToken: await userBox.get(accessTokenKey),
      refreshToken: await userBox.get(refreshTokenKey),
    );
  }

  @override
  Future<OAuthToken> save(OAuthToken token) async {
    await userBox.put(accessTokenKey, token.accessToken);
    await userBox.put(refreshTokenKey, token.refreshToken);
    return token;
  }

  @override
  Future<void> clear() async {
    await userBox.delete(accessTokenKey);
    await userBox.delete(refreshTokenKey);
  }
}
