import 'package:intl/intl.dart';

// Clase con metodo que permite hacer que los numericos sean reducidos con K o M
class HummanFormats {
  // permite llamarlo/accederlo directamente
  // Sin crear una instancia
  static String humanReadbleNumber(double number) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    ).format(number);
    return formatterNumber;
  }
}
