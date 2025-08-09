class SiswaModel {
  final String name;
  final int age;

  SiswaModel({
    required this.name, 
    required this.age
  });
  
  factory SiswaModel.fromJson(Map<String,dynamic> json){
    return SiswaModel(
      name: json['name'], 
      age: json['age']
    );
  }

  
}
