import 'package:equatable/equatable.dart';

class SudokuCell extends Equatable {
  const SudokuCell({
    required this.column,
    required this.row,
    required this.value,
    this.isFixed = false,
    this.isInvalid = false,
  });

  final int? value;
  final int row;
  final int column;
  final bool isFixed;
  final bool isInvalid;

  SudokuCell copyWith({
    int? value,
    bool? isInvalid,
  }) => SudokuCell(
    value: value,
    row: row,
    column: column,
    isFixed: isFixed,
    isInvalid: isInvalid ?? this.isInvalid,
  );

  @override
  List<Object?> get props => [value, row, column, isFixed, isInvalid];
}
