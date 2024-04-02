import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts/helper/dialog_utils.dart';
import 'package:inshorts/pages/interest/cubit/interest_cubit.dart';
import 'package:inshorts/model/category_model.dart';
import 'package:inshorts/shared/shared_pre.dart';
import 'package:inshorts/shared/spacing.dart';
import 'package:inshorts/shared/text_style.dart';
import 'package:inshorts/shared/toast.dart';
import 'package:inshorts/widget/button.dart';
import 'package:inshorts/widget/container.dart';

class InterestPage extends StatefulWidget {
  const InterestPage({Key? key}) : super(key: key);

  @override
  State<InterestPage> createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  List<CategoryModel> selectedCategories = [];
  // List<CategoryModel> interestCategories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<InterestCubit>(context).fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InterestCubit, InterestState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state.message != null && state.message!.isNotEmpty) {
          toast(message: state.message!);
        } else if (state.success == true) {
          Navigator.of(context).popAndPushNamed("/news");
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black26,
          appBar: AppBar(
            backgroundColor: Colors.black26,
            title: const Text(
              "INSHORT BOARD",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'CenturyGothic',
                fontWeight: FontWeight.w700,
                fontSize: 32,
                height: 20,
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed("/sign_up");
                  },
                  child: const Text("Login")),
              horizontalSpaceTiny
            ],
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "WHAT INTERESTS YOU?",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'CenturyGothic',
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                  ),
                ),
                verticalSpaceRegular,
                const Text(
                  "Follow #Topic to influence the stories you see",
                  style: TextStyle(
                    color: Colors.white38,
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                  ),
                ),
                verticalSpaceRegular,
                state.categoryList == null
                    ? const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          Text(
                            "Loading..",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    : Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: state.categoryList!.map((category) {
                          final isSelected =
                              selectedCategories.contains(category);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedCategories.remove(category);
                                } else {
                                  selectedCategories.add(category);
                                }
                              });
                            },
                            child: CustomContainer(
                              border: true,
                              color:
                                  isSelected ? Colors.blue : Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "# ${category.name}",
                                  style: isSelected
                                      ? kSubtitleRegularTextStyle.copyWith(
                                          color: Colors.white)
                                      : kSubtitleRegularTextStyle.copyWith(
                                          color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                horizontalPadding: 10,
                buttonText: "Choose at least 3 to continue",
                onPressed: () {
                  if (selectedCategories.length >= 3) {
                    BlocProvider.of<InterestCubit>(context).assignCategory(
                        categoryIdList: selectedCategories
                            .map((category) => category.id!)
                            .toList());
                  } else {
                    toast(message: "Please Select atleast 3");
                  }
                },
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed("/news");
                  },
                  child: const Text("Skip"))
            ],
          ),
        );
      },
    );
  }
}
