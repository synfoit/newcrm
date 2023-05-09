class Employee {
  int userid;
  String userName;
  int rule;
  String loginstatus;

  Employee(this.userid, this.userName, this.rule , this.loginstatus);
 Map<String, dynamic> toMap() {
   var map = <String, dynamic>{
     'userid': userid,
     'username': userName,
     'rule': rule,
     'loginstatus' : loginstatus,

   };
   return map;
 }

  factory Employee.fromMap(Map data) {
       return Employee(
      data["userid"] as int,
      data["username"] as String,
      data["rule"] as int,
      data["loginstatus"] as String,
    );
  }






}