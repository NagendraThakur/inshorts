import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:inshorts/constants/config.dart';
import 'package:inshorts/repository/api/api.dart';

class GetRepository {
  API api = API();
  static String news = "/v1/news";
  static String interest = "/v1/category";
  static String bookmarked = "/v1/bookmarked-news";
  static String liked = "/v1/liked-news";

  Future<dynamic> getRequest({
    required String path,
    Map<String, dynamic>? additionalHeader,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Map<String, dynamic> headers = {};

      if (Config.token != null) {
        headers.addAll({"Authorization": "Bearer ${Config.token}"});
      }

      if (additionalHeader != null && additionalHeader.isNotEmpty) {
        headers.addAll(additionalHeader);
      }

      print(headers);
      Response response = await api.sendRequest.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (ex) {
      log(ex.toString());
      return null;
    }
  }
}
