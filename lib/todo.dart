import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 10)
class ToDo {
  
  @HiveField(0)
  final String title;

  @HiveField(1)
  final bool isCompleted;

  ToDo({
    required this.title,
    required this.isCompleted,
  });
}

const String boxName = 'todo';