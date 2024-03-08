import 'package:flutter_bloc/flutter_bloc.dart';

import 'favourite_event.dart';
import 'favourite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial());

  final List<String> _favoriteList = [];

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is AddFavoriteEvent) {
      _favoriteList.add(event.string);
      yield FavoriteLoaded(_favoriteList);
    } else if (event is DeleteFavoriteEvent) {
      _favoriteList.remove(event.string);
      yield FavoriteLoaded(_favoriteList);
    } else if (event is CheckFavoriteEvent) {
      // Check if the favorite list contains the given string
      bool isAvailable = _favoriteList.contains(event.string);
      // Emit the state indicating whether the item is available in favorites
      yield FavoriteChecked(isAvailable);
    }
  }
}
