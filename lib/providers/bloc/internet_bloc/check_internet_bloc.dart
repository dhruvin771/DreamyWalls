import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'check_internet_event.dart';
part 'check_internet_state.dart';

class CheckInternetBloc extends Bloc<CheckInternetEvent, CheckInternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? streamSubscription;

  CheckInternetBloc() : super(CheckInternetInitialState()) {
    on<InternetLostEvent>(
        (event, emit) => emit(CheckInternetLostInitialState()));
    on<InternetGainedEvent>(
        (event, emit) => emit(CheckInternetGainedInitialState()));

    streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        add(InternetGainedEvent());
      } else {
        add(InternetLostEvent());
      }
    });
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
