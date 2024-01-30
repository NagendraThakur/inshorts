import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts/pages/news/cubit/news_cubit.dart';
import 'package:inshorts/pages/web_view/web_view_screen.dart';
import 'package:inshorts/repository/model/news_model.dart';
import 'package:inshorts/shared/spacing.dart';
import 'package:inshorts/shared/toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final List<String> items = List.generate(20, (index) => 'Item ${index + 1}');
  final PageController pageController = PageController();
  int currentIndex = 0;
  bool _visible = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state is ErrorState) {
            toast(message: state.error);
          }
        },
        builder: (context, state) {
          if (state is ProcessingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NewsLoadingSuccessState) {
            List<NewsModel>? newsList = state.newsList;
            return Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: newsList?.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    NewsModel news = newsList![index];
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Center(
                        key: ValueKey<int>(currentIndex),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: news.image,
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
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            verticalSpaceRegular,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _visible = !_visible;
                                  });
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: SizedBox(
                                  width: width,
                                  height: height * 0.45,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        news.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 26,
                                          height: 1.5,
                                        ),
                                      ),
                                      Text(
                                        news.content,
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                if (news.urlTitle != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WebViewPage(
                                                url: news.url!,
                                              )));
                                }
                              },
                              child: Container(
                                width: width,
                                height: 90,
                                color: Colors.black87,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "To view ${news.title.substring(0, 10)} post",
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w200,
                                          fontSize: 18,
                                          height: 1.5,
                                        ),
                                      ),
                                      const Text(
                                        "Tab here",
                                        style: TextStyle(
                                          color: Colors.white38,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 16,
                                          // height: 1.5,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Visibility(
                    visible: _visible,
                    child: Container(
                      height: 100,
                      color: Colors.white,
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox.shrink(),
                          const Text(
                            '             My Feed',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              height: 1.5,
                            ),
                          ),
                          currentIndex == 0
                              ? CupertinoButton(
                                  child: const Icon(
                                    CupertinoIcons.refresh,
                                  ),
                                  onPressed: () =>
                                      BlocProvider.of<NewsCubit>(context)
                                          .fetchNews(),
                                )
                              : CupertinoButton(
                                  child: const Icon(
                                    CupertinoIcons.up_arrow,
                                  ),
                                  onPressed: () {
                                    pageController.animateToPage(
                                      0,
                                      duration: const Duration(
                                          milliseconds:
                                              500), // Adjust the duration as needed
                                      curve: Curves
                                          .easeInOut, // Adjust the curve as needed
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
