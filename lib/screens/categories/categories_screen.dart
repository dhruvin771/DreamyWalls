import 'package:dreamy_walls/extension/capitalize_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../animation/page_change_animation.dart';
import '../../const/color.dart';
import '../../domain/models/image_model.dart';
import '../../domain/services/api_caller.dart';
import '../../widgets/cached_image_network_widget.dart';
import '../image_view_screen.dart';

class CategoriesScreen extends StatefulWidget {
  final String title;

  const CategoriesScreen(this.title, {super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final ApiCaller apiCaller = ApiCaller();
  int pageIndex = 1;
  int perPage = 30;
  List<ImageModel> masterList = [];
  final ScrollController _scrollController = ScrollController();
  bool loading = true;
  Color dividerColor = Colors.transparent;

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
        _scrollController.position.minScrollExtent) {
      setState(() => dividerColor = Colors.transparent);
    } else {
      setState(() => dividerColor = Colors.white.withOpacity(0.2));
    }
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      homeApiCall();
    }
  }

  homeApiCall() async {
    final queryParameters = {'page': pageIndex, 'per_page': perPage};
    final result = await apiCaller.categoriesApi(queryParameters, widget.title);

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
            masterList.add(ImageModel(
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
    return Scaffold(
        appBar: AppBar(backgroundColor: bgColor, toolbarHeight: 0),
        backgroundColor: bgColor,
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons.arrow_back_sharp,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(widget.title.capitalizeAndReplaceHyphens(),
                        style: TextStyle(
                            color: radiumColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w600)),
                  ),
                  Spacer(),
                  SizedBox(width: 35)
                ],
              ),
            ),
            Container(
                width: double.infinity,
                color: Colors.white.withOpacity(0.2),
                height: 0.5),
            Expanded(
              child: loading
                  ? Center(child: CircularProgressIndicator(color: radiumColor))
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: MasonryGridView.builder(
                        itemCount: masterList.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: _scrollController,
                        itemBuilder: (BuildContext context, int i) {
                          ImageModel home = masterList[i];
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
                            onTap: () => Navigator.push(context,
                                PageChangeAnimation(ImageViewScreen(home))),
                          );
                        },
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                      ),
                    ),
            ),
          ],
        ));
  }
}
