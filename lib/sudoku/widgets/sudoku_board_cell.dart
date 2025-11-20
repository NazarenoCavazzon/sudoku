import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/sudoku/cubit/sudoku_cubit.dart';
import 'package:sudoku/utils/formatters.dart';

class SudokuBoardCell extends StatelessWidget {
  const SudokuBoardCell(
    this.index, {
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SudokuCubit, SudokuState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final cell = state.cells[index];
        final isInvalid = cell.isInvalid;

        if (cell.isFixed) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(),
              color: isInvalid ? Colors.red.shade100 : Colors.yellow.shade100,
            ),
            alignment: Alignment.center,
            child: Text(
              cell.value.toString(),
              style: TextStyle(
                color: isInvalid ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          );
        }

        return Container(
          decoration: BoxDecoration(
            border: Border.all(),
            color: isInvalid ? Colors.red.shade100 : Colors.yellow.shade100,
          ),
          alignment: Alignment.center,
          child: TextField(
            key: ValueKey('${state.level?.level}_$index'),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              isDense: true,
              border: InputBorder.none,
              counterText: '',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              NoZeroFormatter(),
            ],
            maxLength: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isInvalid ? Colors.red : Colors.purple,
            ),
            onChanged: (value) {
              context.read<SudokuCubit>().onCellChanged(index, value);
            },
          ),
        );
      },
    );
  }

  bool _buildWhen(SudokuState previous, SudokuState current) =>
      previous.cells != current.cells;
}
