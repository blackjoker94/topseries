import 'package:flutter/material.dart';
import 'package:topseries/app_router.dart';

void main() {
  runApp( TopSeriesApp(appRouter: AppRouter(),));
}

class TopSeriesApp extends StatelessWidget {

  final AppRouter appRouter;

  const TopSeriesApp({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
