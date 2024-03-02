extension CapitalizeWordsExtension on String {
  String capitalizeWords() {
    return replaceAllMapped(
      RegExp(r'\b\w'),
      (match) => match.group(0)!.toUpperCase(),
    ).replaceFirstMapped(
      RegExp(r'(\b\w)(\w+)'),
      (match) => '${match.group(1)}${match.group(2)!.toLowerCase()}',
    );
  }
}
