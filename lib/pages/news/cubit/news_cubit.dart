import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:inshorts/constants/config.dart';
import 'package:inshorts/repository/get_repository.dart';
import 'package:inshorts/model/news_model.dart';
import 'package:inshorts/repository/post_repository.dart';
import 'package:inshorts/shared/shared_pre.dart';
import 'package:inshorts/shared/toast.dart';
part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(InitalState());

  Future<void> createBookMark({required String newId}) async {
    PostRepository().posRequest(
        path: PostRepository.createBookMark, editId: newId, body: {});
  }

  Future<void> createLike({required String newId}) async {
    PostRepository()
        .posRequest(path: PostRepository.createLike, editId: newId, body: {});
  }

  Future<void> fetchInitialNews() async {
    try {
      emit(ProcessingState());
      String? lang = await getPreference(key: "language");
      emit(LanguageState(language: lang!));
      final response = await GetRepository().getRequest(
          path: GetRepository.news,
          additionalHeader: Config.categoryIdList != null
              ? {"categoryIds": Config.categoryIdList}
              : null,
          queryParameters: {"page": 1});
      List data = response["data"];
      List<NewsModel> newsList =
          List<NewsModel>.from(data.map((news) => NewsModel.fromJson(news)));
      emit(NewsLoadingSuccessState(newsList: newsList));
    } catch (error) {
      log(error.toString());
      emit(ErrorState(error: error.toString()));
    }
  }

  Future<void> fetchBookMarks({required BuildContext context}) async {
    try {
      emit(NewsLoadingSuccessState(newsList: []));
      String? lang = await getPreference(key: "language");
      emit(LanguageState(language: lang!));
      final response = await GetRepository().getRequest(
        path: GetRepository.bookmarked,
      );
      List data = response["data"];
      List<NewsModel> newsList =
          List<NewsModel>.from(data.map((news) => NewsModel.fromJson(news)));

      emit(NewsLoadingSuccessState(newsList: newsList));
      if (newsList.isEmpty) {
        toast(message: "No BookMarks");
        Navigator.of(context).pop();
      }
    } catch (error) {
      log(error.toString());
      emit(ErrorState(error: error.toString()));
    }
  }

  Future<void> fetchLiked({required BuildContext context}) async {
    try {
      emit(NewsLoadingSuccessState(newsList: []));
      String? lang = await getPreference(key: "language");
      emit(LanguageState(language: lang!));
      final response = await GetRepository().getRequest(
        path: GetRepository.liked,
      );
      List data = response["data"];
      List<NewsModel> newsList =
          List<NewsModel>.from(data.map((news) => NewsModel.fromJson(news)));
      emit(NewsLoadingSuccessState(newsList: newsList));
      if (newsList.isEmpty) {
        toast(message: "No Likes");
        Navigator.of(context).pop();
      }
    } catch (error) {
      log(error.toString());
      emit(ErrorState(error: error.toString()));
    }
  }

  Future<void> fetchSingleCategoryNews({required String categoryId}) async {
    try {
      emit(NewsLoadingSuccessState(newsList: []));
      String? lang = await getPreference(key: "language");
      emit(LanguageState(language: lang!));
      final response = await GetRepository().getRequest(
          path: GetRepository.news,
          queryParameters: {"page": 1, "category_id": categoryId});
      List data = response["data"];
      List<NewsModel> newsList =
          List<NewsModel>.from(data.map((news) => NewsModel.fromJson(news)));
      emit(NewsLoadingSuccessState(newsList: newsList));
    } catch (error) {
      log(error.toString());
      emit(ErrorState(error: error.toString()));
    }
  }

  Future<void> fetchAdditionalNews({required int page}) async {
    try {
      String? lang = await getPreference(key: "language");
      final response = await GetRepository().getRequest(
          path: GetRepository.news,
          queryParameters: {"lang": lang, "page": page});
      List data = response["data"];
      List<NewsModel> additionalNewsList =
          List<NewsModel>.from(data.map((news) => NewsModel.fromJson(news)));
      NewsState currentState = state;
      if (currentState is NewsLoadingSuccessState) {
        List<NewsModel> updatedNewsList = List.of(currentState.newsList ?? [])
          ..addAll(additionalNewsList);
        emit(currentState.copyWith(newsList: updatedNewsList));
      } else {
        emit(ErrorState(error: "Unexpected state"));
      }
    } catch (error) {
      log(error.toString());
      emit(ErrorState(error: error.toString()));
    }
  }
}
