import 'dart:async';

import 'favourite_event.dart';
import 'favourite_state.dart';

class FavouriteBloc {
  final _stateController = StreamController<FavouriteState>.broadcast();
  final _eventController = StreamController<FavouriteEvent>();

  final List<String> _strings = [];

  FavouriteBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  Stream<FavouriteState> get state => _stateController.stream;

  void _mapEventToState(FavouriteEvent event) {
    if (event is AddStringEvent) {
      _strings.add(event.newString);
    } else if (event is DeleteStringEvent) {
      _strings.remove(event.stringToDelete);
    } else if (event is CheckStringEvent) {
      bool exists = _strings.contains(event.stringToCheck);
      _stateController.sink.add(FavouriteState(List.from(_strings)));
      return;
    }
    _stateController.sink.add(FavouriteState(List.from(_strings)));
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }

  void dispatch(FavouriteEvent event) {
    _eventController.sink.add(event);
  }
}
