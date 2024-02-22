class Course {
  String name;
  int grade;
  String letterGrade;
  double credits;

  Course({
    required this.name,
    required this.letterGrade,
    required this.grade,
    required this.credits,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'letterGrade': letterGrade,
      'grade': grade,
      'credits': credits,
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'],
      letterGrade: json['letterGrade'],
      grade: json['grade'],
      credits: json['credits'],
    );
  }
}

// class Course_9 extends Course {
//   Course_9({required super.name, required super.grade, required super.credits});

//   factory Course_9.fromJson(Map<String, dynamic> json) {
//     return Course_9(
//       name: json['name'],
//       grade: json['grade'],
//       credits: json['credits'],
//     );
//   }
// }

// class Course_10 extends Course {
//   Course_10(
//       {required super.name, required super.grade, required super.credits});

//   factory Course_10.fromJson(Map<String, dynamic> json) {
//     return Course_10(
//       name: json['name'],
//       grade: json['grade'],
//       credits: json['credits'],
//     );
//   }
// }

// class Course_11 extends Course {
//   Course_11(
//       {required super.name, required super.grade, required super.credits});

//   factory Course_11.fromJson(Map<String, dynamic> json) {
//     return Course_11(
//       name: json['name'],
//       grade: json['grade'],
//       credits: json['credits'],
//     );
//   }
// }

// class Course_12 extends Course {
//   Course_12(
//       {required super.name, required super.grade, required super.credits});

//   factory Course_12.fromJson(Map<String, dynamic> json) {
//     return Course_12(
//       name: json['name'],
//       grade: json['grade'],
//       credits: json['credits'],
//     );
//   }
// }
