import '../user/user_model.dart';

class CommitteeModel{
  String name;
  String imgUri;
  String description;
  List<UserModel>members;

  CommitteeModel(this.name, this.imgUri, this.description, this.members);
}