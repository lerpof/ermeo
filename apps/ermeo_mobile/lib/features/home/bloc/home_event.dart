part of 'home_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

final class HomeLogoutRequested extends HomeEvent {
  const HomeLogoutRequested();
}
