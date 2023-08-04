class PostModel{
  String title;
  String description;
  String? committee;
  bool isPublic;

  PostModel({required this.title, required this.description, this.committee,required this.isPublic});
}