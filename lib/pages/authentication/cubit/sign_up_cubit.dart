import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:inshorts/constants/config.dart';
import 'package:inshorts/repository/api/google_access_token.dart';
import 'package:inshorts/repository/api/post_repository.dart';
import 'package:inshorts/model/category_model.dart';
import 'package:inshorts/shared/shared_pre.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState.initial());

  Future<void> googleSignIn() async {
    final accessToken = await GoogleAccessToken().signInWithGoogle();
    log(accessToken.toString());
    if (accessToken != null) {
      try {
        dynamic response = await PostRepository().authPostRequest(
            path: PostRepository.googleAuth, body: {"token": accessToken});

        String token = response["token"];
        List? data = response["category"];

        List<CategoryModel>? categoryList =
            data?.map((category) => CategoryModel.fromJson(category)).toList();

        Config.token = token;
        savePreference(key: "token", value: token);

        if (categoryList != null && categoryList.isNotEmpty) {
          emit(state.copyWith(hasCategory: true));
        } else {
          emit(state.copyWith(hasTokenOnly: true));
        }
        GoogleAccessToken().signOutFromGoogle();
      } catch (error) {
        emit(state.copyWith(message: error.toString()));
      }
    } else {
      emit(state.copyWith(message: "Google Sign-In Failed"));
    }
  }
}
