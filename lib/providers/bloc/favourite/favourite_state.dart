// state.dart

import 'package:equatable/equatable.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<String> favoriteList;

  const FavoriteLoaded(this.favoriteList);

  @override
  List<Object> get props => [favoriteList];
}

class FavoriteChecked extends FavoriteState {
  final bool isAvailable;

  const FavoriteChecked(this.isAvailable);

  @override
  List<Object> get props => [isAvailable];
}
