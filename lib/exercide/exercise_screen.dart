import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../module/models.dart';
import 'exercise_forum.dart';



class ExercisesScreen extends StatefulWidget {
  final WorkoutDay workoutDay;

  ExercisesScreen(this.workoutDay);

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  @override
  Widget build(BuildContext context) {
    var exercisesBox = Hive.box<Exercise>('ExercisesBox');
    List<Exercise> exercises = exercisesBox.values
        .where((exercise) => widget.workoutDay.exercises.contains(exercise.key))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises for ${widget.workoutDay.name}'),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(exercises[index].name),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Exercise'),
                content: AddExerciseForm(
                  onAdd: (String name) {
                    addExercise(name, widget.workoutDay);
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

  void addExercise(String name, WorkoutDay workoutDay) {
    final exercise = Exercise(name);
    Hive.box<Exercise>('ExercisesBox').add(exercise).then((exerciseKey) {
      workoutDay.exercises.add(exerciseKey);
      workoutDay.save();
    });
  }
}