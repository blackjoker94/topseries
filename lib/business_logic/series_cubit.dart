import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:topseries/data/models/series.dart';
import 'package:topseries/data/repos/series_repo.dart';

part 'series_state.dart';

class SeriesCubit extends Cubit<SeriesState> {
  final SeriesRepo seriesRepo;
  List<Series> mySeries=[];

  SeriesCubit(this.seriesRepo) : super(SeriesInitial());


  List<Series>getAllSeries()
  {
    seriesRepo.getAllSeries().then((series) {
      emit(SeriesLoaded(series));

      mySeries=series;

    });
    return mySeries;
  }
}
