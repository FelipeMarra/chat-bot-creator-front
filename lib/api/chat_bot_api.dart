import 'package:chat_bot_creator/api/models/chat_model.dart';
import 'package:dio/dio.dart';

class ChatBotAPI {
  final Dio _dio;

  ChatBotAPI(this._dio);

  static const String baseRout = "/chatbot";

  Future<ChatBotModel> createChatBot(String name) async {
    Response res;
    try {
      res = await _dio.post(
        baseRout + "/create",
        data: {"name": name},
      );
    } on DioError catch (e) {
      return ChatBotModel(
        name: "",
        id: -1,
        initialState: "",
        shareLink: "",
        error: e,
      );
    }

    return ChatBotModel.fromMap(res.data);
  }

  Future<List<ChatBotModel>> getAll() async {
    Response res = await _dio.get(baseRout + "/all");

    return List<ChatBotModel>.from(
      res.data?.map((x) => ChatBotModel.fromMap(x)),
    );
  }

  Future<ChatBotModel> getById(int id) async {
    Response res = await _dio.get(baseRout + "/$id");

    return ChatBotModel.fromMap(res.data);
  }

  Future<int> update(ChatBotModel newModel) async {
    Response res = await _dio.post(
      baseRout + "/update/${newModel.id}",
      data: newModel.toMap(),
    );

    return res.data;
  }

  Future<int> delete(int id) async {
    Response res = await _dio.delete(
      baseRout + "/delete/$id",
    );

    return res.data;
  }
}
