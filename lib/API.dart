import 'package:tmdb_api/tmdb_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
List trending=[];

loadmovies() async{
  TMDB tmdbwithCustomLogs= TMDB(ApiKeys(dotenv.env['APIKey']!,dotenv.env['ReadAccessToken']!),
    logConfig: ConfigLogger(
      showLogs: true,//must be true than only all other logs will be shown
      showErrorLogs: true,
    ),
  );
  Map trending = await tmdbwithCustomLogs.v3.trending.getTrending();
  print(trending);
  print(dotenv.env['APIKey']);
  print('*******************');
}