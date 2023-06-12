import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
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
    loadmovies();
    super.initState();


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
   // print(movies);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: textstyle(text:'Popular Movies Using IMDB',size: 25,)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: 1000,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              mainAxisExtent: 250),
                itemCount: movies.length,
                itemBuilder: (context,index){
                 // print('http://image.tmdb.org./t/p/w500'+movies[index]['poster_path']);
                  //print('**************');
                return Column(
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: NetworkImage(
                            'http://image.tmdb.org./t/p/w200'+movies[index]['poster_path']
                          )
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: textstyle(text: movies[index]['title'], size: 15),
                    ),
                  ],
                );
            }),
          ),
        ),
      )
    );
  }
}
class textstyle extends StatelessWidget{
  final String text;
  final double size;

  const textstyle({super.key, required this.text,required this.size});

  Widget build(BuildContext context){
    return Text(text,
    style: GoogleFonts.acme(fontSize: size),
    textAlign: TextAlign.center,);
  }
}