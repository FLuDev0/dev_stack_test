import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_stack_test/models/admin_object_model.dart';

class RemoteDataBase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference _adminSettings =
      FirebaseFirestore.instance.collection('admin_settings');
  final Random _rnd = Random();

  Future<List<AdminObject>> getRemoteData() async {
    final QuerySnapshot querySnapshot =
        await Future.delayed(Duration(seconds: _rnd.nextInt(5)))
            .then((value) async => await _adminSettings.get());

    final List<AdminObject> adminObjectsList = [];

    for (var doc in querySnapshot.docs) {
      final AdminObject adminObject =
          AdminObject.fromMap(doc.data() as Map<String, dynamic>);
      adminObjectsList.add(adminObject);
    }

    return adminObjectsList;
  }

  Future<void> updateRemoteData(Map<int, dynamic> adminObject) async {
    await Future.delayed(Duration(seconds: _rnd.nextInt(5)))
        .then((value) async {
      try {
        print("Update remote");
        if (adminObject.isNotEmpty) {
          for (var element in adminObject.entries) {
            _adminSettings
                .doc(element.key.toString())
                .update(Map<String, dynamic>.from(element.value));
          }
        }
      } catch (ex) {
        print(ex);
      }
    });
  }
}
