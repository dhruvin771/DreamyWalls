import 'package:dreamy_walls/const/color.dart';
import 'package:dreamy_walls/storage/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../widgets/cached_image_network_widget.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    getDatabase();
    super.initState();
  }

  bool loading = true;

  List<String> images = [];

  getDatabase() async {
    var db = await DatabaseHelper().getAllImages();
    images = db;
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 5),
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
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text('Favourite',
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
            const SizedBox(height: 8),
            Container(
                width: double.infinity,
                color: Colors.white.withOpacity(0.2),
                height: 0.5),
            Expanded(
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : images.isEmpty
                      ? const Center(
                          child: Text('No Favourite Images.',
                              style: TextStyle(color: Colors.white)))
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: MasonryGridView.builder(
                            itemCount: images.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int i) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 6),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: CustomCachedNetworkImage(
                                  imageUrl: images[i],
                                  index: i,
                                  urls: const {},
                                  onRemove: (index) {
                                    setState(() {});
                                  },
                                ),
                              );
                            },
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }
}
