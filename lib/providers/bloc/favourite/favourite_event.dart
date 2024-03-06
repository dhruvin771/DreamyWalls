abstract class FavouriteEvent {}

class AddStringEvent extends FavouriteEvent {
  final String newString;

  AddStringEvent(this.newString);
}

class DeleteStringEvent extends FavouriteEvent {
  final String stringToDelete;

  DeleteStringEvent(this.stringToDelete);
}

class CheckStringEvent extends FavouriteEvent {
  final String stringToCheck;

  CheckStringEvent(this.stringToCheck);
}
