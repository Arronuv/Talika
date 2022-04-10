import 'package:flutter/material.dart';
import 'package:talika/Model/model.dart';
import 'package:talika/Model/taskclass.dart';
import 'package:talika/Themes/theme.dart';

class TaskTab extends StatefulWidget {
  final Function checkstate;
  final bool? state;
  final TaskData td;

  const TaskTab({Key? key,
    required this.td,
    required this.checkstate,
    required this.state})
      : super(key: key);

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    List<Color> col = [Colors.red, Colors.blue, Colors.purpleAccent];


    return InkWell(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top:10.0,left: 10.0, right: 10.0,bottom: 10.0),
          decoration: BoxDecoration(
            color: coltheme.foreground,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Row(
            children: [
          Theme(
          data: ThemeData(
          unselectedWidgetColor:col[widget.td.id%3],
          ),
          child: Checkbox(
            splashRadius: 20.0,
            tristate: false,
            shape: CircleBorder(),
            activeColor: coltheme.primarycolor,
            value: widget.state,
            onChanged: (bool? b) {
              widget.checkstate(widget.td.id, b);
              if(b==true){
                model.selectedtask.add(widget.td);
              }else{
                model.selectedtask.remove(widget.td);
              }
            },
          ),
          ),
          const SizedBox(
          width: 10.0,
          ),
          Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
                widget.td.task,
                style: const TextStyle(fontSize: 20.0, color: Colors.white,
                overflow: TextOverflow.clip),
        ),
          ),
          ),
        ],
      ),)
    ,
    )
    ,
    );
  }
}
