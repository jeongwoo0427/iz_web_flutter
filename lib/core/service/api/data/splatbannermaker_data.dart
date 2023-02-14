import 'package:dio/dio.dart';
import 'package:iz_web_flutter/core/model/splatbannermaker/receipt_model.dart';
import 'package:iz_web_flutter/core/service/api/api_service.dart';

class SplatBannerMakerData{
  APIService _apiService = APIService();

  Future<ReceiptModel?> newReceipt(ReceiptModel receiptModel) async{
    Response response = await _apiService.request('/splatBannerMaker',method: 'POST',data: receiptModel.toMap());
    if(response.data.length==0) return null;
    return ReceiptModel.fromMap(response.data);
  }
}