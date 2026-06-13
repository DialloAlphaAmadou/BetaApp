import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LocalDb {
  late final Isar isar;

  Future<void> initialize(List<CollectionSchema<dynamic>> schemas) async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open(
      schemas,
      directory: dir.path,
    );
  }

  Future<void> clearDatabase() async {
    await isar.writeTxn(() async {
      await isar.clear();
    });
  }

  Future<void> close() async {
    await isar.close();
  }
}