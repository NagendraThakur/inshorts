import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts/model/category_model.dart';
import 'package:inshorts/pages/interest/cubit/interest_cubit.dart';
import 'package:inshorts/shared/spacing.dart';
import 'package:inshorts/shared/text_style.dart';
import 'package:inshorts/widget/border_text_field.dart';
import 'package:inshorts/widget/container.dart';

class BottomSheetUtils {
  static void categoryBottomSheet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                  width: width * 0.8,
                  hintText: "Search news here",
                  prefixIcon: const Icon(CupertinoIcons.search),
                  onChanged: (String? value) {},
                ),
                verticalSpaceLarge,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "   Category",
                    style: kSubtitleRegularTextStyle,
                  ),
                ),
                verticalSpaceRegular,
                GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 160,
                  ),
                  itemCount: (state.categoryList?.length ?? 0),
                  itemBuilder: (BuildContext context, int index) {
                    CategoryModel category = state.categoryList![index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: CustomContainer(
                        border: true,
                        outerVerticalPadding: 0,
                        outerHorizontalPadding: 0,
                        child: Center(child: Text(category.name!)),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
