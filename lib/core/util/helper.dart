//format to idr currency

import 'package:intl/intl.dart';

String toRupiah(int value) {
  return NumberFormat.currency(locale: 'id', symbol: 'Rp. ')
      .format(value)
      .toString();
}

// from string to datetime
DateTime stringToDateTime(String date) {
  // format dd-MM-yyyy hh:mm:ss
  return DateTime.parse(date);
}
