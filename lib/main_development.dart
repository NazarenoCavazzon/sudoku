import 'package:sudoku/app/app.dart';
import 'package:sudoku/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
