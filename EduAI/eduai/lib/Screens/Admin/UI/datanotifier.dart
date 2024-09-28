import 'package:flutter/foundation.dart';

class DataNotifier extends ValueNotifier<List<Map<String, dynamic>>> {
  DataNotifier(List<Map<String, dynamic>> value) : super(value);
}
