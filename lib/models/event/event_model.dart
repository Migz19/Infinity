import 'dart:io';

class EventModel {
  String title;
  List<String> _filesUrls=[];
  List<File>? eventFiles;
  String date;
  String location;
  String description;
  String _id='';


  String get id => _id;

  set id(String value) {
    _id = value;
  }

  List<String> get filesUrls => _filesUrls;

  set filesUrls(List<String> value) {
    _filesUrls = value;
  }

  EventModel({required this.title,

    required this.date,
    required this.location,
    required this.description});


  factory EventModel.fromJson({required dynamic json})=>
      EventModel(title: json['title'] ?? '',
          date: json['date']??'',
          location: json['location']??'',
          description: json['description']??'');
  Map<String,dynamic>toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id']=id;
    data['location']=location;
    data['date']=date;
    data['description']=description;
    data['Files urls']=_filesUrls;
    return data;
  }



}
