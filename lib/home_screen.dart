import 'package:dreamy_walls/providers/bloc/internet_bloc/check_internet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/services/ApiCaller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiCaller apiCaller = ApiCaller();
  int pageIndex = 0;
  int perPage = 30;


  @override
  void initState() {
    homeApiCall();
    super.initState();
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
        print('Response: $response');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<CheckInternetBloc, CheckInternetState>(
          listener: (context, state) {
            if (state is CheckInternetGainedInitialState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Connected"),
                backgroundColor: Colors.green,
              ));
            } else if (state is CheckInternetLostInitialState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Not Connected"),
                backgroundColor: Colors.red,
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Loading...."),
                backgroundColor: Colors.yellow,
              ));
            }
          },
          builder: (context, state) {
            if (state is CheckInternetGainedInitialState) {
              return const Text("Connected");
            } else if (state is CheckInternetLostInitialState) {
              return const Text("Not Connected");
            } else {
              return const Text("Loading...");
            }
          },
        ),
      ),
    );
  }
}
