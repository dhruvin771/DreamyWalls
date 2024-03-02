import 'package:dreamy_walls/animation/page_change_animation.dart';
import 'package:dreamy_walls/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const/color.dart';
import '../utilities/cache_util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(context, PageChangeAnimation(const HomeScreen()));
    });
    CacheUtil.checkLastCacheClear();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bgColor, systemNavigationBarColor: bgColor));
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: bgColor),
      backgroundColor: bgColor,
      body: Center(
          child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset('assets/logo/appicon.jpg', width: 200, height: 200),
      )),
    );
  }
}
