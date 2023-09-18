class CommitteeModel{
  String name;
  String description;
  String photoUri;
  List<String> membersIds;
  CommitteeModel( {required this.name,required this.description, required this.photoUri,required this.membersIds});
  factory CommitteeModel.fromJson({required dynamic json}){
    CommitteeModel model= CommitteeModel(name: json['name'] ?? '',
        description: json['description']??'',
        photoUri: json['photo_url']??'',
      membersIds:(json['members_ids'] is Iterable ? List.from(json?['members_ids']):[]));
    return model;
  }
}