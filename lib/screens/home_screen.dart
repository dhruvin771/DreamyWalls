import 'dart:ui';

import 'package:dreamy_walls/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../animation/page_change_animation.dart';
import '../domain/models/home.dart';
import '../domain/services/api_caller.dart';
import '../widgets/cached_image_network_widget.dart';
import 'image_view_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiCaller apiCaller = ApiCaller();
  int pageIndex = 5;
  int perPage = 30;
  List<Home> masterList = [];
  final ScrollController _scrollController = ScrollController();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    homeApiCall();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      homeApiCall();
    }
  }

  homeApiCall() async {
    final queryParameters = {'page': pageIndex, 'per_page': perPage};
    final result = await apiCaller.homeApi(queryParameters);

    result.fold(
      (failure) {
        SnackBar(
          content: Text('Error: ${failure.errMessage}'),
        );
        setState(() => loading = false);
      },
      (response) {
        if (!mounted) return;
        setState(() => pageIndex++);
        var responseData = response.data;
        for (var item in responseData) {
          if (item['premium'] == false) {
            masterList.add(Home(
              description: item['description'] ?? "",
              urls: Map<String, String>.from(item['urls'] ?? {}),
              userName: item['user']['name'] ?? "",
              userProfileImage: item['user']['profile_image']['large'] ?? "",
              likes: item['likes'] ?? 0,
            ));
          }
        }
        setState(() => loading = false);
      },
    );
  }

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bgColor, systemNavigationBarColor: bgColor));
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0, backgroundColor: bgColor),
        backgroundColor: bgColor,
        body: Stack(children: [
          if (loading)
            Center(child: CircularProgressIndicator(color: radiumColor))
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: MasonryGridView.builder(
                itemCount: masterList.length,
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                itemBuilder: (BuildContext context, int i) {
                  Home home = masterList[i];
                  return GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: CustomCachedNetworkImage(
                        imageUrl: home.urls['small']!,
                        index: i,
                        urls: home.urls,
                        onRemove: (index) {
                          masterList.removeAt(index);
                          setState(() {});
                        },
                      ),
                    ),
                    onTap: () => Navigator.push(
                        context, PageChangeAnimation(ImageViewScreen(home))),
                  );
                },
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                height: size.width * .155,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.15),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 2,
                        sigmaY: 2), // Adjust blur intensity as needed
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black
                            .withOpacity(0.05), // Set opacity using color
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListView.builder(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * .024),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () => setState(
                            () => currentIndex = index,
                          ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 1500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                margin: EdgeInsets.only(
                                  bottom: index == currentIndex
                                      ? 0
                                      : size.width * .029,
                                  right: size.width * .0422,
                                  left: size.width * .0422,
                                ),
                                width: size.width * .128,
                                height: index == currentIndex
                                    ? size.width * .014
                                    : 0,
                                decoration: BoxDecoration(
                                  color: radiumColor,
                                  borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(10),
                                  ),
                                ),
                              ),
                              Icon(
                                listOfIcons[index],
                                size: size.width * .076,
                                color: index == currentIndex
                                    ? radiumColor
                                    : Colors.white,
                              ),
                              SizedBox(height: size.width * .03),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ]));
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.settings_rounded,
    Icons.person_rounded,
  ];
}
