import 'package:dev_stack_test/screens/bloc/refresh_data_bloc.dart';
import 'package:dev_stack_test/screens/widgets/admin_object_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ObjectsScreen extends StatelessWidget {
  const ObjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          toolbarHeight: 100,
          titleSpacing: 0,
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Text(
              "List",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: const Color.fromRGBO(255, 255, 255, 0.9),
          elevation: 0,
        ),
      ),
      body: BlocBuilder<RefreshDataBloc, RefreshDataInitial>(
        builder: (context, state) {
          return ScrollConfiguration(
            behavior: RefreshScrollBehavior(),
            child: SmartRefresher(
              header: CustomHeader(
                height: 64,
                refreshStyle: RefreshStyle.Behind,
                builder: (c, m) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                },
              ),
              onRefresh: () {
                context.read<RefreshDataBloc>().add(RequestRefresh());
              },
              controller: context.read<RefreshDataBloc>().refreshController,
              child: ListView.builder(
                itemCount: state.adminObject.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: AdminItem(state.adminObject[index]),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class RefreshScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
