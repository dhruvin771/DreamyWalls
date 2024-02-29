import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'domain/services/ApiCaller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiCaller apiCaller = ApiCaller();
  int pageIndex = 5;
  int perPage = 30;
  List<Map<String, dynamic>> masterList = [];
  final ScrollController _scrollController = ScrollController();

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
      },
      (response) {
        if (!mounted) return;
        setState(() => pageIndex++);
        var responseData = response.data;
        for (var item in responseData) {
          if (item['premium'] == false) {
            masterList.add(item);
            setState(() {});
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: MasonryGridView.builder(
          itemCount: masterList.length,
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                    imageUrl: masterList[index]['urls']['small']),
              ),
            );
          },
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
        ),
      ),
    );
  }
}
