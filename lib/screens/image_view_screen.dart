import 'package:dreamy_walls/const/color.dart';
import 'package:dreamy_walls/domain/models/image_model.dart';
import 'package:dreamy_walls/extension/capitalize_words.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/cached_image_network_widget.dart';

class ImageViewScreen extends StatefulWidget {
  final ImageModel imageDetails;

  const ImageViewScreen(this.imageDetails, {Key? key}) : super(key: key);

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  Color dividerColor = Colors.transparent;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
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
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
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
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 22,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(width: double.infinity, color: dividerColor, height: 0.5),
            Expanded(
              child: Scrollbar(
                thickness: 0.5,
                radius: const Radius.circular(1),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10, top: 2),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CustomCachedNetworkImage(
                              imageUrl: widget.imageDetails.urls['small']!,
                              index: 0,
                              urls: widget.imageDetails.urls,
                              onRemove: (index) {},
                            ),
                            CustomCachedNetworkImage(
                              imageUrl: widget.imageDetails.urls['regular']!,
                              index: 0,
                              urls: widget.imageDetails.urls,
                              onRemove: (index) {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => _launchInBrowserView(
                              Uri.parse(widget.imageDetails.userPage)),
                          child: Container(
                            color: Colors.white.withOpacity(0.0001),
                            child: Row(children: [
                              const SizedBox(width: 5),
                              SizedBox(
                                height: 22,
                                width: 22,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CustomCachedNetworkImage(
                                    imageUrl:
                                        widget.imageDetails.userProfileImage,
                                    index: 0,
                                    urls: widget.imageDetails.urls,
                                    onRemove: (index) {},
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                  widget.imageDetails.userName
                                      .toString()
                                      .capitalizeWords(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12))
                            ]),
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (widget.imageDetails.description.isNotEmpty) ...[
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(15)),
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              widget.imageDetails.description,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchInBrowserView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }
}
