import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/sudoku/cubit/sudoku_cubit.dart';

class SolvedDialog extends StatelessWidget {
  const SolvedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Congratulations!'),
      content: const Text(
        'You have solved the puzzle. Would you like to continue to the next level or restart the game?',
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Restart'),
          onPressed: () {
            context.read<SudokuCubit>().restartGame();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Next'),
          onPressed: () {
            context.read<SudokuCubit>().nextLevel();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
