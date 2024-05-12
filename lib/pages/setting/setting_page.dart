import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts/constants/config.dart';
import 'package:inshorts/model/page_list_model.dart';
import 'package:inshorts/pages/news/cubit/news_cubit.dart';
import 'package:inshorts/shared/spacing.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final List<PageListModel> pageList = [
    PageListModel(
        icon: CupertinoIcons.bookmark,
        label: "Saved bookMarks",
        path: "/bookmark"),
    PageListModel(
        icon: CupertinoIcons.heart, label: "Saved likes", path: "/likes"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        leading: const CupertinoNavigationBarBackButton(),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: pageList.length,
          itemBuilder: (BuildContext context, int index) {
            PageListModel page = pageList[index];
            return InkWell(
              onTap: () {
                if (Config.token == null) {
                  Navigator.of(context).pushNamed("/sign_up");
                } else if (page.path == "/bookmark") {
                  BlocProvider.of<NewsCubit>(context)
                      .fetchBookMarks(context: context);
                  Navigator.of(context).pushNamed("/bookmark_liked");
                } else if (page.path == "/likes") {
                  BlocProvider.of<NewsCubit>(context)
                      .fetchLiked(context: context);
                  Navigator.of(context).pushNamed("/bookmark_liked");
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      horizontalSpaceRegular,
                      Icon(page.icon),
                      horizontalSpaceRegular,
                      Text(page.label),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
