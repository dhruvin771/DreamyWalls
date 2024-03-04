import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../animation/page_change_animation.dart';
import '../../const/color.dart';
import '../../domain/models/image_model.dart';
import '../../domain/services/api_caller.dart';
import '../../widgets/cached_image_network_widget.dart';
import '../image_view_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
    super.build(context);
    if (loading) {
      return Center(child: CircularProgressIndicator(color: radiumColor));
    } else {
      return MasonryGridView.builder(
        itemCount: masterList.length,
        controller: _scrollController,
        itemBuilder: (BuildContext context, int i) {
          ImageModel home = masterList[i];
          return GestureDetector(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
      );
    }
  }
}
