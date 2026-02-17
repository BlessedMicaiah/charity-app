import 'package:objectbox/objectbox.dart';

@Entity()
class Scripture {
  @Id()
  int id = 0;

  @Index()
  late String book;

  late int chapter;

  late int verse;

  late String text;

  @Index()
  @Property(type: PropertyType.date)
  DateTime? lastRead;
}
