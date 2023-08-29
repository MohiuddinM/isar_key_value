## Isar Key Value

A key value store built on top of the [Isar](https://pub.dev/packages/isar) database.

## Usage

First create a store:

```dart
final store = IsarKeyValue();
```

Then use the store using simple set and get interface. Once a value is set, it can be retrieved
using either the key or the id that is returned from the set method.

```dart
final id = await store.set('key', 1);
final valueByKey = await store.get('key');
final valueById = await store.getById('key');
```

You can also use types if you like:
```dart
final id = await store.set<int>('key', 1);
final valueByKey = await store.get<int>('key');
final valueById = await store.getById<int>('key');
```

## Additional information
Feel free to report any bugs or add improvements on 
[IsarKeyValue](https://github.com/MohiuddinM/isar_key_value) Github.
