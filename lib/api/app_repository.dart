import 'package:dev_stack_test/models/admin_object_model.dart';

abstract class AppRepository {
  Future<List<AdminObject>> getRemoteData();
  Future<void> updateRemoteData(Map<int, dynamic> adminObject);

  Future<void> saveLocalData(List<AdminObject> adminObject);
  Future<List<AdminObject>> loadLocalData();

  Stream<List<AdminObject>> listenLocalDataBase();

  void loadLocalDataQueue();
  void saveLocalQueue(int id, String name, dynamic value);

  void clearQueue();
}
