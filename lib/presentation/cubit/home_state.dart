part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class ValueAdded extends HomeState {}
final class ValueRead extends HomeState {}
final class ValueDeleted extends HomeState {}
final class AllValueDeleted extends HomeState {}
final class IsStrikes extends HomeState {}
final class ValueUpdated extends HomeState {}
