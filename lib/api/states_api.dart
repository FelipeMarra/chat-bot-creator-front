import 'package:chat_bot_creator/api/models/states_models.dart';
import 'package:dio/dio.dart';

class StatesAPI {
  final Dio _dio;

  StatesAPI(this._dio);

  static const String baseRout = "/state/base";

  Future<StateBaseModel> createStateBase(StateBaseModel newState) async {
    Response res;
    try {
      res = await _dio.post(
        baseRout + "/create",
        data: newState.toMap(),
      );
    } on DioError catch (e) {
      return StateBaseModel(
        name: "",
        id: -1,
        chatbotId: -1,
        messages: [],
        transitions: [],
        error: e,
      );
    }

    return StateBaseModel.fromMap(res.data);
  }

  Future<List<StateBaseModel>> getAll(int chatId) async {
    Response res = await _dio.get(baseRout + "/all/$chatId");

    return List<StateBaseModel>.from(
      res.data?.map((x) => StateBaseModel.fromMap(x)),
    );
  }

  Future<StateBaseModel> getById(int id) async {
    Response res = await _dio.get(baseRout + "/$id");

    return StateBaseModel.fromMap(res.data);
  }

  Future<int> update(StateBaseModel newModel) async {
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
