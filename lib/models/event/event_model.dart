import 'package:flutter/foundation.dart';
import 'package:infinity/core/utils/app_assets.dart';

class EventModel {
  String title;
  String photoUri;
  String date;
  String location;
  String description;
  String id;

  EventModel(
      {required this.title,
      required this.photoUri,
      required this.date,
      required this.location,
      required this.description, required this.id});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['date'] = date;
    data['location'] = location;
    data['description'] = description;
    return data;
  }

  factory EventModel.fromJson({required dynamic json}) => EventModel(
      title: json['title'] ?? '',
      photoUri: json['photoUri'] ?? AppAssets.committee,
      date: json['date'] ?? '',
      location: json['location'] ?? '',
      id:json['id'] ??'',
      description: json['description'] ?? '');
}
