import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:inshorts/repository/api/get_repository.dart';
import 'package:inshorts/repository/model/news_model.dart';
part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(InitalState()) {
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      emit(ProcessingState());
      final response = await GetRepository().getRequest(
        path: GetRepository.news,
      );
      List<NewsModel> newsList = List<NewsModel>.from(
          response.map((news) => NewsModel.fromJson(news)));
      emit(NewsLoadingSuccessState(newsList: newsList));
    } catch (error) {
      log(error.toString());
      emit(ErrorState(error: error.toString()));
    }
  }
}
