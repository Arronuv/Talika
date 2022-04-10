import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:talika/Model/taskclass.dart';

void messageShow(BuildContext context, bool good, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: good ? Colors.blue : Colors.red,
      content: Container(
        height: 15,
        child: Center(
          child: Text(text),
        ),
      )));
}

Model model=Model();

class Model {
  String username = "Olivia";

  late Database database;

  List<TaskData> tasklist = [];
  List<TaskData>  selectedtask=[];



  Future<String?> initdatabse() async {
    //Init Database Connection
    try {
      var dbobj = await getDatabasesPath();
      String dbpath = join(dbobj, 'talika.db');
      database = await openDatabase(dbpath, version: 1,
          onCreate: (Database db, int version) {
        db.execute(
            'CREATE TABLE IF NOT EXISTS usertask (id INTEGER PRIMARY KEY AUTOINCREMENT, task VARCHAR, date VARCHAR)');
      });
      print("Database Connected!!!");
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  Future<String?> gettasks() async {
    //load tasks from db.
    try {
      List<Map<String,dynamic>> al=await database.query('usertask',orderBy: 'id');
      tasklist=[];
      al.forEach((mp) {
        tasklist.add(TaskData(id:mp['id'],date: mp['date'], task: mp['task']));
      });

    } catch (e) {
      return e.toString();
    }
    return null;
  }

  Future<String?> adddata(TaskData td) async {                    //add task data
    try {
      if (database.isOpen) {
        await database.insert('usertask', td.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
        print("Data Added");
      } else {
        print("error");
        return "Database not Connected!!!";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
    return null;
  }


  Future<String?> deletedata() async {                    //add task data
    try {
      if (database.isOpen) {
        if(selectedtask.isNotEmpty) {
          selectedtask.forEach((element)async {
            await database.delete('usertask',where: 'id=?',whereArgs: [element.id]);
          });
          selectedtask=[];
        }
        print("Data Deleted");
      } else {
        print("error");
        return "Database not Connected!!!";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
    return null;
  }



}
