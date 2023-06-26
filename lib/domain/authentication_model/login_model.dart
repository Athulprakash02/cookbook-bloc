import 'package:hive/hive.dart';
part 'login_model.g.dart';

@HiveType(typeId: 1)
class LoginData extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  @HiveField(4)
  final String confirmPassword;

  LoginData(
      {
        this.id,
        required this.fullName,
      required this.email,
      required this.password,
      required this.confirmPassword});
}
