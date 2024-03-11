/// A class representing a course.
class Course {
  /// The name of the course.
  String name;

  /// The grade achieved in the course.
  String grade;

  /// The number of credits for the course.
  double credits;

  /// The type of the course (e.g., Honors, AP, Dual Enrollment).
  String type;

  /// Constructor for the Course class.
  Course({
    required this.name,
    required this.grade,
    required this.credits,
    required this.type,
  });

  /// Converts the Course object to a JSON representation.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'grade': grade,
      'credits': credits,
      'type': type,
    };
  }

  /// Factory constructor to create a Course object from JSON.
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'],
      grade: json['grade'],
      credits: json['credits'],
      type: json['type'],
    );
  }
}

/// A class representing a 9th grade course, extends Course.
class Course_9 extends Course {
  /// Constructor for the Course_9 class.
  Course_9({
    required String name,
    required String grade,
    required double credits,
    required String type,
  }) : super(
          name: name,
          grade: grade,
          credits: credits,
          type: type,
        );

  /// Factory constructor to create a Course_9 object from JSON.
  factory Course_9.fromJson(Map<String, dynamic> json) {
    return Course_9(
      name: json['name'],
      grade: json['grade'],
      credits: json['credits'],
      type: json['type'],
    );
  }
}

/// A class representing a 10th grade course, extends Course.
class Course_10 extends Course {
  /// Constructor for the Course_10 class.
  Course_10({
    required String name,
    required String grade,
    required double credits,
    required String type,
  }) : super(
          name: name,
          grade: grade,
          credits: credits,
          type: type,
        );

  /// Factory constructor to create a Course_10 object from JSON.
  factory Course_10.fromJson(Map<String, dynamic> json) {
    return Course_10(
      name: json['name'],
      grade: json['grade'],
      credits: json['credits'],
      type: json['type'],
    );
  }
}

/// A class representing an 11th grade course, extends Course.
class Course_11 extends Course {
  /// Constructor for the Course_11 class.
  Course_11({
    required String name,
    required String grade,
    required double credits,
    required String type,
  }) : super(
          name: name,
          grade: grade,
          credits: credits,
          type: type,
        );

  /// Factory constructor to create a Course_11 object from JSON.
  factory Course_11.fromJson(Map<String, dynamic> json) {
    return Course_11(
      name: json['name'],
      grade: json['grade'],
      credits: json['credits'],
      type: json['type'],
    );
  }
}

/// A class representing a 12th grade course, extends Course.
class Course_12 extends Course {
  /// Constructor for the Course_12 class.
  Course_12({
    required String name,
    required String grade,
    required double credits,
    required String type,
  }) : super(
          name: name,
          grade: grade,
          credits: credits,
          type: type,
        );

  /// Factory constructor to create a Course_12 object from JSON.
  factory Course_12.fromJson(Map<String, dynamic> json) {
    return Course_12(
      name: json['name'],
      grade: json['grade'],
      credits: json['credits'],
      type: json['type'],
    );
  }
}