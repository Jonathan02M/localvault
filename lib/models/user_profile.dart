import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class UserProfile extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  DateTime registrationDate;

  @HiveField(3)
  int score;

  UserProfile({
    required this.name,
    required this.email,
    required this.registrationDate,
    required this.score,
  });
}
