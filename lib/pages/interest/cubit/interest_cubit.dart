import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:inshorts/repository/get_repository.dart';
import 'package:inshorts/repository/post_repository.dart';
import 'package:inshorts/model/category_model.dart';
import 'package:inshorts/shared/shared_pre.dart';
part 'interest_state.dart';

class InterestCubit extends Cubit<InterestState> {
  InterestCubit() : super(InterestState.initial()) {
    fetchCategory();
  }

  Future<void> fetchCategory() async {
    try {
      dynamic response =
          await GetRepository().getRequest(path: GetRepository.interest);
      if (response["status"] == "success") {
        List? data = response["data"];

        List<CategoryModel>? categoryList =
            data?.map((category) => CategoryModel.fromJson(category)).toList();

        emit(state.copyWith(categoryList: categoryList));
      } else {
        emit(state.copyWith(message: "Something Went Wrong"));
      }
    } catch (error) {
      emit(state.copyWith(message: error.toString()));
    }
  }

  Future<void> assignCategory({required List<int> categoryIdList}) async {
    try {
      String body = jsonEncode({"categoryIds": categoryIdList});
      print(body);

      dynamic response = await PostRepository()
          .posRequest(path: PostRepository.linkUserCategory, body: body);
      if (response["status"] == "success") {
        savePreference(key: "interest", value: "interest");
        emit(state.copyWith(success: true));
      } else {
        emit(state.copyWith(message: "Something Went Wrong"));
      }
    } catch (error) {
      emit(state.copyWith(message: error.toString()));
    }
  }
}
