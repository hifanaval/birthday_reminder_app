// To parse this JSON data, do
//
//     final studentsModel = studentsModelFromJson(jsonString);

import 'dart:convert';

StudentsModel studentsModelFromJson(String str) => StudentsModel.fromJson(json.decode(str));

String studentsModelToJson(StudentsModel data) => json.encode(data.toJson());

class StudentsModel {
    List<Student>? students;
    int? count;

    StudentsModel({
        this.students,
        this.count,
    });

    factory StudentsModel.fromJson(Map<String, dynamic> json) => StudentsModel(
        students: json["students"] == null ? [] : List<Student>.from(json["students"]!.map((x) => Student.fromJson(x))),
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "students": students == null ? [] : List<dynamic>.from(students!.map((x) => x.toJson())),
        "count": count,
    };
}

class Student {
    String? studentName;
    DateTime? dob;
    String? designation;
    String? profilePic;
    String? course;
    String? batchYear;

    Student({
        this.studentName,
        this.dob,
        this.designation,
        this.profilePic,
        this.course,
        this.batchYear,
    });

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        studentName: json["student_name"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        designation: json["designation"],
        profilePic: json["profile_pic"],
        course: json["course"],
        batchYear: json["batch_year"],
    );

    Map<String, dynamic> toJson() => {
        "student_name": studentName,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "designation": designation,
        "profile_pic": profilePic,
        "course": course,
        "batch_year": batchYear,
    };
}
