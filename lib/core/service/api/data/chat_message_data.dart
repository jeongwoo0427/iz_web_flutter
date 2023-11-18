import 'package:dio/dio.dart';
import 'package:iz_web_flutter/core/model/chat/message_model.dart';
import 'package:iz_web_flutter/core/service/api/api_service.dart';

class ChatMessageData{
  APIService _apiService = APIService();
  Future<List<MessageModel>> getMessages({required String roomCode}) async{
    String path = '/chat/message/${roomCode}';
    Response response = await _apiService.request(path,method: 'GET');
    List<MessageModel> messages = [];
    for(int i = 0 ; i<response.data.length; i++){
      messages.add(MessageModel.fromMap(response.data[i]));
    }
    return messages;
  }
}