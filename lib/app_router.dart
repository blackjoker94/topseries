import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topseries/business_logic/series_cubit.dart';
import 'package:topseries/data/repos/series_repo.dart';
import 'package:topseries/data/web_services/api.dart';
import 'package:topseries/presentation/screens/series_details.dart';
import 'constants/strings.dart';
import 'data/models/series.dart';
import 'presentation/screens/series_screen.dart';

class AppRouter {
  late SeriesRepo seriesRepo;
  late SeriesCubit seriesCubit;

  AppRouter() {
    seriesRepo = SeriesRepo(Api());
    seriesCubit = SeriesCubit(seriesRepo);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case seriesScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => seriesCubit,
            child: const SeriesScreen(),
          ),
        );
      case seriesDetailsScreen:
        final series = settings.arguments as Series;
        return MaterialPageRoute(builder: (_) => SeriesDetails(series: series,));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
