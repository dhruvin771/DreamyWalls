import 'package:dreamy_walls/const/color.dart';
import 'package:dreamy_walls/domain/models/home.dart';
import 'package:dreamy_walls/extension/capitalize_words.dart';
import 'package:flutter/material.dart';

import '../widgets/cached_image_network_widget.dart';

class ImageViewScreen extends StatefulWidget {
  final Home imageDetails;

  const ImageViewScreen(this.imageDetails, {Key? key}) : super(key: key);

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Scrollbar(
          thickness: 0.5,
          radius: const Radius.circular(1),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
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
                  const SizedBox(height: 12),
                  Row(children: [
                    const SizedBox(width: 5),
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CustomCachedNetworkImage(
                          imageUrl: widget.imageDetails.userProfileImage,
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
                        style: const TextStyle(color: Colors.white))
                  ]),
                  const SizedBox(height: 12),
                  if (widget.imageDetails.description.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.all(10),
                      child: Text(widget.imageDetails.description,
                          style: const TextStyle(color: Colors.white)),
                    )
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
