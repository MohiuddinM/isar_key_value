import 'dart:io';

import 'package:isar/isar.dart';
import 'package:isar_key_value/isar_key_value.dart';
import 'package:test/test.dart';

void main() {
  late IsarKeyValue isar;

  setUpAll(() async => await Isar.initializeIsarCore(download: true));

  setUp(() {
    isar = IsarKeyValue();
  });

  tearDown(() {
    isar.close(deleteDb: true);
  });

  test('get return set value', () async {
    await isar.set('key', 1);
    final got = await isar.get('key');
    expect(got, 1);
  });

  test('get and getById returns the same value', () async {
    final id = await isar.set('key', 1);
    expect(await isar.get('key'), await isar.getById(id));
  });

  test('value is replaced', () async {
    await isar.set('key', 1);
    await isar.set('key', 'value');
    final got = await isar.get('key');
    expect(got, 'value');
  });

  test('removed value returns null', () async {
    await isar.set('key', 1);
    await isar.remove('key');
    final got = await isar.get('key');
    expect(got, isNull);
  });

  test('removeById value returns null', () async {
    final id = await isar.set('key', 1);
    await isar.removeById(id);
    final got = await isar.get('key');
    expect(got, isNull);
  });

  test('clear removes all values', () async {
    await isar.set('1', 1);
    await isar.set('2', 1);
    await isar.clear();

    expect(await isar.get('1'), isNull);
    expect(await isar.get('2'), isNull);
  });

  test('throws error when trying to write unsupported type', () async {
    expect(
      () async => await isar.set('key', File('')),
      throwsUnsupportedError,
    );
  });
}
