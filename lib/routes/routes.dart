import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts/pages/authentication/cubit/sign_up_cubit.dart';
import 'package:inshorts/pages/authentication/sign_up_page.dart';
import 'package:inshorts/pages/bookmark_liked/bookmark_liked_page.dart';
import 'package:inshorts/pages/interest/interest_page.dart';
import 'package:inshorts/pages/language/language_page.dart';
import 'package:inshorts/pages/news/presentation/news_page.dart';
import 'package:inshorts/pages/setting/setting_page.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/language":
        return MaterialPageRoute(builder: (context) => const LanguagePage());
      case "/news":
        return MaterialPageRoute(builder: (context) => const NewsPage());
      case "/bookmark_liked":
        return MaterialPageRoute(
            builder: (context) => const BookmarkLikedPage());
      case "/sign_up":
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SignUpCubit(),
                  child: const SignUpPage(),
                ));
      case "/interest":
        return MaterialPageRoute(builder: (context) => const InterestPage());
      case "/setting":
        return MaterialPageRoute(builder: (context) => const SettingPage());
    }
    return null;
  }
}
