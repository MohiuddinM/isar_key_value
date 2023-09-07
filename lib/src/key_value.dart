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
  String? dateTimeValue;
}

extension KeyValueX on KeyValue {
  set value(dynamic value) {
    switch (value.runtimeType) {
      case String:
        stringValue = value;
        break;
      case int:
        intValue = value;
        break;
      case double:
        doubleValue = value;
        break;
      case bool:
        boolValue = value;
        break;
      case DateTime:
        dateTimeValue = value.toIso8601String();
        break;
      default:
        throw UnsupportedError('${value.runtimeType} is not supported');
    }
  }

  dynamic get value {
    return stringValue ??
        intValue ??
        doubleValue ??
        boolValue ??
        (dateTimeValue != null ? DateTime.parse(dateTimeValue!) : null);
  }
}
