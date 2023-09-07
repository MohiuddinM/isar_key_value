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
    if (value is String) {
      _stringValue = value;
    } else if (value is int) {
      _intValue = value;
    } else if (value is double) {
      _doubleValue = value;
    } else if (value is bool) {
      _boolValue = value;
    } else if (value is DateTime) {
      _dateTimeValue = value.toIso8601String();
    } else {
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
