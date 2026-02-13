import 'package:isar/isar.dart';

part 'scripture.g.dart';

@collection
class Scripture {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String book;

  late int chapter;

  late int verse;

  late String text;

  @Index()
  DateTime? lastRead;
}
