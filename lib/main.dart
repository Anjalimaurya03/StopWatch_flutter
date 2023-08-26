import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {

  int seconds= 0, minutes = 0, hours = 0;
  String digitSeconds = "00", digitMinutes = '00',digitHours = '00';
  Timer? timer;
  bool started = false;
  List laps = [];



// creating stop timer function
  void stop(){
    timer!.cancel();
    setState(() {
      started = false;
    });
  }


// creating reset timer function
   void reset(){
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeconds = '00';
      digitMinutes = '00';
      digitHours = '00';

      started = false;
    });
   }

   void addlaps(){
    String lap = '$digitHours:$digitMinutes:$digitSeconds';
    setState(() {
      laps.add(lap);
    });
   }


//creating start timer function
  void start(){
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if(localSeconds  > 59){
        if(localMinutes > 59){
          localHours++;
          localMinutes = 0;
        }else{
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds  = localSeconds;
        minutes = localMinutes;
        hours = localHours;

        digitSeconds = (seconds >= 10) ?'$seconds':'0$seconds';
        digitMinutes = (minutes >= 10) ?'$minutes':'0$minutes';
        digitHours = (hours >= 10) ?'$hours':'0$hours';
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1C2757),
      body: SafeArea(
          child: Padding(padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Center(
                  child: Text(
                    'StopWatch App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20.0,),

                Center(
                  child: Text(
                    '$digitHours:$digitMinutes:$digitSeconds',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 85.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                Container(
                  height: 400.0,
                  decoration: BoxDecoration(
                    color: Color(0xff323f68),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Laps ${index+1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            '${laps[index]}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },)
                ),

                const SizedBox(
                  height: 20.0,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Expanded(
                        child: RawMaterialButton(
                          onPressed: (){
                            (!started)? start():stop();
                          },
                          fillColor: Colors.blue,
                          shape: StadiumBorder(

                          ),
                          child: Text(
                            (!started)? 'Start':'Pause',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ),


                    IconButton(
                      color: Colors.white,
                      onPressed: (){
                        addlaps();
                      },
                      icon: Icon(Icons.flag),
                    ),


                    Expanded(
                      child: RawMaterialButton(
                        onPressed: (){
                          reset();
                        },
                        fillColor: Colors.blue,
                        shape: StadiumBorder(

                        ),
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ],
            ),
          ),

      ),
    );
  }
}



