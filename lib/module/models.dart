import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'models.g.dart';


@HiveType(typeId: 0)
class Routine extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  String leadingword;

  @HiveField(3)
  String avatarColor;


  @HiveField(4)
  List<int> workoutDays;

  Routine(this.name, this.description, this.leadingword, this.avatarColor, this.workoutDays);
}


@HiveType(typeId: 1)
class WorkoutDay extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<int> exercises;

  WorkoutDay(this.name, this.exercises);
}


@HiveType(typeId: 2)
class Exercise extends HiveObject {
  @HiveField(0)
  String name;

  Exercise(this.name);
}