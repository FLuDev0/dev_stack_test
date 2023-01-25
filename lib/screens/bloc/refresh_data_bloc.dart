// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dev_stack_test/api/app_repository.dart';

import 'package:dev_stack_test/models/admin_object_model.dart';
import 'package:dev_stack_test/models/radio_switch_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'refresh_data_event.dart';
part 'refresh_data_state.dart';

class RefreshDataBloc extends Bloc<RefreshDataEvent, RefreshDataInitial> {
  AppRepository appRepository;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RefreshDataBloc(this.appRepository) : super(const RefreshDataInitial()) {
    on<ListenLocalDataBase>(_listenLocalDataBase);

    on<RequestRefresh>(_requestRefresh);
    on<ChangeSwitch1>(_changeSwitch1);
    on<ChangeSwitch2>(_changeSwitch2);
    on<ChangeSwitch3>(_changeSwitch3);
  }

  Future<FutureOr<void>> _requestRefresh(
      RequestRefresh event, Emitter<RefreshDataInitial> emit) async {
    emit(state.copyWith(
        adminObject: await appRepository.loadLocalData(),
        stateChanged: DateTime.now().millisecondsSinceEpoch));

    refreshController.refreshCompleted();
  }

  FutureOr<void> _changeSwitch3(
      ChangeSwitch3 event, Emitter<RefreshDataInitial> emit) {
    var oldObject = state.adminObject
        .firstWhereOrNull((element) => element.id == event.elementId);
    final newObj = oldObject?.copyWith(switch3: event.value);

    if (newObj != null) {
      state.adminObject.remove(oldObject);
      state.adminObject.add(newObj);
      state.adminObject.sort();
    }

    emit(state.copyWith(stateChanged: DateTime.now().millisecondsSinceEpoch));
    appRepository.saveLocalQueue(event.elementId, "switch3", event.value);
    appRepository.saveLocalData(state.adminObject);
  }

  FutureOr<void> _changeSwitch2(
      ChangeSwitch2 event, Emitter<RefreshDataInitial> emit) {
    var oldObject = state.adminObject
        .firstWhereOrNull((element) => element.id == event.elementId);
    final newObj = oldObject?.copyWith(switch2: event.value);

    if (newObj != null) {
      state.adminObject.remove(oldObject);
      state.adminObject.add(newObj);
      state.adminObject.sort();
    }

    emit(state.copyWith(stateChanged: DateTime.now().millisecondsSinceEpoch));
    appRepository.saveLocalData(state.adminObject);
    appRepository.saveLocalQueue(
        event.elementId, "switch2", event.value.fromEnum());
  }

  FutureOr<void> _changeSwitch1(
      ChangeSwitch1 event, Emitter<RefreshDataInitial> emit) {
    var oldObject = state.adminObject
        .firstWhereOrNull((element) => element.id == event.elementId);
    final newObj = oldObject?.copyWith(switch1: event.value);

    if (newObj != null) {
      state.adminObject.remove(oldObject);
      state.adminObject.add(newObj);
      state.adminObject.sort();
    }

    emit(state.copyWith(stateChanged: DateTime.now().millisecondsSinceEpoch));

    appRepository.saveLocalData(state.adminObject);
    appRepository.saveLocalQueue(event.elementId, "switch1", event.value);
  }

  Future<FutureOr<void>> _listenLocalDataBase(
      ListenLocalDataBase event, Emitter<RefreshDataInitial> emit) async {
    await emit.forEach<List<AdminObject>>(appRepository.listenLocalDataBase(),
        onData: (data) {
      print("Refresh UI");

      return state.copyWith(
          adminObject: data,
          stateChanged: DateTime.now().millisecondsSinceEpoch);
    });
  }
}
