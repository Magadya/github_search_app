import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static const dateTimeFormat = [HH, ':', mm, ':', ss, ' ', dd, '-', mm, '-', yyyy];
  static const keySearchText =  Key('search_key');
  static final formattedDate = formatDate(DateTime.now().subtract(const Duration(days: 7)), [yyyy, '-', mm, '-', dd]);
}
