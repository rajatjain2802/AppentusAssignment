class User {
  int id;
  String email;
  String name;
  String number;
  String password;
  String image;

  User();

  User.fromDbMap(Map<String, dynamic> map)
      : id = map['id'],
        email = map['email'],
        image = map['image'],
        password = map['password'],
        number = map['number'],
        name = map["name"];

  Map<String, dynamic> toDbMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['email'] = email;
    map['image'] = image;
    map['password'] = password;
    map['number'] = number;
    map['name'] = name;
    return map;
  }
}
