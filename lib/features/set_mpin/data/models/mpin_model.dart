import 'package:mpin_demo/features/set_mpin/domain/entities/mpin_entity.dart';

// ignore: must_be_immutable
class MpinModel extends MpinEntity {
  const MpinModel({
    required super.pin,
  });

  factory MpinModel.fromJson(Map<String, dynamic> json) {
    return MpinModel(
      pin: json['pin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pin': pin,
    };
  }

  factory MpinModel.fromEntity(MpinEntity entity) => MpinModel(
        pin: entity.pin,
      );
}
