import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mikococo/routine/routine_forum.dart';
import '../module/models.dart';
import '../workout/workoutScreen.dart';
// import 'add_routine.dart';




class MyRoutinesScreen extends StatefulWidget {
  @override
  State<MyRoutinesScreen> createState() => _MyRoutinesScreenState();
}

class _MyRoutinesScreenState extends State<MyRoutinesScreen> {



  @override
  Widget build(BuildContext context) {
    void addRoutine(String name, String des, String leadword, String avatarColor) {
      // Hive.box<Routine>('RoutineBox').clear();


      final routine = Routine(name, des,  leadword, avatarColor, []);
      Hive.box<Routine>('RoutineBox').add(routine);
    }
    var routineBox = Hive.box<Routine>('RoutineBox');
    List<Routine> routines = routineBox.values.toList();


    return Scaffold(
      appBar: AppBar(
        title: Text('My Routines'),
      ),
      body:ValueListenableBuilder<Box<Routine>>(
        valueListenable: routineBox.listenable(),
        builder: (context, Box<Routine> box, _){
          List<Routine> routines = box.values.toList();
          return ListView.builder(
            itemCount: routines.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  // backgroundColor: Color(int.parse("FF0000", radix: 16) | 0xFF000000),
                  backgroundColor: Color(int.parse(routines[index].avatarColor.replaceFirst('#', ''), radix: 16) | 0xff000000),
                  child: Text(
                    routines[index].leadingword,
                  ),
                ),
                title: Text(
                  routines[index].name,
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  routines[index].description,
                  style: TextStyle(color: Colors.black),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: (){
                    print('Delete tapped for index $index');
                    Hive.box<Routine>('RoutineBox').deleteAt(index);

                  },
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WorkoutDaysScreen(routines[index]),
                    ),
                  );
                },
              );
            },
          );

        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, CupertinoPageRoute(
              builder: (ctx) =>
              AddRoutineForm(onAdd: (String name, String desc, String leadword, String avatarCOlor){

                addRoutine(name, desc, leadword, avatarCOlor);

          }))
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

