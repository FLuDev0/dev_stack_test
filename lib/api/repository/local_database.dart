import 'dart:async';
import 'dart:io';

import 'package:dev_stack_test/models/admin_object_model.dart';
import 'package:dev_stack_test/models/radio_switch_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalDataBase {
  Box<List<dynamic>>? _box;
  Box<dynamic>? _queueBox;

  LocalDataBase() {
    initDb();
  }

  Future<void> initDb() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    registerAdapters();
    String appDocPath = appDocDir.path;

    _box = await Hive.openBox(
      'AdminSettingsBox',
      path: appDocPath,
    );

    _queueBox = await Hive.openBox(
      'queueBox',
      path: appDocPath,
    );
  }

  Future<List<AdminObject>> loadLocalData() async {
    final List<AdminObject> itemsFromLocalDb = [];
    print("Load local data");
    try {
      if (_box!.isNotEmpty) {
        final hiveList = _box!.get("AdminSettingsBox", defaultValue: []);
        if (hiveList != null) {
          itemsFromLocalDb.addAll(
            hiveList.toList().map((e) {
              return e as AdminObject;
            }),
          );
        }
      }
      itemsFromLocalDb.sort();
      return itemsFromLocalDb;
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  void registerAdapters() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(AdminObjectAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(RadioSwitchAdapter());
    }
  }

  Future<void> saveLocalData(List<AdminObject> adminObjects) async {
    try {
      print("Save local data");

      _box?.put(
        "AdminSettingsBox",
        adminObjects,
      );

      _box?.flush();
    } catch (ex) {
      print(ex);
    }
  }

  Future<void> addOrReplaceQueue(int id, String name, dynamic value) async {
    try {
      var queueValues = _queueBox?.get(id, defaultValue: {});

      var queueElements = Map<String, dynamic>.from(queueValues);
      if (queueElements.containsKey(name)) {
        queueValues.remove(name);
      } else {
        queueValues?.addAll({name: value});
        _queueBox?.put(id, queueValues);
      }
    } catch (ex) {
      print(ex);
    }
  }

  Future<Map<int, dynamic>> loadLocalDataQueue() async {
    return Map<int, dynamic>.from(_queueBox?.toMap() ?? {});
  }

  void clearQueue() {
    print("Clear queue");
    _queueBox?.clear();
  }
}
