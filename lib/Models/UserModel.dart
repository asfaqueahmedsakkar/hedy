import 'package:flutter/cupertino.dart';

class UserModel {
  int id;
  String userName;
  String personName;
  String email;
  int idRelation;
  String xRated;
  int completionStatus;

  UserModel.fromJson(dynamic json) {
    id = json["id"];
    userName = json["name"];
    personName = json["person_name"];
    email = json["email"];
    idRelation =
        json["id_relation"] == null ? 0 : int.parse(json["id_relation"].toString());
    completionStatus = json["status"];
    xRated = json["x_rated"] != null ? json["x_rated"]?"1":"0" : "0";
  }

  UserModel(
      {@required this.id,
      this.userName,
      this.personName,
      @required this.email,
      this.idRelation,
      this.completionStatus});
}
