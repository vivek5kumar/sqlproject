class UserLoginResponse {
  int? status;
  String? msg;
  String? token;

  UserLoginResponse({this.status, this.msg, this.token});

  UserLoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['msg'] = msg;
    data['token'] = token;
    return data;
  }
}
