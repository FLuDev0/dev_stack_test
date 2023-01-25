import 'package:dev_stack_test/api/repository/app_repositoryImpl.dart';
import 'package:dev_stack_test/api/repository/local_database.dart';
import 'package:dev_stack_test/api/repository/remote_database.dart';
import 'package:dev_stack_test/screens/bloc/refresh_data_bloc.dart';
import 'package:dev_stack_test/screens/objects_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final localDataBase = LocalDataBase();
  final remoteDataBase = RemoteDataBase();

  final repository = AppRepositoryImpl(localDataBase, remoteDataBase);

  runApp(MyApp(repository));
}

class MyApp extends StatelessWidget {
  const MyApp(this.repository, {super.key});
  final AppRepositoryImpl repository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => repository,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (context) =>
              RefreshDataBloc(repository)..add(ListenLocalDataBase()),
          child: const ObjectsScreen(),
        ),
      ),
    );
  }
}
