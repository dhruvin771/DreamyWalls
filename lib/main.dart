import 'package:dreamy_walls/const/color.dart';
import 'package:dreamy_walls/const/string.dart';
import 'package:dreamy_walls/providers/bloc/internet_bloc/check_internet_bloc.dart';
import 'package:dreamy_walls/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: radiumColor),
        useMaterial3: true,
        fontFamily: "QuickSand"
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CheckInternetBloc>(
            create: (BuildContext context) => CheckInternetBloc(),
          ),
        ],
        child: const SplashScreen(),
      ),
    );
  }
}
