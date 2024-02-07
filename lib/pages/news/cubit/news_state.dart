// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'news_cubit.dart';

abstract class NewsState {}

class InitalState extends NewsState {}

class LanguageState extends NewsState {
  final String language;

  LanguageState({required this.language});
}

class ProcessingState extends NewsState {}

class NewsLoadingSuccessState extends NewsState {
  final List<NewsModel>? newsList;

  NewsLoadingSuccessState({required this.newsList});

  NewsLoadingSuccessState copyWith({
    List<NewsModel>? newsList,
  }) {
    return NewsLoadingSuccessState(
      newsList: newsList ?? this.newsList,
    );
  }
}

class ErrorState extends NewsState {
  final String error;

  ErrorState({required this.error});
}
