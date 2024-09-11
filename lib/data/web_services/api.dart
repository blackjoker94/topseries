import 'package:dio/dio.dart';
import 'package:topseries/constants/strings.dart';
class Api {
 late Dio dio;

 Api() {
   BaseOptions options = BaseOptions(
     baseUrl: baseUrl,
     receiveDataWhenStatusError: true,
     connectTimeout: Duration(seconds: 16),
     receiveTimeout: Duration(seconds: 16),
   );

   dio = Dio(options);
 }
   Future<List<dynamic>> getAllSeries() async {
    try {
      Response response = await dio.get('series',
        options: Options(
        headers: {
          'x-rapidapi-key': apiKey,
          'x-rapidapi-host': apiHost,
        },
      ),);
      print(response.data);
      return response.data;
    }
    catch(e){
      print(e.toString());
      return [];
    }

   }
 }
