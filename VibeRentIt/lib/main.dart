// import 'package:VibeRentIt/controllers/localDB/localData.dart';
// import 'package:VibeRentIt/views/welcomeScreen.dart';
import 'package:VibeRentIt/views/widgetDecider.dart';
import 'package:flutter/material.dart';
// import './views/signIn.dart';
import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:shared_preferences/shared_preferences.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VibeRentIt',
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
        primarySwatch: Colors.orange,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
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

class _MyHomePageState extends State<MyHomePage>{
  // bool isSignedin = await getIsSignedin();

  // Future<bool>getIs()async{
  //  bool toReturn=await getIsSignedin();
  //  return toReturn;
  // }
  @override
 Widget build(BuildContext context)  {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    // bool isSignedin;
    // var toret =SharedPreferences.getInstance().then((value){return value.getBool("isSignedin")??false;});
   
    // return toret?WelcomeScreen():SignIn();
// Widget wg;
// // fw().then((value) => wg=value);
// while (wg==null) {
//   fw().then((value) => wg=value);
// }
return WidgetDecider();


  }
}

// Future <Widget> fw()async{
//  bool signedin= await getIsSignedin();
//  return signedin?WelcomeScreen():SignIn();
// }




