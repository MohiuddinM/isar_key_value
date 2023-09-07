import 'package:isar/isar.dart';

part 'key_value.g.dart';

@collection
class KeyValue {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String key;

  String? _stringValue;
  int? _intValue;
  double? _doubleValue;
  bool? _boolValue;
  String? _dateTimeValue;
}

extension KeyValueX on KeyValue {
  set value(dynamic value) {
    switch (value.runtimeType) {
      case String:
        _stringValue = value;
        break;
      case int:
        _intValue = value;
        break;
      case double:
        _doubleValue = value;
        break;
      case bool:
        _boolValue = value;
        break;
      case DateTime:
        _dateTimeValue = value.toIso8601String();
        break;
      default:
        throw UnsupportedError('${value.runtimeType} is not supported');
    }
  }

  dynamic get value {
    return _stringValue ??
        _intValue ??
        _doubleValue ??
        _boolValue ??
        (_dateTimeValue != null ? DateTime.parse(_dateTimeValue!) : null);
  }
}
