import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:mpin_demo/core/error/failure.dart';
import 'package:mpin_demo/features/set_mpin/data/datasources/mpin_local_datasource.dart';
import 'package:mpin_demo/features/set_mpin/data/models/mpin_model.dart';
import 'package:mpin_demo/features/set_mpin/domain/entities/mpin_entity.dart';
import 'package:mpin_demo/features/set_mpin/domain/repositoryInterfaces/mpin_repository.dart';

class MpinRepositoryImpl implements MpinRepository {
  final MPinLocalDataSource mPinLocalDataSource;

  MpinRepositoryImpl({required this.mPinLocalDataSource});

  @override
  Future<List<MpinEntity>> getMpin() async {
    final pinModels = mPinLocalDataSource.getMpinFromDB();
    final pins = pinModels.map((e) => MpinEntity.toEntity(e)).toList();
    return pins;
  }

  @override
  Future<void> setMpin(MpinEntity pinObj) async {
    debugPrint('Repository Imp called..');
    mPinLocalDataSource.saveMpinToDB(MpinModel.fromEntity(pinObj));
  }
}
