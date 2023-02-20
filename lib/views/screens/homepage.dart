import 'package:drag_drop_game/globals.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Drag & Drop Challenge",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "Score : ${Globals.score}/100",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: (Globals.animals.isEmpty)
          ? Center(
              child: Container(
                alignment: Alignment.center,
                height: 330,
                width: 500,
                child: Dialog(
                  child: Column(
                    children: [
                      Spacer(),
                      const Text(
                        "Game Over",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            (Globals.score > 10) ? "⭐" : "",
                            style: TextStyle(fontSize: 40),
                          ),
                          Text(
                            (Globals.score > 50) ? "⭐" : "",
                            style: TextStyle(fontSize: 40),
                          ),
                          Text(
                            (Globals.score >= 85) ? "⭐" : "",
                            style: TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Total Score = ${Globals.score}",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      FloatingActionButton.extended(
                        label: Text(
                          "Play again!",
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: Icon(
                          Icons.restart_alt_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          setState(() {
                            Globals.animals = Globals.copyAnimals;
                            Globals.animals.shuffle();
                            Globals.score = 0;
                          });
                        },
                        elevation: 0,
                        backgroundColor: Colors.grey.shade500,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ...Globals.animals
                          .map(
                            (e) => ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                margin: EdgeInsets.all(15),
                                height: size.height * 0.18,
                                width: size.width * 0.37,
                                child: Draggable(
                                  data: e['data'],
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset(
                                      "${e['image']}",
                                      height: size.height * 0.1,
                                      width: size.width * 0.3,
                                    ),
                                  ),
                                  childWhenDragging: Container(),
                                  feedback: SizedBox(
                                    height: size.height * 0.14,
                                    width: size.width * 0.3,
                                    child: Image.asset(
                                      "${e['image']}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList()
                        ..shuffle(),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ...Globals.animals
                          .map(
                            (e) => SizedBox(
                              height: size.height * 0.12,
                              width: size.width * 0.5,
                              child: DragTarget(
                                builder: (context, accepted, rejected) {
                                  Globals.isDrag = e['isDrag'];
                                  return Container(
                                    margin: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                    ),
                                    child: Text(
                                      "${e['text']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                        color: Colors.white,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  );
                                },
                                onWillAccept: (data) {
                                  return data == e['data'];
                                },
                                onAccept: (data) {
                                  setState(() {
                                    if (e['isDrag'] == false) {
                                      Globals.animals.remove(e);
                                    }
                                    if (data == e['data']) {
                                      Globals.score += 10;
                                    }
                                  });
                                },
                                onLeave: (data) {
                                  setState(() {
                                    if (Globals.score > 0) {
                                      Globals.score -= 5;
                                    }
                                  });
                                },
                              ),
                            ),
                          )
                          .toList()
                        ..shuffle(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
