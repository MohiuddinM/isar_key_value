import 'package:isar_key_value/isar_key_value.dart';

void main() async {
  final store = IsarKeyValue();
  store.set('key', 1);
  final value = await store.get<int>('key');
  print(value);
  store.close(deleteDb: true);
}
