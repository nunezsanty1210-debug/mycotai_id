class Student {
  final String id;
  final String name;
  final String carnetNumber;
  final String section;
  final String photoPath; // ruta local o asset
  final int permissions; // 0 = rojo, 1-2 = amarillo, 3 = verde
  final String year;

  Student({
    required this.id,
    required this.name,
    required this.carnetNumber,
    required this.section,
    this.photoPath = '',
    this.permissions = 3,
    this.year = '2026',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'carnetNumber': carnetNumber,
        'section': section,
        'photoPath': photoPath,
        'permissions': permissions,
        'year': year,
      };

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json['id'],
        name: json['name'],
        carnetNumber: json['carnetNumber'],
        section: json['section'],
        photoPath: json['photoPath'] ?? '',
        permissions: json['permissions'] ?? 3,
        year: json['year'] ?? '2026',
      );
}