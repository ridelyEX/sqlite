import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite/db/sqlite.dart';

import '../db/planetas.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Planetas>? planets;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    planets = [];
    openDB();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    closeDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Builder(
          builder: (context) {
            consultar();
            if (planets!.isEmpty) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                  backgroundColor: Colors.white,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: planets!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: CupertinoListTile(
                      leading: Icon(CupertinoIcons.circle),
                      title: Text(planets![index].nombre!),
                      subtitle: Text(
                        "Distancia al sol ${planets![index].distSol!}",
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  void openDB() {
    SqLite.db().whenComplete(() async{
      await add();
    },);
  }

  void closeDB() {}

  void consultar() {}

  Future<void> add() async {
    List<Planetas> p = [
      Planetas(1, "MERCURIO", 2, 2.5),
      Planetas(2, "venus", 2.5, 23),
      Planetas(3, "Tierra", 8, 5),
      Planetas(4, "Marte", 9, 4),
      Planetas(5, "Jupiter", 14, 20),
      Planetas(6, "MEercurio", 16, 15),
    ];
    int result=0;
    await SqLite.add(p);
  }
}
