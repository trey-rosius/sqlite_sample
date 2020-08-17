import 'package:registration_app/model/user.dart';
import 'dart:async';
import 'package:registration_app/db/database_helper.dart';

class LoginCtr {
  DatabaseHelper con = new DatabaseHelper();

  Future<int> saveUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("users", user.toMap());
    print("successfull");
    return res;
  }

  Future<int> deleteUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.delete("users");
    return res;
  }

  Future<User> getLogin(String firstName, String lastName, String password) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM users WHERE first_name = '$firstName' and last_name = '$lastName' and password = '$password'");


    if (res.length > 0) {
      return new User.fromMap(res.first);
    }

    return null;
  }

  Future<List<User>> getAllUser() async {
    var dbClient = await con.db;
    var res = await dbClient.query("users");

    List<User> list =
    res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : null;

    return list;
  }
}