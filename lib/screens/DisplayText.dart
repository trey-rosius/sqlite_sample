import 'package:flutter/material.dart';
import 'package:registration_app/db/login_controller.dart';
import 'package:registration_app/model/user.dart';

class DisplayText extends StatelessWidget {
  double _lableFontSize = 20.0;
  double _valueFontSize = 15.0;
  LoginCtr con = new LoginCtr();

  // A method that retrieves all the dogs from the dogs table.
  Future<List<User>> users() async {
    // Get a reference to the database.
    //final Database db = await database;

    // Query the table for all The Dogs.
    final List<User> users = await con.getAllUser();

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: users(),
        builder: (context,AsyncSnapshot<List<User>> snapshot){

        return snapshot.hasData ?
         ListView.builder(itemBuilder: (context,index){
          return ListTile(
            title: Text(snapshot.data[index].firstName),
            subtitle: Text(snapshot.data[index].lastName),
          );
        },itemCount: snapshot.data.length,)
            :
           Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
        });



  }
}
