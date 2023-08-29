import 'package:isar/isar.dart';

part 'key_value.g.dart';

@collection
class KeyValue {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String key;

  String? stringValue;
  int? intValue;
  double? doubleValue;
  bool? boolValue;
  DateTime? dateTimeValue;
}

extension KeyValueX on KeyValue {
  set value(dynamic value) {
    if (value is String) {
      stringValue = value;
    } else if (value is int) {
      intValue = value;
    } else if (value is double) {
      doubleValue = value;
    } else if (value is bool) {
      boolValue = value;
    } else if (value is DateTime) {
      dateTimeValue = value;
    } else {
      throw UnsupportedError('${value.runtimeType} is not supported');
    }
  }

  dynamic get value {
    return stringValue ?? intValue ?? doubleValue ?? boolValue ?? dateTimeValue;
  }
}
