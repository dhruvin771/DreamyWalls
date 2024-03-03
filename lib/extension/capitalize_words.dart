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

extension StringExtension on String {
  String capitalizeAndReplaceHyphens() {
    List<String> words = split('-');
    for (int i = 0; i < words.length; i++) {
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }
    return words.join(' ');
  }
}
