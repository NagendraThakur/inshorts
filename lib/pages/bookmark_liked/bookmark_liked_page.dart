import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts/constants/config.dart';
import 'package:inshorts/pages/category/bottom_sheet_utils.dart';
import 'package:inshorts/pages/news/cubit/news_cubit.dart';
import 'package:inshorts/pages/news/portion/video_player_widget.dart';
import 'package:inshorts/pages/web_view/web_view_screen.dart';
import 'package:inshorts/model/news_model.dart';
import 'package:inshorts/shared/shared_pre.dart';
import 'package:inshorts/shared/spacing.dart';
import 'package:inshorts/shared/toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

class BookmarkLikedPage extends StatefulWidget {
  const BookmarkLikedPage({Key? key}) : super(key: key);

  @override
  _BookmarkLikedPageState createState() => _BookmarkLikedPageState();
}

class _BookmarkLikedPageState extends State<BookmarkLikedPage> {
  final PageController _pageController = PageController();
  List<NewsModel>? _newsList = [];
  int _currentIndex = 0;
  // bool _visible = true;
  String _language = "default";
  int _page = 1;

  Color _getColorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state is ErrorState) {
            toast(message: state.error);
          } else if (state is LanguageState) {
            _language = state.language;
          } else if (state is NewsLoadingSuccessState) {
            _newsList = state.newsList;
          }
        },
        builder: (context, state) {
          if (_newsList != null && _newsList!.isNotEmpty) {
            return _buildNewsStack(width, height);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Stack _buildNewsStack(double width, double height) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: _newsList?.length,
          onPageChanged: (index) {
            // if (index > _currentIndex && index % 5 == 0) {
            //   _page += 1;
            //   BlocProvider.of<NewsCubit>(context)
            //       .fetchAdditionalNews(page: _page);
            // }
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            final NewsModel news = _newsList![index];
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Center(
                key: ValueKey<int>(_currentIndex),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                            height: height,
                            child:
                                _buildImageSection(news, width, height, index)),
                        Positioned(
                            top: height * 0.38,
                            left: width * 0.03,
                            child: _buildContentSection(news, width, height)),
                        Positioned(
                          bottom: 0,
                          child: SizedBox(
                            width: width,
                            height: 90,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // _buildCategoryButton(context),
                                  const SizedBox.shrink(),
                                  _buildLikeButton(news, index),
                                  _buildUpvoteButton(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Positioned(
          top: -35,
          left: 0,
          right: 0,
          child: Container(
            height: 100,
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLanguageButton(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _buildRefreshButton(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageSection(
      NewsModel news, double width, double height, int index) {
    return Column(
      children: [
        Stack(
          children: [
            if (news.mediaType == "image")
              CachedNetworkImage(
                imageUrl: news.media,
                fit: BoxFit.cover,
                width: width,
                height: height * 0.4,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: width,
                    height: height * 0.4,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            else if (news.mediaType == "video")
              SizedBox(
                  width: width,
                  height: height * 0.4,
                  child: VideoPlayerWidget(videoUrl: news.media)),
            Positioned(
              top: height * 0.32,
              right: 10,
              child: CircleAvatar(
                child: IconButton(
                    onPressed: () {
                      if (Config.token == null) {
                        Navigator.of(context).pushNamed("/sign_up");
                        return;
                      }
                      BlocProvider.of<NewsCubit>(context)
                          .createBookMark(newId: news.id);
                      setState(() {
                        _newsList![index] = _newsList![index].copyWith(
                            isBookMarked: !_newsList![index].isBookMarked!);
                      });
                    },
                    icon: Icon(
                      CupertinoIcons.bookmark_solid,
                      color: news.isBookMarked == true ? Colors.blue : null,
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContentSection(NewsModel news, double width, double height) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        width: width * 0.94,
        height: height * 0.5,
        decoration: BoxDecoration(
          color: _getColorFromHex(news.category?.categoryColor ?? '#FFFFFF'),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceSmall,
              Text(
                news.category?.name?.toUpperCase() ?? "",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                _language == "en" ? news.enTitle : news.npTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              Text(
                _language == "en" ? news.enContent : news.npContent,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  if (news.url != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewPage(
                          url: news.url!,
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  "${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()).toString()}. By Raju",
                  style: TextStyle(color: Colors.grey.shade400),
                ),
              ),
              verticalSpaceSmall
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context) {
    return InkWell(
      onTap: () {
        BottomSheetUtils.categoryBottomSheet(context);
      },
      child: const CircleAvatar(
        child: Icon(CupertinoIcons.square_grid_2x2),
      ),
    );
  }

  Widget _buildLikeButton(NewsModel news, int index) {
    return CircleAvatar(
      child: IconButton(
          onPressed: () {
            if (Config.token == null) {
              Navigator.of(context).pushNamed("/sign_up");
              return;
            }
            BlocProvider.of<NewsCubit>(context).createLike(newId: news.id);
            setState(() {
              _newsList![index] = _newsList![index]
                  .copyWith(isLiked: !_newsList![index].isLiked!);
            });
          },
          icon: Icon(
            CupertinoIcons.heart_fill,
            color: news.isLiked == true ? Colors.red : null,
          )),
    );
  }

  Widget _buildUpvoteButton() {
    return InkWell(
      onTap: () async {
        // Add your upvote logic here
        await Share.share("Npshorts News");
      },
      child: const CircleAvatar(
        child: Icon(CupertinoIcons.square_arrow_up),
      ),
    );
  }

  Widget _buildLanguageButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: InkWell(
        onTap: () {
          if (_language == "en") {
            savePreference(key: "language", value: "np");
            _language = "np";
          } else {
            savePreference(key: "language", value: "en");
            _language = "en";
          }
          setState(() {});
        },
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircleAvatar(
            child: Text(
              _language == "en" ? "NP" : "EN",
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRefreshButton() {
    return _currentIndex == 0
        ? InkWell(
            onTap: () => BlocProvider.of<NewsCubit>(context).fetchInitialNews(),
            child: const SizedBox(
              width: 30,
              height: 30,
              child: CircleAvatar(
                child: Icon(
                  CupertinoIcons.refresh,
                  size: 15,
                ),
              ),
            ),
          )
        : InkWell(
            onTap: () {
              _pageController.animateToPage(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: const SizedBox(
              width: 30,
              height: 30,
              child: CircleAvatar(
                child: Icon(
                  CupertinoIcons.up_arrow,
                  size: 15,
                ),
              ),
            ),
          );
  }
}
