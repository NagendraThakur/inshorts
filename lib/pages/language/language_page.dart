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
    bool hasInterest = await hasPreference(key: "interest");

    bool hasToken = await hasPreference(key: "token");
    if (hasToken) {
      Config.token = await getPreference(key: "token");
    }
    if (hasLanguage && hasToken && hasInterest) {
      Future.delayed(
          Duration.zero, () => Navigator.of(context).popAndPushNamed("/news"));
    } else if (hasLanguage == false) {
      return;
    } else if (hasToken == false) {
      Future.delayed(Duration.zero,
          () => Navigator.of(context).popAndPushNamed("/sign_up"));
    } else if (hasInterest == false) {
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
