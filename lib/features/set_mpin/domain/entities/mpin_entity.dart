import 'package:equatable/equatable.dart';
import 'package:mpin_demo/features/set_mpin/data/models/mpin_model.dart';

class MpinEntity extends Equatable {
  final String pin;

  const MpinEntity({
    required this.pin,
  });

  factory MpinEntity.fromJson(Map<String, dynamic> json) {
    return MpinEntity(
      pin: json['pin'],
    );
  }
  factory MpinEntity.toEntity(MpinModel model) {
    return MpinEntity(
      pin: model.pin,
    );
  }

  @override
  List<Object?> get props => [pin];
}
