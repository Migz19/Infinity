import 'dart:io';

class EventModel {
  String title;
  List<String> _imagesUrls=[];
  List<File>? eventFiles;
  String date;
  String location;
  String description;
  String _id='';


  String get id => _id;

  set id(String value) {
    _id = value;
  }

  List<String> get imagesUrls => _imagesUrls;

  set imagesUrls(List<String> value) {
    _imagesUrls = value;
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
    data['imagesUrls']=imagesUrls;
    return data;
  }



}
