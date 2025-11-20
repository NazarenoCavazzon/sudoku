import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sudoku_repository/sudoku_repository.dart';

part 'sudoku_state.dart';

class SudokuCubit extends Cubit<SudokuState> {
  SudokuCubit() : super(const SudokuState());

  void startGame() {
    final level = levelList[0];
    emit(
      state.copyWith(
        level: level,
        cells: level.cells,
        status: SudokuStatus.playing,
      ),
    );
  }

  void restartGame() {
    final level = state.level;

    emit(
      state.copyWith(
        cells: level?.cells,
        status: SudokuStatus.playing,
      ),
    );
  }

  void nextLevel() {
    final newLevel = levelList[state.level?.level ?? 0 + 1];

    emit(
      state.copyWith(
        level: newLevel,
        cells: newLevel.cells,
        status: SudokuStatus.playing,
      ),
    );
  }

  void onCellChanged(int index, String value) {
    final cells = List<SudokuCell>.from(state.cells);
    cells[index] = cells[index].copyWith(value: int.tryParse(value));

    _updateCellValidation(cells, cells[index]);

    emit(state.copyWith(cells: cells));

    _checkIfSolved();
  }

  void _updateCellValidation(List<SudokuCell> cells, SudokuCell changedCell) {
    final boxRow = changedCell.row ~/ 3;
    final boxCol = changedCell.column ~/ 3;

    for (var i = 0; i < cells.length; i++) {
      final cell = cells[i];
      final isAffected =
          cell.row == changedCell.row ||
          cell.column == changedCell.column ||
          (cell.row ~/ 3 == boxRow && cell.column ~/ 3 == boxCol);

      if (!isAffected) continue;

      final isInvalid =
          _hasInvalidRow(cells, cell.row) ||
          _hasInvalidColumn(cells, cell.column) ||
          _hasInvalidBox(cells, cell.row, cell.column);
      cells[i] = cell.copyWith(value: cell.value, isInvalid: isInvalid);
    }
  }

  void _checkIfSolved() {
    if (state.cells.any((cell) => cell.value == null)) {
      return;
    }

    if (state.cells.any((cell) => cell.isInvalid)) {
      return;
    }

    emit(state.copyWith(status: SudokuStatus.solved));
  }

  bool _hasInvalidRow(List<SudokuCell> cells, int rowIndex) {
    final rowValues = cells
        .where((cell) => cell.row == rowIndex && cell.value != null)
        .map((cell) => cell.value!)
        .toList();

    return rowValues.length != rowValues.toSet().length;
  }

  bool _hasInvalidColumn(List<SudokuCell> cells, int colIndex) {
    final colValues = cells
        .where((cell) => cell.column == colIndex && cell.value != null)
        .map((cell) => cell.value!)
        .toList();

    return colValues.length != colValues.toSet().length;
  }

  bool _hasInvalidBox(List<SudokuCell> cells, int row, int col) {
    const boxSize = 3;
    final boxRow = row ~/ boxSize;
    final boxCol = col ~/ boxSize;

    final boxValues = cells
        .where(
          (cell) =>
              cell.value != null &&
              cell.row ~/ boxSize == boxRow &&
              cell.column ~/ boxSize == boxCol,
        )
        .map((cell) => cell.value!)
        .toList();

    return boxValues.length != boxValues.toSet().length;
  }
}
