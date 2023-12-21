import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String logs = "";
  bool isMapView = true;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Column(
      children: [
        GestureDetector(
          child: Text("Логи"),
          onTap: () {
            isMapView = false;
          },
        ),
        GestureDetector(
          child: Text("Карта"),
          onTap: () {
            isMapView = true;
          },
        ),
        if (isMapView)
          FlutterLocationPicker(
              initPosition: LatLong(23, 89),
              selectLocationButtonStyle: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              selectedLocationButtonTextstyle: const TextStyle(fontSize: 18),
              selectLocationButtonText: 'Set Current Location',
              selectLocationButtonLeadingIcon: const Icon(Icons.check),
              initZoom: 11,
              minZoomLevel: 5,
              maxZoomLevel: 16,
              trackMyPosition: true,
              onError: (e) => logs += e.toString(),
              onPicked: (pickedData) {
                logs += pickedData.latLong.latitude.toString();
                logs += pickedData.latLong.longitude.toString();
                logs += pickedData.address;
                logs += pickedData.addressData['country'];
              },
              onChanged: (pickedData) {
                logs += pickedData.latLong.latitude.toString();
                logs += pickedData.latLong.longitude.toString();
                logs += pickedData.address;
                logs += pickedData.addressData.toString();
              }),
        if (!isMapView)
          Text("логи: $logs")
      ],
    );
  }
}
