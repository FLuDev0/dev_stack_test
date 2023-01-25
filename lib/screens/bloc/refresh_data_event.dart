part of 'refresh_data_bloc.dart';

@immutable
abstract class RefreshDataEvent {}

class RequestRefresh extends RefreshDataEvent {}

class ChangeSwitch1 extends RefreshDataEvent {
  final bool value;
  final int elementId;

  ChangeSwitch1({required this.value, required this.elementId});
}

class ChangeSwitch2 extends RefreshDataEvent {
  final RadioSwitch value;
  final int elementId;

  ChangeSwitch2({required this.value, required this.elementId});
}

class ChangeSwitch3 extends RefreshDataEvent {
  final bool value;
  final int elementId;

  ChangeSwitch3({required this.value, required this.elementId});
}

class ListenLocalDataBase extends RefreshDataEvent {
  ListenLocalDataBase();
}
