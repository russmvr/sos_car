import 'package:equatable/equatable.dart';

class Evacuator with EquatableMixinBase {
  final String evacuatorType;
  final int lengthOfPlatform;
  final int platformWidth;
  final int carrying;
  final String vehicleCategory;
  String platformType;
  int boomLength;

  Evacuator(
      {this.evacuatorType,
        this.lengthOfPlatform,
      this.platformWidth,
      this.carrying,
      this.vehicleCategory,
      this.platformType,
      this.boomLength});
}

class EasyEvacuator extends Evacuator with EquatableMixin  {
  EasyEvacuator(
      {evacuatorType,
        lengthOfPlatform,
      platformWidth,
      carrying,
      platformType,
      vehicleCategory, boomLength})
      : super(
            evacuatorType: evacuatorType,
            lengthOfPlatform: lengthOfPlatform,
            platformWidth: platformWidth,
            carrying: carrying,
            platformType: platformType,
            vehicleCategory: vehicleCategory,
      boomLength: boomLength);
}

class ManipulatorEvacuator extends Evacuator with EquatableMixin {
  ManipulatorEvacuator(
      {evacuatorType,
        lengthOfPlatform,
      platformWidth,
      carrying,
      boomLength,
      vehicleCategory,
      platformType})
      : super(
            evacuatorType: evacuatorType,
            lengthOfPlatform: lengthOfPlatform,
            platformWidth: platformWidth,
            carrying: carrying,
            boomLength: boomLength,
            vehicleCategory: vehicleCategory,
      platformType: platformType);
}

class CargoEvacuator extends Evacuator {
  CargoEvacuator(
      {evacuatorType,
        lengthOfPlatform,
      platformWidth,
      carrying,
      platformType,
      vehicleCategory, boomLength})
      : super(
            evacuatorType: evacuatorType,
            lengthOfPlatform: lengthOfPlatform,
            platformWidth: platformWidth,
            carrying: carrying,
            platformType: platformType,
            vehicleCategory: vehicleCategory,
      boomLength: boomLength);
}
