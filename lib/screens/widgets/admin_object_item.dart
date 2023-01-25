import 'package:dev_stack_test/models/admin_object_model.dart';
import 'package:dev_stack_test/models/radio_switch_model.dart';
import 'package:dev_stack_test/screens/bloc/refresh_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminItem extends StatelessWidget {
  const AdminItem(this.adminObject, {super.key});
  final AdminObject adminObject;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(182, 188, 196, 0.25),
            offset: Offset(0.0, 4.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            color: const Color.fromRGBO(235, 242, 252, 1),
            height: 54,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    adminObject.name,
                    style: const TextStyle(
                      fontFamily: "Manrope",
                    ),
                  ),
                  Text(
                    adminObject.id.toString(),
                    style: const TextStyle(
                        fontFamily: "Manrope",
                        color: Color.fromRGBO(143, 148, 169, 1)),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                const Text("Switch name"),
                Switch(
                  value: adminObject.switch1,
                  onChanged: (value) => {
                    context.read<RefreshDataBloc>().add(
                        ChangeSwitch1(elementId: adminObject.id, value: value))
                  },
                  activeColor: const Color.fromRGBO(49, 172, 106, 1),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 14,
                      width: 14,
                      child: Radio(
                          activeColor: const Color.fromRGBO(49, 172, 106, 1),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: RadioSwitch.radio1,
                          groupValue: adminObject.switch2,
                          onChanged: (value) => {
                                context.read<RefreshDataBloc>().add(
                                    ChangeSwitch2(
                                        elementId: adminObject.id,
                                        value: value ?? RadioSwitch.radio1))
                              }),
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    const Text("Radio 1"),
                  ],
                ),
                const SizedBox(
                  width: 25,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 14,
                      width: 14,
                      child: Radio(
                          activeColor: const Color.fromRGBO(49, 172, 106, 1),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: RadioSwitch.radio2,
                          groupValue: adminObject.switch2,
                          onChanged: (value) => {
                                context.read<RefreshDataBloc>().add(
                                    ChangeSwitch2(
                                        elementId: adminObject.id,
                                        value: value ?? RadioSwitch.radio2))
                              }),
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    const Text("Radio 2"),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 24, top: 32),
            child: Row(
              children: [
                SizedBox(
                  height: 14,
                  width: 14,
                  child: Checkbox(
                    activeColor: const Color.fromRGBO(49, 172, 106, 1),
                    value: adminObject.switch3,
                    onChanged: (value) => {
                      context.read<RefreshDataBloc>().add(ChangeSwitch3(
                          elementId: adminObject.id, value: value ?? false))
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
                const Text("Checkbox"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
