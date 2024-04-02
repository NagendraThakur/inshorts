import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts/helper/dialog_utils.dart';
import 'package:inshorts/pages/authentication/cubit/sign_up_cubit.dart';
import 'package:inshorts/shared/shared_pre.dart';
import 'package:inshorts/shared/text_style.dart';
import 'package:inshorts/shared/toast.dart';
import 'package:inshorts/widget/button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.loading == true) {
          DialogUtils.showProcessingDialog(context);
        } else if (state.loading == false) {
          Navigator.of(context).pop();
        } else if (state.hasTokenOnly == true) {
          Navigator.of(context).popAndPushNamed("/interest");
        } else if (state.hasCategory == true) {
          Navigator.of(context).popAndPushNamed("/news");
        } else if (state.message != null) {
          toast(message: state.message!);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'CenturyGothic',
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                    ),
                  ),
                  const Text(
                    "Login to continue",
                    style: TextStyle(
                      color: Colors.white38,
                      fontFamily: 'CenturyGothic',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  CustomButton(
                    buttonText: "",
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.g_mobiledata,
                          color: Colors.white,
                          size: 35,
                        ),
                        Text(
                          "Google",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                    onPressed: () {
                      Future.delayed(
                          Duration.zero,
                          () => BlocProvider.of<SignUpCubit>(context)
                              .googleSignIn());
                    },
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        savePreference(key: "token", value: "token");
                        Navigator.of(context).popAndPushNamed("/interest");
                      },
                      child: Text(
                        "Skip",
                        style: kBodyRegularTextStyle1,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
