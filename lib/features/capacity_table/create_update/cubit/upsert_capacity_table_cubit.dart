import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_string.dart';
import 'package:uuid/uuid.dart';

part 'upsert_capacity_table_state.dart';

class UpsertCapacityTableCubit extends Cubit<UpsertCapacityTableState> {
  UpsertCapacityTableCubit(this.tanksRepository)
      : super(const UpsertCapacityTableState());
  final CapacityTableRepository tanksRepository;

  void init(List<CapacityEntity> list) {
    emit(state.copyWith(capacityEntitys: list));
  }

  void onSelectedEditItem(CapacityEntity capacityEntity) {
    emit(state.copyWith(selectedEditCapacity: capacityEntity));
  }

  Future<void> create({
    required int idTanque,
  }) async {
    emit(state.copyWith(upsertStatus: UpsertStatus.loading));
    final list = [...state.capacityEntitys];

    final result = await tanksRepository.saveCapacityTable(
      CapacityTableEntity(
        idTanque: idTanque,
        idCompania: 1,
        data: list,
      ),
    );

    result.when(
      ok: (ok) {
        emit(state.copyWith(upsertStatus: UpsertStatus.success));
      },
      err: (err) {
        if (err is ResultFailure) {
          emit(
            state.copyWith(
              upsertStatus: UpsertStatus.error,
              errorMessage: err.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              upsertStatus: UpsertStatus.error,
              errorMessage: 'Error desconocido',
            ),
          );
        }
        //emit(state.copyWith(upsertStatus: UpsertStatus.error));
      },
    );
  }

  void addStagingItem() {
    const uuid = Uuid();
    final v4 = uuid.v4();
    final list = [...state.capacityEntitys];
    final newList = [
      ...list,
      CapacityEntity(
        alturaTanque: 0,
        volumen: 0,
        idStaging: v4,
        idAforo: 0,
      ),
    ];
    emit(
      state.copyWith(
        capacityEntitys: newList,
      ),
    );
  }

  void addStagingItemCSV(String input) {
    const uuid = Uuid();
    final listAforos = procesarCSV(input);
    final aforos = listAforos
        .map(
          (e) => CapacityEntity(
            alturaTanque: e.$1,
            volumen: e.$2,
            idStaging: uuid.v4(),
            idAforo: 0,
          ),
        )
        .toList();
    emit(state.copyWith(capacityEntitys: aforos));
  }

  bool validarFormatoCSV(String input) {
    final regex = RegExp(r'^(\d+,\d+;\d+,\d+\n?)+$');
    return regex.hasMatch(input);
  }

  List<(double, double)> procesarCSV(String input) {
    // Divide las líneas del texto
    final lines = input.split('\n').where((line) => line.isNotEmpty);

    // Procesa cada línea para convertir los valores a double
    final resultado = lines.map((line) {
      // Divide la línea por el separador `;`
      final valores = line.split(';');

      // Reemplaza las comas con puntos y convierte a double
      final valor1 = double.parse(valores[0].replaceAll(',', '.'));
      final valor2 = double.parse(valores[1].replaceAll(',', '.'));

      return (valor1, valor2);
    }).toList();

    return resultado;
  }

  void addSecuence(int cantidad, double secuencia) {
    final listAforos = <double>[];
    var lastNumber = 0.0;
    for (var i = 0; i < cantidad; i++) {
      lastNumber = lastNumber + secuencia;
      listAforos.add(lastNumber);
    }
    const uuid = Uuid();

    final aforos = listAforos
        .map(
          (e) => CapacityEntity(
            alturaTanque: e,
            volumen: 0,
            idStaging: uuid.v4(),
            idAforo: 0,
          ),
        )
        .toList();
    emit(state.copyWith(capacityEntitys: aforos));
  }

  void editStagingItem(String idStaging, String altura, String volumen) {
    final list = [...state.capacityEntitys];

    final item = list.firstWhereOrNull(
      (element) => element.idStaging == idStaging,
    );
    if (item == null) return;
    final index = list.indexOf(item);

    list[index] = item.copyWith(
      alturaTanque: altura.toDoubleSafe(),
      volumen: volumen.toDoubleSafe(),
    );

    emit(
      state.copyWith(
        capacityEntitys: list,
      ),
    );
  }

  void removeStagingItem(String idStaging) {
    final list = [...state.capacityEntitys];

    list.removeWhere((element) => element.idStaging == idStaging);

    emit(
      state.copyWith(
        capacityEntitys: list,
      ),
    );
  }

  /*Future<void> update({
    required CapacityTableEntity tanksEntity,
    required int idTanque,
    required String alturaTanque,
    required String volumen,
  }) async {
    emit(state.copyWith(upsertStatus: UpsertStatus.loading));
    final result = await tanksRepository.updateCapacityTable(
      tanksEntity.copyWith(
        idTanque: idTanque,
        alturaTanque: double.parse(alturaTanque),
        volumen: double.parse(volumen),
      ),
    );

    result.when(
      ok: (ok) {
        emit(state.copyWith(upsertStatus: UpsertStatus.success));
      },
      err: (err) {
        emit(state.copyWith(upsertStatus: UpsertStatus.error));
      },
    );
  }*/
}
