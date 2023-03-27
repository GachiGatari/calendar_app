import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Week extends StatefulWidget{

  Week({super.key, required this.name, required this.daysList, required this.num});

  final String name;
  final int num;
  List<int> daysList = [];

  DateTime dateNow = DateTime.now();

  @override
  State<StatefulWidget> createState() => _WeekState();

}

class _WeekState extends State<Week>{

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: 55,
        child: Column(
            children: [
                SizedBox(
                height: 40,
                child: Center(child: Text(widget.name)),
              ),
              ListView.builder(
                shrinkWrap: true,
                        itemCount: widget.daysList.length,
                        itemBuilder: (BuildContext context, int index) {
                          bool shouldColor = false;
                          if(widget.daysList[index] > 100){
                            widget.daysList[index] -= 100;
                            shouldColor = true;
                          }

                          return widget.daysList[index] == 0 ?
                          Card(
                            elevation: 0.0,
                            child: SizedBox(
                              height: 40
                            ),
                          )
                              :
                          Card(
                            child: ColoredBox(
                              color:  shouldColor ? Colors.green : Colors.blue,
                              child: SizedBox(
                              height: 40,
                              child: Center(child:
                                Text(widget.daysList[index].toString())),
                              ),
                            ),
                          );
                        }
                    ),
            ],
          ),
      ),
    );

  }

}


class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Календарь',),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({super.key, required this.title,});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final List<String> ruMonth = [
    "Январь",
    "Февраль",
    "Март",
    "Апрель",
    "Май",
    "Июнь",
    "Июль",
    "Август",
    "Сентябрь",
    "Октябрь",
    "Ноябрь",
    "Декабрь",
  ];

  final List<String> weekName = [
    "Пн",
   "Вт",
    "Ср",
    "Чт",
    "Пт",
    "Сб",
    "Вс",
  ];
  DateTime nowDate = DateTime.now();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    List<Week> weeks = [];
    bool haveFirst = false;

    for (int i=1; i<8; i++){
      List<int> days = [];
      DateTime date = DateTime(widget.nowDate.year, widget.nowDate.month, 1);

      for (int j=1; j<31; j++){
        if (date.weekday == i) {
          DateTime nowDate = DateTime.now();
          if(date.compareTo(DateTime(nowDate.year, nowDate.month, nowDate.day)) == 0){
            days.add(date.day + 100);
          }
          else{
            days.add(date.day);
          }
          if (date.day == 1)
            haveFirst = true;
        }
        else{
          if(days.isEmpty & !haveFirst){
            days.add(0);
          }
        }
        date = date.add(Duration(days: 1));
      }


      Week week = Week(name: widget.weekName[i - 1], daysList: days, num: i, );
      weeks.add(week);
      print(days.toString());

    }


    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      widget.nowDate = widget.nowDate.subtract(Duration(days: 30));
                    });
                  },
                ),
                Text(widget.nowDate.year.toString() + ", " + widget.ruMonth[widget.nowDate.month - 1]!,
                style: TextStyle(
                  fontSize: 30
                ),
                ),
                IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    setState(() {
                      widget.nowDate = widget.nowDate.add(Duration(days: 30));
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: Row(
                children:  weeks
              ),
            ),
            Container(
              width: 70,
              height: 70,
              child: FloatingActionButton(

                child: Align(
                  alignment: Alignment.center,
                    child: Text(
                        "Текущий месяц",
                        style: TextStyle(fontSize: 10.0),
                        textAlign: TextAlign.center
                    )
                ),
                onPressed: () => {
                setState(() {
                  widget.nowDate = DateTime.now();
                })
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
