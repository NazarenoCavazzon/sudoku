import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/sudoku/cubit/sudoku_cubit.dart';
import 'package:sudoku/sudoku/widgets/widgets.dart';

class SudokuPage extends StatelessWidget {
  const SudokuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SudokuCubit(),
      child: const SudokuView(),
    );
  }
}

class SudokuView extends StatelessWidget {
  const SudokuView({super.key});

  @override
  Widget build(BuildContext context) {
    final level = context.select((SudokuCubit cubit) => cubit.state.level);
    final levelNumber = level?.level ?? 0;
    final title = levelNumber == 0 ? 'Sudoku' : 'Sudoku Level $levelNumber';

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: BlocConsumer<SudokuCubit, SudokuState>(
            listener: (context, state) async {
              if (state.status != SudokuStatus.solved) return;
              await _showSolvedDialog(context);
            },
            listenWhen: (previous, current) =>
                previous.status != current.status,
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              if (state.status == SudokuStatus.initial) {
                return const StartButton();
              }
              return const SudokuBoard();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showSolvedDialog(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    await showDialog<bool>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<SudokuCubit>(),
        child: const SolvedDialog(),
      ),
    );
  }
}
