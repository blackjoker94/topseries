part of 'series_cubit.dart';

@immutable
sealed class SeriesState {}

final class SeriesInitial extends SeriesState {}

final class SeriesLoaded extends SeriesState {

  final List <Series> series;

  SeriesLoaded(this.series);
}
