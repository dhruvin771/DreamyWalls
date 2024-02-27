part of 'check_internet_bloc.dart';

@immutable
abstract class CheckInternetState {}

class CheckInternetInitialState extends CheckInternetState {}
class CheckInternetLostInitialState extends CheckInternetState {}
class CheckInternetGainedInitialState extends CheckInternetState {}