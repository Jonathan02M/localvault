import 'package:hive/hive.dart';
import '../models/user_profile.dart';

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 1;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return UserProfile(
      name: fields[0] as String? ?? '',
      email: fields[1] as String? ?? '',
      registrationDate: fields[2] as DateTime? ?? DateTime.now(),
      score: fields[3] as int? ?? 0,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.registrationDate)
      ..writeByte(3)
      ..write(obj.score);
  }
}
