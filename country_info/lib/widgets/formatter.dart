class Formatter {
  static String formatNumber(String number) {
    try {
      String cleanedNumber = number.replaceAll(RegExp(r'[^0-9]'), '');
      int parsedNumber = int.parse(cleanedNumber);
      return _addCommas(parsedNumber);
    } catch (e) {
      return number;
    }
  }

  static String _addCommas(int number) {
    String numberStr = number.toString();
    String result = '';
    int length = numberStr.length;
    for (int i = 0; i < length; i++) {
      if ((length - i) % 3 == 0 && i != 0) {
        result += ',';
      }
      result += numberStr[i];
    }
    return result;
  }
}