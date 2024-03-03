import 'package:dreamy_walls/extension/capitalize_words.dart';
import 'package:dreamy_walls/screens/categories/categories_screen.dart';
import 'package:flutter/material.dart';

import '../../animation/page_change_animation.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  List<String> categories = [
    'spring',
    'wallpapers',
    'nature',
    '3d-renders',
    'travel',
    'architecture-interior',
    'textures-patterns',
    'street-photography',
    'film',
    'archival',
    'experimental',
    'animals',
    'fashion-beauty',
    'people',
    'spirituality',
    'business-work',
    'food-drink',
    'health',
    'sports',
    'current-events'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 2)),
        Expanded(
          child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return box(categories[index], index);
              }),
        )
      ],
    );
  }

  Widget box(String title, int i) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
              context, PageChangeAnimation(CategoriesScreen(title))),
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
        if (categories.length == i + 1) ...[const SizedBox(height: 70)]
      ],
    );
  }
}
