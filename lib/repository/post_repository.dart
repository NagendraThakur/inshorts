import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:inshorts/constants/config.dart';
import 'package:inshorts/repository/api/api.dart';
import 'package:inshorts/shared/toast.dart';

class PostRepository {
  API api = API();
  static String googleAuth = "/v1/auth/sign-in";
  static String linkUserCategory = "/v1/link-user-category";
  static String createLike = "/v1/like";
  static String createBookMark = "/v1/bookmark";

  Future<dynamic> posRequest(
      {required String path, String? editId, required Object body}) async {
    try {
      Map<String, dynamic> headers = {};

      if (Config.token != null) {
        headers.addAll({"Authorization": "Bearer ${Config.token}"});
      }

      print(headers);
      editId != null && editId.isNotEmpty ? path = "$path/$editId" : null;
      Response response = await api.sendRequest.post(
        path,
        data: body,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        return responseData;
      } else {
        return null;
      }
    } catch (ex) {
      if (ex is DioException && ex.error is SocketException) {
        toast(message: "No Internet Connection");
      }
      log(ex.toString());
      return null;
    }
  }

  Future<dynamic> authPostRequest(
      {required String path, required Object body}) async {
    try {
      Response response = await api.sendRequest.post(path, data: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        return responseData;
      } else {
        return null;
      }
    } catch (ex) {
      if (ex is DioException && ex.error is SocketException) {
        toast(message: "No Internet Connection");
      }
      log(ex.toString());
      return null;
    }
  }
}
