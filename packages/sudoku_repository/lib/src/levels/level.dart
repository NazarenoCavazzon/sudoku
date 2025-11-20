import 'package:equatable/equatable.dart';
import 'package:sudoku_repository/src/models/models.dart';

class Level extends Equatable {
  const Level({
    required this.level,
    required this.puzzle,
    required this.solution,
  });

  final int level;
  final List<List<int>> puzzle;
  final List<List<int>> solution;

  Level copyWith({
    int? level,
    List<List<int>>? puzzle,
    List<List<int>>? solution,
  }) => Level(
    level: level ?? this.level,
    puzzle: puzzle ?? this.puzzle,
    solution: solution ?? this.solution,
  );

  List<SudokuCell> get cells {
    final result = <SudokuCell>[];
    for (var row = 0; row < puzzle.length; row++) {
      for (var col = 0; col < puzzle[row].length; col++) {
        final value = puzzle[row][col];
        result.add(
          SudokuCell(
            row: row,
            column: col,
            value: value == 0 ? null : value,
            isFixed: value != 0,
          ),
        );
      }
    }
    return result;
  }

  @override
  List<Object?> get props => [
    level,
    puzzle,
    solution,
  ];
}
