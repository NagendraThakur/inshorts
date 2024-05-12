import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts/model/category_model.dart';
import 'package:inshorts/pages/interest/cubit/interest_cubit.dart';
import 'package:inshorts/pages/news/cubit/news_cubit.dart';
import 'package:inshorts/shared/spacing.dart';
import 'package:inshorts/shared/text_style.dart';
import 'package:inshorts/widget/border_text_field.dart';

class BottomSheetUtils {
  static Color _getColorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static void categoryBottomSheet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      scrollControlDisabledMaxHeightRatio: 0.95,
      builder: (BuildContext context) {
        return BlocBuilder<InterestCubit, InterestState>(
          builder: (context, state) {
            return Column(
              children: [
                verticalSpaceRegular,
                BorderTextField(
                  width: width * 0.95,
                  hintText: "Search news here",
                  prefixIcon: const Icon(CupertinoIcons.search),
                  onChanged: (String? value) {},
                ),
                verticalSpaceLarge,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "   Category",
                    style: kSubtitleTextStyle,
                  ),
                ),
                verticalSpaceRegular,
                SingleChildScrollView(
                  child: SizedBox(
                    height: height * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: state.categoryList == null ||
                              state.categoryList!.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 160,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemCount: (state.categoryList?.length ?? 0),
                              itemBuilder: (BuildContext context, int index) {
                                CategoryModel category =
                                    state.categoryList![index];

                                return InkWell(
                                  onTap: () {
                                    BlocProvider.of<NewsCubit>(context)
                                        .fetchSingleCategoryNews(
                                            categoryId: category.id.toString());
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _getColorFromHex(
                                          category.categoryColor!),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        category.name!,
                                        style: kHeading3TextStyle.copyWith(
                                            // color: textColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: const CircleAvatar(
                              child: Icon(CupertinoIcons.chevron_down))),
                      InkWell(
                          onTap: () =>
                              Navigator.of(context).pushNamed("/setting"),
                          child:
                              const CircleAvatar(child: Icon(Icons.settings)))
                    ],
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
