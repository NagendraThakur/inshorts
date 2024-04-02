// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_cubit.dart';

class SignUpState {
  final bool? loading;
  final String? message;

  final bool? hasTokenOnly;
  final bool? hasCategory;

  SignUpState(
      {this.loading, this.message, this.hasTokenOnly, this.hasCategory});

  factory SignUpState.initial() {
    return SignUpState();
  }

  SignUpState copyWith({
    bool? loading,
    String? message,
    bool? hasTokenOnly,
    bool? hasCategory,
  }) {
    return SignUpState(
      loading: loading,
      message: message,
      hasTokenOnly: hasTokenOnly,
      hasCategory: hasCategory,
    );
  }
}
