import '../user/user_model.dart';

class CommitteeModel{
  String name;
  String imgUri;
  List<UserModel>members;

  CommitteeModel.committee({ required this.name,required this.imgUri,required this.members});

}