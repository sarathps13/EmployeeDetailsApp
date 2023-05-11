import 'package:hive_flutter/adapters.dart';
part 'employeeModel.g.dart';

@HiveType(typeId: 0)
class EmployeeModel {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? age;
  @HiveField(2)
  String? gmail;
  @HiveField(3)
  String? phone;
  @HiveField(4)
  String? urImage;

  EmployeeModel(
      {required this.name,
      required this.age,
      required this.gmail,
      required this.phone,
      required this.urImage});
}
