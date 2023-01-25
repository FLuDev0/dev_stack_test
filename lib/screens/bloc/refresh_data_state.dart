part of 'refresh_data_bloc.dart';

class RefreshDataInitial extends Equatable {
  final List<AdminObject> adminObject;
  final int stateChanged;

  const RefreshDataInitial(
      {this.adminObject = const [], this.stateChanged = 0});

  RefreshDataInitial copyWith(
      {List<AdminObject>? adminObject, int? stateChanged}) {
    return RefreshDataInitial(
        adminObject: adminObject ?? this.adminObject,
        stateChanged: stateChanged ?? this.stateChanged);
  }

  @override
  List<Object?> get props => [stateChanged];
}

class Refresh extends RefreshDataInitial {
  @override
  List<Object?> get props => [];
}
