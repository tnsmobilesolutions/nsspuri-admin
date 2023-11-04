import 'package:intl/intl.dart';

class Utility {
  static String formatCurrency(double? input) {
    if (input != null) {
      var f = NumberFormat('₹###.0#', 'en_US');
      return f.format(input);
    } else {
      return '₹0.00';
    }
  }
}
