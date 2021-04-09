import 'package:cornflake/todoui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cornflake',
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
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _lightOn = false;
  bool _livingRoom = false;
  bool _bedroom = false;
  bool _kitchen = false;
  bool _sceneMovie = false;
  bool _sceneRelax = false;
  bool _sceneBreakfast = false;
  double _temp = 18.0;

  void _toggleLight() {
    setState(() {
      if (_lightOn) {
        _lightOn = false;
        _kitchen = false;
        _bedroom = false;
        _livingRoom = false;
      } else {
        _lightOn = true;
        _livingRoom = true;
        _kitchen = true;
        _bedroom = true;
      }
    });
  }

  void _tempUp() {
    setState(() {
      _temp = _temp + 0.5;
    });
  }

  void _tempDown() {
    setState(() {
      _temp = _temp - 0.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.question_answer),
              onPressed: () => Get.to(() => HomeScreen()))
        ],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Image.asset('assets/images/cornflake-logo.png'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
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

            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 50),
                child: Card(
                  child: Center(child: Text('Lighting')),
                  color: Theme.of(context).buttonColor,
                ),
              ),
              ListTile(
                title: Text(
                  'All Lights',
                ),
                trailing: Icon(
                  _lightOn ? Icons.lightbulb : Icons.lightbulb_outline,
                  color: _lightOn ? Colors.blue : Colors.black,
                ),
                onTap: () => _toggleLight(),
              ),

              Center(
                child: Wrap(
                  children: [
                    FilterChip(
                      avatar: Icon(Icons.lightbulb),
                      selected: _livingRoom,
                      selectedColor: Colors.blue,
                      onSelected: (value) {
                        setState(() {
                          _livingRoom = value;
                        });
                      },
                      label: Text('Living Room'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    FilterChip(
                      avatar: Icon(Icons.lightbulb),
                      selected: _kitchen,
                      selectedColor: Colors.blue,
                      onSelected: (value) {
                        setState(() {
                          _kitchen = value;
                        });
                      },
                      label: Text('Kitchen'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    FilterChip(
                      avatar: Icon(Icons.lightbulb),
                      selected: _bedroom,
                      selectedColor: Colors.blue,
                      onSelected: (value) {
                        setState(() {
                          _bedroom = value;
                        });
                      },
                      label: Text('Bedroom'),
                    ),
                  ],
                ),
              ),

              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 50),
                child: Card(
                  color: Theme.of(context).buttonColor,
                  child: Text(
                    'Heating and Cooling',
                    style: Get.textTheme.headline5,
                  ),
                ),
              ),
              ListTile(
                leading: Text('Set Temperature'),
                title: Text(_temp.toString() + 'c'),
                trailing: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 150),
                  child: Slider(
                      max: 25.0,
                      min: 10.0,
                      value: _temp,
                      onChanged: (value) {
                        setState(() {
                          _temp = value.ceilToDouble();
                        });
                      }),
                ),
              ),
              ExpansionTile(
                title: Text('Heating Zones'),
                children: [
                  ListTile(
                    title: Text('Living Room'),
                    trailing: SizedBox(
                      width: 150,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_upward,
                              color: Colors.red,
                            ),
                            onPressed: () => _tempUp(),
                          ),
                          Text(_temp.toString()),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_downward,
                              color: Colors.blue,
                            ),
                            onPressed: () => _tempDown(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('Kitchen'),
                    trailing: SizedBox(
                      width: 150,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_upward,
                              color: Colors.red,
                            ),
                            onPressed: () => _tempUp(),
                          ),
                          Text(_temp.toString()),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_downward,
                              color: Colors.blue,
                            ),
                            onPressed: () => _tempDown(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('Bedroom'),
                    trailing: SizedBox(
                      width: 150,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_upward,
                              color: Colors.black,
                            ),
                            onPressed: () => _tempUp(),
                          ),
                          Text(_temp.toString()),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_downward,
                              color: Colors.black,
                            ),
                            onPressed: () => _tempDown(),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Expanded(
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Text(
                  //         'Temperature Setting',
                  //       ),
                  //       IconButton(
                  //         icon: Icon(
                  //           Icons.arrow_upward,
                  //           color: Colors.black,
                  //         ),
                  //         onPressed: () => _tempUp(),
                  //       ),
                  //       Text(_temp.toString()),
                  //       IconButton(
                  //         icon: Icon(
                  //           Icons.arrow_downward,
                  //           color: Colors.black,
                  //         ),
                  //         onPressed: () => _tempDown(),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),

              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 50),
                child: Card(
                  color: Theme.of(context).buttonColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Scenes',
                      style: Get.textTheme.headline5,
                    ),
                  ),
                ),
              ),

              Center(
                child: Wrap(
                  children: [
                    FilterChip(
                      avatar: Icon(Icons.movie),
                      selected: _sceneMovie,
                      selectedColor: Colors.blue,
                      onSelected: (value) {
                        setState(() {
                          _sceneMovie = value;
                        });
                      },
                      label: Text('Movie'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    FilterChip(
                      avatar: Icon(Icons.timelapse),
                      selected: _sceneRelax,
                      selectedColor: Colors.blue,
                      onSelected: (value) {
                        setState(() {
                          _sceneRelax = value;
                        });
                      },
                      label: Text('Relax'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    FilterChip(
                      avatar: Icon(Icons.lightbulb),
                      selected: _sceneBreakfast,
                      selectedColor: Colors.blue,
                      onSelected: (value) {
                        setState(() {
                          _sceneBreakfast = value;
                        });
                      },
                      label: Text('Breakfast'),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _sceneMovie = !_sceneMovie;
                      });
                    },
                    child: Card(
                      elevation: _sceneMovie ? 4 : 1,
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            'https://www.dasym.com/wp-content/uploads/2017/07/Cinema-Image-by-Alexandre-Chassignon-on-Flickr.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _sceneRelax = !_sceneRelax;
                      });
                    },
                    child: Card(
                      elevation: _sceneRelax ? 4 : 1,
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            'https://st.depositphotos.com/1757635/2268/i/600/depositphotos_22687061-stock-photo-yoga-exercise-abstract.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _sceneBreakfast = !_sceneBreakfast;
                      });
                    },
                    child: Card(
                      elevation: _sceneBreakfast ? 4 : 1,
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/delicious-breakfast-on-a-light-table-royalty-free-image-863444442-1543345985.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
              // IconButton(
              //   icon: Icon(Icons.power_off,
              //       color: _lightOn ? Colors.blue : Colors.white),
              //   onPressed: () => _toggleLight(),
              // ),
              // Text(
              //   '$_counter',
              //   style: Theme.of(context).textTheme.headline4,
              // ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
