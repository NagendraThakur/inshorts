part of 'interest_cubit.dart';

class InterestState {
  final bool? isLoading;
  final String? message;
  final List<CategoryModel>? categoryList;
  final bool? success;

  InterestState({
    this.isLoading,
    this.message,
    this.categoryList,
    this.success,
  });

  factory InterestState.initial() {
    return InterestState();
  }

  InterestState copyWith({
    bool? isLoading,
    String? message,
    List<CategoryModel>? categoryList,
    bool? success,
  }) {
    return InterestState(
      isLoading: isLoading,
      message: message,
      categoryList: categoryList ?? this.categoryList,
      success: success,
    );
  }
}
