import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:inshorts/repository/api/get_repository.dart';
import 'package:inshorts/model/news_model.dart';
import 'package:inshorts/shared/shared_pre.dart';
part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(InitalState()) {
    fetchInitialNews();
  }

  Future<void> fetchInitialNews() async {
    try {
      emit(ProcessingState());
      String? lang = await getPreference(key: "language");
      emit(LanguageState(language: lang!));
      final response = await GetRepository()
          .getRequest(path: GetRepository.news, queryParameters: {"page": 1});
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
