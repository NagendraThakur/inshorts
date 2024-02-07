import 'package:flutter/material.dart';
import 'package:inshorts/shared/shared_pre.dart';
import 'package:inshorts/shared/spacing.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  void initState() {
    super.initState();
    languagecheck();
  }

  languagecheck() async {
    await hasPreference(key: "language")
        ? Navigator.of(context).popAndPushNamed("/news")
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Choose your language",
              style: TextStyle(fontSize: 24),
            ),
            const Text(
              "आफ्नो भाषा छान्नुहोस्",
              style: TextStyle(fontSize: 18),
            ),
            verticalSpaceLarge,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      savePreference(key: "language", value: "en");
                      Navigator.of(context).popAndPushNamed("/news");
                    },
                    child: const Text("     English     ")),
                horizontalSpaceSmall,
                ElevatedButton(
                    onPressed: () {
                      savePreference(key: "language", value: "np");
                      Navigator.of(context).popAndPushNamed("/news");
                    },
                    child: const Text("     Nepali     ")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
