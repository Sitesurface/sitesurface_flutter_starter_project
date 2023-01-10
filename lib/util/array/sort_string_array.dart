List<String> sortStringArray(List<String> array) {
  List<String> sortedArray = [];
  array.sort((a, b) => a.compareTo(b));
  sortedArray.addAll(array);
  return sortedArray;
}
