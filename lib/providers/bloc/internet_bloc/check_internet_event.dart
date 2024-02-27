part of 'check_internet_bloc.dart';

@immutable
abstract class CheckInternetEvent {}

class InternetLostEvent extends CheckInternetEvent{}

class InternetGainedEvent extends CheckInternetEvent{}