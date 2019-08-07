import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart'as vector;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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

  ArCoreController arCoreController;


  _onArCoreViewCreated(ArCoreController _arCoreController){
    arCoreController = _arCoreController;
    _addSphere(_arCoreController);
    _addCube(_arCoreController);
    _addCyclinder(_arCoreController);
  }

  _addSphere(ArCoreController _arCoreController){
    final material = ArCoreMaterial(color: Colors.deepPurple);
    final sphere = ArCoreSphere(materials: [material],radius: 0.2);
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(
          0, 0, -1
      ),
    );
    
    _arCoreController.addArCoreNode(node);
  }

  _addCyclinder(ArCoreController _arCoreController){
    final material = ArCoreMaterial(color: Colors.orange,reflectance: 1);
    final cylinder = ArCoreCylinder(materials: [material],radius: 0.4,height: 0.3);
    final node = ArCoreNode(
      shape: cylinder,
      position: vector.Vector3(
          0, -0.5, -3.1
      ),
    );

    _arCoreController.addArCoreNode(node);
  }


  _addCube(ArCoreController _arCoreController){
    final material = ArCoreMaterial(color: Colors.pinkAccent,metallic: 1);
    final cube = ArCoreCube(materials: [material],size:vector.Vector3(1, 1, 1) );
    final node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(
          -0.5, -0.5, -4.1
      ),
    );

    _arCoreController.addArCoreNode(node);
  }


  @override
  void dispose(){
    arCoreController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ArCoreView(onArCoreViewCreated: _onArCoreViewCreated,
      ),
    );
  }
}
