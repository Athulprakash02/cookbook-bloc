import 'package:hive/hive.dart';
part 'comments_db.g.dart';

@HiveType(typeId: 3)
class CommentsData extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String userName;

  @HiveField(2)
  final String recipeName;

  @HiveField(3)
  final String comment;

  CommentsData(
      {
        this.id,
      required this.userName,
      required this.recipeName,
      required this.comment
      });
}
