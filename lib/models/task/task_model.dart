class TaskModel {
  String description;
  String title;
  String id="";
  String committeeName;
  bool isFinished = false;
  String deadLine;

  TaskModel(
      {required this.description,
      required this.title,
      required this.committeeName,
      required this.isFinished,
        required this.id,
      required this.deadLine});

  factory TaskModel.fromJson({required json}) => TaskModel(
      description: json['description'] ?? '',
      title: json['title'] ?? '',
      id:json['id']??'',
      committeeName: json['committeeName'] ?? '',
      isFinished: json['isFinished'] ?? false,
      deadLine: json['deadLine'] ?? '');
  Map<String,dynamic>  toJson(){
    Map<String,dynamic> data=<String,dynamic>{};
    data['title']=title;
    data['description']=description;
    data['isFinished']=isFinished;
    data['deadLine']=deadLine;
    data['committeeName']=committeeName;
    data['id']=id;
    return data;
  }
}
