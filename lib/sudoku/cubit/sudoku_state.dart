part of 'sudoku_cubit.dart';

enum SudokuStatus {
  initial,
  playing,
  solved,
  failed,
}

class SudokuState extends Equatable {
  const SudokuState({
    this.level,
    this.status = SudokuStatus.initial,
    this.cells = const [],
  });

  final Level? level;
  final SudokuStatus status;
  final List<SudokuCell> cells;

  SudokuState copyWith({
    Level? level,
    SudokuStatus? status,
    List<SudokuCell>? cells,
  }) => SudokuState(
    level: level ?? this.level,
    status: status ?? this.status,
    cells: cells ?? this.cells,
  );

  @override
  List<Object?> get props => [level, status, cells];
}
