import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mikococo/exercide/exercise_screen.dart';
import 'package:mikococo/workout/work_out_froum.dart';
import '../module/models.dart';

class WorkoutDaysScreen extends StatefulWidget {
  final Routine routine;

  WorkoutDaysScreen(this.routine);

  @override
  State<WorkoutDaysScreen> createState() => _WorkoutDaysScreenState();
}

class _WorkoutDaysScreenState extends State<WorkoutDaysScreen> {
  @override
  Widget build(BuildContext context) {
    var workoutDaysBox = Hive.box<WorkoutDay>('WorkoutDaysBox');
    List<WorkoutDay> workoutDays = workoutDaysBox.values
        .where((day) => widget.routine.workoutDays.contains(day.key))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Days for ${widget.routine.name}'),
      ),
      body: ListView.builder(
        itemCount: workoutDays.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(workoutDays[index].name),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExercisesScreen(workoutDays[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Workout Day'),
                content: AddWorkoutDayForm(
                  onAdd: (String name) {
                    addWorkoutDay(name, widget.routine);
                    Navigator.of(context).pop();
                  },
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void addWorkoutDay(String name, Routine routine) {
    final workoutDay = WorkoutDay(name, []);
    Hive.box<WorkoutDay>('WorkoutDaysBox').add(workoutDay).then((dayKey) {
      routine.workoutDays.add(dayKey);
      routine.save();
    });
  }
}