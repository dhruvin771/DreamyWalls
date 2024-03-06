import 'package:dreamy_walls/const/color.dart';
import 'package:dreamy_walls/extension/capitalize_words.dart';
import 'package:dreamy_walls/screens/search/search_result_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../animation/page_change_animation.dart';
import '../../domain/services/api_caller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  final ApiCaller apiCaller = ApiCaller();
  List<String> searchResult = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
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
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text('Search',
                      style: TextStyle(
                          color: radiumColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600)),
                ),
                const Spacer(),
                const SizedBox(width: 35)
              ],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CupertinoTextField(
              controller: searchController,
              placeholder: 'Search',
              placeholderStyle: const TextStyle(color: Colors.grey),
              onChanged: (text) {
                liveSearch();
              },
              suffix: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    PageChangeAnimation(
                        SearchResultScreen(searchController.text))),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    CupertinoIcons.search,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          Container(
              width: double.infinity,
              color: Colors.white.withOpacity(0.2),
              height: 0.5),
          Expanded(
            child: ListView.builder(
                itemCount: searchResult.length,
                itemBuilder: (BuildContext context, int index) {
                  return box(searchResult[index], index);
                }),
          )
        ]),
      ),
    );
  }

  liveSearch() async {
    final result = await apiCaller.liveSearchApi(searchController.text);
    result.fold(
      (failure) {
        SnackBar(
          content: Text('Error: ${failure.errMessage}'),
        );
      },
      (response) {
        if (!mounted) return;
        var responseData = response.data['fuzzy'];
        searchResult.clear();
        for (var item in responseData) {
          searchResult.add(item['query']);
        }
        setState(() {});
      },
    );
  }

  Widget box(String title, int i) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
              context, PageChangeAnimation(SearchResultScreen(title))),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    title.capitalizeAndReplaceHyphens(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
