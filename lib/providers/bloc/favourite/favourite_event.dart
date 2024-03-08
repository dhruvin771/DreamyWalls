// event.dart
import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class AddFavoriteEvent extends FavoriteEvent {
  final String string;

  const AddFavoriteEvent(this.string);

  @override
  List<Object> get props => [string];
}

class DeleteFavoriteEvent extends FavoriteEvent {
  final String string;

  const DeleteFavoriteEvent(this.string);

  @override
  List<Object> get props => [string];
}

class CheckFavoriteEvent extends FavoriteEvent {
  final String string;

  const CheckFavoriteEvent(this.string);

  @override
  List<Object> get props => [string];
}
