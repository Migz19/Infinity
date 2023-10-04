
class TaskModel{
  String description;
  String title;
  String committeeName;
  bool isDone=false;
  String deadLine;

  TaskModel(this.description, this.title, this.committeeName, this.isDone,
      this.deadLine);
}