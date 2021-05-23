extension RemoveDuplicates on List<String> {
  List<String> removeDuplicates() {
    final lowered = [...map((e) => e.toLowerCase())];
    return [
      for (var keyValue in lowered.asMap().entries)
        if (lowered.lastIndexOf(keyValue.value) == keyValue.key)
          this[keyValue.key]
    ];
  }
}
extension StringExtension on String {
  String capitalize() {
    if (this.length > 0) {
      return "${this[0].toUpperCase()}${this.substring(1)}";
    }
    return "";
  }
}
