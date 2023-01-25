import 'dart:async';
import 'package:dev_stack_test/api/app_repository.dart';
import 'package:dev_stack_test/api/repository/local_database.dart';
import 'package:dev_stack_test/api/repository/remote_database.dart';

import 'package:dev_stack_test/models/admin_object_model.dart';

class AppRepositoryImpl implements AppRepository {
  AppRepositoryImpl(this.localDataBase, this.remoteDataBase) {
    syncRemote();
    syncUi();
  }
  final LocalDataBase localDataBase;
  final RemoteDataBase remoteDataBase;
  StreamController<List<AdminObject>> syncUiController =
      StreamController.broadcast();

  @override
  Future<List<AdminObject>> getRemoteData() {
    return remoteDataBase.getRemoteData();
  }

  @override
  Future<void> updateRemoteData(Map<int, dynamic> adminObject) {
    return remoteDataBase.updateRemoteData(adminObject);
  }

  @override
  Future<List<AdminObject>> loadLocalData() {
    return localDataBase.loadLocalData();
  }

  @override
  Future<void> saveLocalData(List<AdminObject> adminObject) {
    return localDataBase.saveLocalData(adminObject);
  }

  @override
  Stream<List<AdminObject>> listenLocalDataBase() {
    return syncUiController.stream;
  }

  syncUi() {
    Timer.periodic(const Duration(seconds: 2), (Timer t) async {
      syncUiController.add(await loadLocalData());
    });
  }

  syncRemote() {
    Timer.periodic(const Duration(seconds: 10), (Timer t) async {
      updateRemoteData(await localDataBase.loadLocalDataQueue())
          .then((value) async {
        clearQueue();
        return localDataBase
            .saveLocalData(await remoteDataBase.getRemoteData());
      });
    });
  }

  @override
  Future<void> saveLocalQueue(int id, String name, dynamic value) {
    return localDataBase.addOrReplaceQueue(id, name, value);
  }

  @override
  Future<Map?> loadLocalDataQueue() {
    return localDataBase.loadLocalDataQueue();
  }

  @override
  void clearQueue() {
    return localDataBase.clearQueue();
  }
}
