class UserModel{
  String uid;
  String userName;
  String userEmail;
  String userPassword;
  String userPhone;
UserModel({
  this.uid="",
  required this.userName,
  required this.userEmail,
  required this.userPassword,
  required this.userPhone,
});

  factory UserModel.fromJson(String key, Map data){
    return UserModel(
        uid: key,
        userName: data["userName"],
        userEmail: data["userEmail"],
        userPassword: data["userPassword"],
        userPhone:data["userPhone"] );
  }
  @override
  String toString() {
    return "($uid ,$userName,$userEmail ,$userPassword ,$userPhone  )";
  }
}