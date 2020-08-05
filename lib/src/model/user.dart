class User {
  String fullName;
  String username;
  String password;
  String gender;
  String birthday;
  String phone;
  String address;
  String create_at;
  String type;
  User(this.fullName, this.username, this.password, this.gender, this.birthday,
      this.phone, this.address, this.create_at, this.type);

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    username = json['username'];
    password = json['password'];
    gender = json['gender'];
    birthday = json['birthday'];
    phone = json['phone'];
    address = json['address'];
    create_at = json['create_at'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = fullName;
    data['username'] = username;
    data['password'] = password;
    data['gender'] = gender;
    data['birthday'] = birthday;
    data['phone'] = phone;
    data['address'] = address;
    data['create_at'] = create_at;
    data['type'] = type;
    return data;
  }
}
