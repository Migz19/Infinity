class CommitteeModel{
  String name;
  String description;
  String photoUri;
  List<String> membersIds;
  List<String> tasksIds;
  CommitteeModel( {required this.name,required this.description, required this.photoUri,required this.membersIds,required this.tasksIds});
  factory CommitteeModel.fromJson({required dynamic json}){
    CommitteeModel model= CommitteeModel(name: json['name'] ?? '',
        description: json['description']??'',
        photoUri: json['photo_url']??'',
        tasksIds:(json['tasks_ids'] is Iterable ? List.from(json?['tasks_ids']):[]),
      membersIds:(json['members_ids'] is Iterable ? List.from(json?['members_ids']):[]));
    return model;
  }
}