import 'package:bloc/bloc.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, bool> {
  ThemeBloc() : super(false) {
    on<ThemeToggled>((event, emit) => emit(!state));
  }
}
