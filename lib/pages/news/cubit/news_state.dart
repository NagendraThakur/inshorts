part of 'news_cubit.dart';

abstract class NewsState {}

class InitalState extends NewsState {}

class ProcessingState extends NewsState {}

class NewsLoadingSuccessState extends NewsState {
  final List<NewsModel>? newsList;

  NewsLoadingSuccessState({required this.newsList});
}

class ErrorState extends NewsState {
  final String error;

  ErrorState({required this.error});
}
