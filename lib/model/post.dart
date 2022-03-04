class Post{
  String title;
  String body;
  String NameUser,PhoneUser,IdUser;

  Post({this.title, this.body});

  Post.fromJson(Map<String,dynamic>json){
    title=json['title'];
    body=json['body'];
    NameUser=json['NameUser'];
    PhoneUser=json['PhoneUser'];
    IdUser=json['IdUser'];
  }

  Map<String,dynamic>toJson(){
    final Map<String,dynamic>data=new Map<String,dynamic>();
    data['title']=this.title;
    data['body']=this.body;
    return data;
  }
}