class WorkoutModel {
  final int? localId;
  final int? apiId;
  final String title;
  final String category;
  final int durationMinutes;

  WorkoutModel({
    this.localId,
    this.apiId,
    required this.title,
    required this.category,
    required this.durationMinutes,

  });
  

  // regresa en un diccionario todas las claves para no acceder de 1 en 1 
  Map <String, dynamic> toMap(){
    return {
      'localId': localId,
      // 'apiId': apiId,
      'title': title,
      'category': category,
      'durationMinutes': durationMinutes,
    };
  }

  factory WorkoutModel.fromMap(Map<String, dynamic> map){
    return WorkoutModel(
      localId: map['localId'],
      // apiId: map['apiId'],
      title: map['title'],
      category: map['category'],
      durationMinutes: map['durationMinutes'],
    );
  }

}