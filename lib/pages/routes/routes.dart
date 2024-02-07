import 'package:flutter/material.dart';
import 'package:inshorts/pages/language/language_page.dart';
import 'package:inshorts/pages/news/presentation/news_page.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/language":
        return MaterialPageRoute(builder: (context) => const LanguagePage());
      case "/news":
        return MaterialPageRoute(builder: (context) => const NewsPage());
    }
  }
}
