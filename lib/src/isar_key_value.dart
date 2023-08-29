import 'dart:async';
import 'package:isar/isar.dart';

import 'key_value.dart';

/// Encapsulates an underlying Isar database to expose a key value store api
class IsarKeyValue {
  IsarKeyValue({this.name = 'default', this.directory = '.'});

  final String name;
  final String directory;

  late final _isar = Completer<Isar>()..complete(_open());

  Future<Isar> _open() async {
    final isar = await Isar.open(
      [KeyValueSchema],
      directory: directory,
      name: name,
    );

    return isar;
  }

  /// Closes the underlying isar database instance
  ///
  /// Deletes the database file too is [deleteDb] is true
  Future<bool> close({bool deleteDb = false}) async {
    final isar = await _isar.future;
    return isar.close(deleteFromDisk: deleteDb);
  }

  /// Sets [value] to [key]
  ///
  /// If the [key] already exists then the previous [value] is replaced
  /// Return the index of the new entry, that can be used to access this value
  /// in addition to the [key]
  Future<int> set<T>(String key, T value) async {
    final isar = await _isar.future;
    final item = KeyValue()..key = key;
    item.value = value;
    return isar.writeTxn(() => isar.keyValues.put(item));
  }

  /// Gets the value associated with [key]
  ///
  /// Returns null if none is found
  /// Throws a type error of the value is not of type [T]
  Future<T?> get<T>(String key) async {
    final isar = await _isar.future;
    final item = await isar.txn(() => isar.keyValues.getByKey(key));
    return item?.value;
  }

  /// Gets the value associated with [id]
  ///
  /// Returns null if none is found
  /// Throws a type error of the value is not of type [T]
  Future<T?> getById<T>(int id) async {
    final isar = await _isar.future;
    final item = await isar.txn(() => isar.keyValues.get(id));
    return item?.value;
  }

  /// Removes a value associated with [key]
  ///
  /// Returns true if a value is removed
  /// Returns false if value is not removed
  Future<bool> remove(String key) async {
    final isar = await _isar.future;
    return isar.writeTxn(() => isar.keyValues.deleteByKey(key));
  }

  /// Removes a value associated with [id]
  ///
  /// Returns true if a value is removed
  /// Returns false if value is not removed
  Future<bool> removeById(int id) async {
    final isar = await _isar.future;
    return isar.writeTxn(() => isar.keyValues.delete(id));
  }

  /// Removes a all keys and values from this instance and the underlying
  /// isar database
  Future<void> clear() async {
    final isar = await _isar.future;
    return isar.writeTxn(() => isar.clear());
  }
}
