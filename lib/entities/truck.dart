import 'package:objectbox/objectbox.dart';

@Entity()
class Truck {
  @Id()
  int truckId; //jika nama identifier selain id (misal: truckId), maka wajib baginya diberikan anotasi @Id().
  final String typeName;

  @Unique()
  final String noKa;

  @Unique()
  final String noSin;

  Truck(
      {this.truckId = 0,
      required this.typeName,
      required this.noKa,
      required this.noSin});
}
