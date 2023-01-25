import 'package:dev_stack_test/models/radio_switch_model.dart';
import 'package:hive/hive.dart';

part 'admin_object_model.g.dart';

@HiveType(typeId: 0)
class AdminObject implements Comparable<AdminObject> {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool switch1;
  @HiveField(3)
  final RadioSwitch switch2;
  @HiveField(4)
  final bool switch3;
  @HiveField(5)
  final int? order;

  AdminObject(
    this.id,
    this.name,
    this.switch1,
    this.switch2,
    this.switch3,
    this.order,
  );

  AdminObject copyWith({
    int? id,
    String? name,
    bool? switch1,
    RadioSwitch? switch2,
    bool? switch3,
    int? order,
  }) {
    return AdminObject(
      id ?? this.id,
      name ?? this.name,
      switch1 ?? this.switch1,
      switch2 ?? this.switch2,
      switch3 ?? this.switch3,
      order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'switch1': switch1,
      'switch2': switch2.fromEnum(),
      'switch3': switch3,
    };
  }

  factory AdminObject.fromMap(Map<String, dynamic> map) {
    return AdminObject(
      map['id'] as int,
      map['name'] as String,
      map['switch1'] as bool,
      GetRadio.parse(map['switch2']),
      map['switch3'] as bool,
      map['order'] as int?,
    );
  }

  Map<String, dynamic> toJson() => (toMap());

  factory AdminObject.fromJson(Map<String, dynamic> source) =>
      AdminObject.fromMap(source);

  @override
  String toString() {
    return 'AdminObject(id: $id, name: $name, switch1: $switch1, switch2: $switch2, switch3: $switch3, order: $order)';
  }

  @override
  bool operator ==(covariant AdminObject other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.switch1 == switch1 &&
        other.switch2 == switch2 &&
        other.switch3 == switch3 &&
        other.order == order;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        switch1.hashCode ^
        switch2.hashCode ^
        switch3.hashCode ^
        order.hashCode;
  }

  @override
  int compareTo(AdminObject other) {
    if (order == null && other.order == null) {
      return id.compareTo(other.id);
    }
    if ((order ?? 0) < (other.order ?? 0)) {
      return -1;
    } else if ((order ?? 0) > (other.order ?? 0)) {
      return 1;
    } else {
      return 0;
    }
  }
}
