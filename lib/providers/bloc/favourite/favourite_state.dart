class FavouriteState {
  final List<String> strings;

  FavouriteState(this.strings);

  FavouriteState copyWith({List<String>? strings}) {
    return FavouriteState(strings ?? this.strings);
  }
}
