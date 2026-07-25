import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.authRepository}) : super(const HomeState()) {
    on<HomeLogoutRequested>(_onLogoutRequested);
  }

  final AuthRepository authRepository;

  Future<void> _onLogoutRequested(
    HomeLogoutRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoggingOut: true,
        clearFailure: true,
        clearNavigation: true,
      ),
    );

    try {
      await authRepository.logout();
      emit(
        state.copyWith(
          isLoggingOut: false,
          navigateToLogin: true,
          clearFailure: true,
        ),
      );
    } on Object catch (error) {
      emit(
        state.copyWith(
          isLoggingOut: false,
          failureMessage: error.toString(),
          clearNavigation: true,
        ),
      );
    }
  }
}
