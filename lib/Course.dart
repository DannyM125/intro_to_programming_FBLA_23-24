class Course {
  String name;
  String grade;
  double credits;

  Course({
    required this.name,
    required this.grade,
    required this.credits,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'grade': grade,
      'credits': credits,
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'],
      grade: json['grade'],
      credits: json['credits'],
    );
  }
}
