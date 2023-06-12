import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tasksecond/API.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List movies=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadmovies();
  }
  loadmovies() async{
    TMDB tmdbwithCustomLogs= TMDB(ApiKeys(dotenv.env['APIKey']!,dotenv.env['ReadAccessToken']!),
      logConfig: ConfigLogger(
        showLogs: true,//must be true than only all other logs will be shown
        showErrorLogs: true,
      ),
    );
    Map popular = await tmdbwithCustomLogs.v3.movies.getPopular();
    setState(() {
      movies=popular['results'];
    });
    print(movies);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100,
        child: Column(
          children: [
            Text('Popular'),
            ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context,index){
                return InkWell(
                  onTap: (){},
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'http://image.tmdb.org./t/p/w500'+movies[index]['poster_path']
                        )
                      )
                    ),
                  ),
                );
            }),
          ],
        ),
      )
    );
  }
}
