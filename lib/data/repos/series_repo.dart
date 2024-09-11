import 'package:flutter/material.dart';

import 'package:topseries/data/web_services/api.dart';

import '../models/series.dart';

class SeriesRepo {
  final Api api;

  SeriesRepo(this.api);

  Future<List<Series>> getAllSeries() async {

    final series = await api.getAllSeries();
    return series.map((series)=> Series.fromJson(series)).toList();
  }
}