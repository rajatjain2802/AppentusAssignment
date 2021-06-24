import 'package:appentus_assignment/data/local/db/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

import '../UserModel.dart';

class UserDao {
  DatabaseManager dm = DatabaseManager.instance;

  Future<int> createUser(User user) async {
    Map m=user.toDbMap();
    print(m);
    Database database = await dm.database;
    return database.insert(
      DatabaseManager.tableName,
      user.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> checkUser(String email) async {
    Database database = await dm.database;
    bool isValid = false;
    List<Map<String, dynamic>> map =
        await database.query(DatabaseManager.tableName, where: "email = ?", whereArgs: [email]);
    List<User> userList = new List();

    print(map);
    for(Map m in map){
      userList.add(User.fromDbMap(m));
    }

    if(userList.length>0){
      isValid = true;
    }
    return isValid;
  }

  Future<User> getUserDetails(String email)async{
    Database database = await dm.database;
    User user = new User();
    List<Map<String, dynamic>> map =
    await database.query(DatabaseManager.tableName, where: "email = ?", whereArgs: [email]);
    List<User> userList = new List();

    print(map);
    for(Map m in map){
      userList.add(User.fromDbMap(m));
    }

    if(userList.length==1){
      user = userList.elementAt(0);
    }
    return user;
  }
}
