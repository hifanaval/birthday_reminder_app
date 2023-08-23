// To parse this JSON data, do
//
//     final staffModel = staffModelFromJson(jsonString);

import 'dart:convert';

StaffModel staffModelFromJson(String str) => StaffModel.fromJson(json.decode(str));

String staffModelToJson(StaffModel data) => json.encode(data.toJson());

class StaffModel {
    List<Staff>? staffs;
    int? staffcount;

    StaffModel({
        this.staffs,
        this.staffcount,
    });

    factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
        staffs: json["staffs"] == null ? [] : List<Staff>.from(json["staffs"]!.map((x) => Staff.fromJson(x))),
        staffcount: json["staffcount"],
    );

    Map<String, dynamic> toJson() => {
        "staffs": staffs == null ? [] : List<dynamic>.from(staffs!.map((x) => x.toJson())),
        "staffcount": staffcount,
    };
}

class Staff {
    String? staffName;
    DateTime? dob;
    String? designation;
    String? profilePic;
    String? department;

    Staff({
        this.staffName,
        this.dob,
        this.designation,
        this.profilePic,
        this.department,
    });

    factory Staff.fromJson(Map<String, dynamic> json) => Staff(
        staffName: json["staff_name"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        designation: json["designation"],
        profilePic: json["profile_pic"],
        department: json["department"],
    );

    Map<String, dynamic> toJson() => {
        "staff_name": staffName,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "designation": designation,
        "profile_pic": profilePic,
        "department": department,
    };
}
