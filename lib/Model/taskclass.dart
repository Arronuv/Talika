class TaskData{
  int id;
  String task;
  String date;

  TaskData({
    this.id=0,
    required this.date,
    required this.task,
});

Map<String,dynamic> toMap(){
  return {
    'task':task,
    'date':DateTime.now().toString().substring(0,11),
  };
}

}