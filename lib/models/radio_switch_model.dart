import 'package:hive/hive.dart';

part 'radio_switch_model.g.dart';

@HiveType(typeId: 1)
enum RadioSwitch {
  @HiveField(0)
  radio1,
  @HiveField(1)
  radio2
}

extension RadioFromInt on RadioSwitch {
  int fromEnum() {
    switch (this) {
      case RadioSwitch.radio1:
        return 0;
      case RadioSwitch.radio2:
        return 1;
      default:
        return 0;
    }
  }
}

mixin GetRadio {
  static RadioSwitch parse(int type) {
    switch (type) {
      case 0:
        return RadioSwitch.radio1;
      case 1:
        return RadioSwitch.radio2;

      default:
        return RadioSwitch.radio1;
    }
  }
}
