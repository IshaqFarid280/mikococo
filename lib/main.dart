import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mikococo/routine/MyRoutineClass.dart';
import 'package:path_provider/path_provider.dart';

import 'module/models.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(RoutineAdapter());
  Hive.registerAdapter(WorkoutDayAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  await Hive.openBox<Routine>('RoutineBox');
  await Hive.openBox<WorkoutDay>('WorkoutDaysBox');
  await Hive.openBox<Exercise>('ExercisesBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:MyRoutinesScreen(),
    );
  }
}

