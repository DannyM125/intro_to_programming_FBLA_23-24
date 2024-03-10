class Course {
  String name;
  String grade;
  double credits;
  String type;

  Course({
    required this.name,
    required this.grade,
    required this.credits,
    required this.type,
    
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'grade': grade,
      'credits': credits,
      'type': type,
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'],
      grade: json['grade'],
      credits: json['credits'],
      type: json['type'],
    );
  }
}

class Course_9 extends Course {
  Course_9({required super.name, required super.grade, required super.credits, required super.type});

  factory Course_9.fromJson(Map<String, dynamic> json) {
    return Course_9(
      name: json['name'],
      grade: json['grade'],
      credits: json['credits'],
      type: json['type'],

    );
  }
}

class Course_10 extends Course {
  Course_10({required super.name, required super.grade, required super.credits, required super.type});

  factory Course_10.fromJson(Map<String, dynamic> json) {
    return Course_10(
      name: json['name'],
      grade: json['grade'],
      credits: json['credits'],
      type: json['type'],

    );
  }
}

class Course_11 extends Course {
  Course_11({required super.name, required super.grade, required super.credits, required super.type});

  factory Course_11.fromJson(Map<String, dynamic> json) {
    return Course_11(
      name: json['name'],
      grade: json['grade'],
      credits: json['credits'],
      type: json['type'],

    );
  }
}

class Course_12 extends Course {
  Course_12({required super.name, required super.grade, required super.credits, required super.type});

  factory Course_12.fromJson(Map<String, dynamic> json) {
    return Course_12(
      name: json['name'],
      grade: json['grade'],
      credits: json['credits'],
      type: json['type'],

    );
  }
}
