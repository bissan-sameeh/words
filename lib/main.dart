import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words/controller/read_data_cubit/read_data_cubit.dart';
import 'package:words/controller/write_data_cubit/write_data_cubit.dart';
import 'package:words/view/screens/home_screen.dart';
import 'package:words/view/styles/theme_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive_constants.dart';
import 'models/word_type_adapter.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordTypeAdapter());

  // TEMP: Clear old corrupt data during dev
  await Hive.deleteBoxFromDisk(HiveConstants.wordsBox);

  await Hive.openBox(HiveConstants.wordsBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider( create: (context) => ReadDataCubit()),
        BlocProvider( create: (context) => WriteDataCubit()),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeManager.getThemeData(),
        home: const HomeScreen(),
      ),
    );
  }
}

