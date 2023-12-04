class DataModel{
  final int? id;
  final String title;
  final String data;

  DataModel({this.id,required this.title,required this.data});


  DataModel.fromMap(Map<String, dynamic> res):
        id=res['id'],
        title=res['title'],
        data=res['data'];


  Map<String, Object?> toMap(){
    return{
      'id': id,
      'title': title,
      'data' : data
    };
  }
}