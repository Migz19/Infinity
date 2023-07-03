import '../user/user_model.dart';

class CommitteeModel{
  String _name;
  String _imgUri;
  List<UserModel>_members;

  CommitteeModel.committee(this._name, this._imgUri, this._members);

}