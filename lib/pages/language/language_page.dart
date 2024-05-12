import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:inshorts/constants/config.dart';
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
    bool hasLanguage = await hasPreference(key: "language");
    bool hasLog = await hasPreference(key: "log");
    bool hasInterest = await hasPreference(key: "interest");
    bool hasInterestLog = await hasPreference(key: "interestLog");
    bool hasToken = await hasPreference(key: "token");

    print(hasLanguage);
    print(hasLog);
    print(hasInterest);
    print(hasInterestLog);
    print(hasToken);
    if (hasToken) {
      Config.token = await getPreference(key: "token");
    }
    if (hasInterest) {
      String? categoryIdListString = await getPreference(key: "interest");

      if (categoryIdListString != null) {
        List<String> categoryIdStrings = categoryIdListString
            .replaceAll("[", "")
            .replaceAll("]", "")
            .split(", ");

        Config.categoryIdList =
            categoryIdStrings.map((e) => int.parse(e)).toList();
      }
    }
    if (hasLanguage && hasLog && hasInterestLog) {
      Future.delayed(
          Duration.zero, () => Navigator.of(context).popAndPushNamed("/news"));
    } else if (hasLanguage == false) {
      return;
    } else if (hasToken == false && hasLog == false) {
      Future.delayed(Duration.zero,
          () => Navigator.of(context).popAndPushNamed("/sign_up"));
    } else if (hasInterestLog == false) {
      Future.delayed(Duration.zero,
          () => Navigator.of(context).popAndPushNamed("/interest"));
    }
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
                      Navigator.of(context).popAndPushNamed("/sign_up");
                    },
                    child: const Text("     English     ")),
                horizontalSpaceSmall,
                ElevatedButton(
                    onPressed: () {
                      savePreference(key: "language", value: "np");
                      Navigator.of(context).popAndPushNamed("/sign_up");
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
