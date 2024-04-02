import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts/pages/news/cubit/news_cubit.dart';
import 'package:flutter/services.dart';
import 'package:inshorts/routes/routes.dart';
import 'package:inshorts/pages/interest/cubit/interest_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()),
        BlocProvider(create: (context) => InterestCubit()),
      ],
      child: MaterialApp(
        title: 'Inshorts',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontFamily: 'CenturyGothic',
            ),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: "/language",
      ),
    );
  }
}
