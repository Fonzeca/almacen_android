import 'package:almacen_android/drawer.dart';
import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/almacen/view/pantalla_almacen.dart';
import 'package:almacen_android/packages/tecnica/view/pantalla_tecnica.dart';
import 'package:almacen_android/packages/llaves/view/pantalla_llaves.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema Almacén',
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
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Canal 12'),
      builder: EasyLoading.init(),
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

class _MainMenuPageState extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Bienvenido'),
      ),
      body: SizedBox.expand(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                new TextButton(
                  child: Text("Almacén"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MainDrawer(
                          true,
                          0
                      ),));
                  },
                ),
                TextButton(
                  child:Text("Técnica"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MainDrawer(true,6),));
                  },
                )
              ],
            ),
            Row(
              children: [
                TextButton(
                  child: Text("Llaves"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MainDrawer(true,11),));
                  },
                ),
                TextButton(
                    child:Text("Salir")
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {

  final kHintTextStyle = TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 12
  );

  final kLabelStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontFamily: 'OpenSans',
      fontSize: 12
  );

  final kBoxDecorationStyle = BoxDecoration(
    color: Colors.deepOrange,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  String emailText = "";
  String passwordText = "";

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Usuario',
          style: kLabelStyle,
        ),
        SizedBox(height: 8.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onChanged: (text) => emailText = text,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Ingrese su usuario',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Contraseña',
          style: kLabelStyle,
        ),
        SizedBox(height: 8.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onChanged: (text) => passwordText = text,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Ingrese su contraseña',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => signIn(context, emailText, passwordText),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Iniciar Sesión',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: 25.0,
                      bottom: 60.0,
                      right: 30.0,
                      left: 30.0
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'CANAL 12',
                        style: TextStyle(
                            fontFamily: 'NickMayus',
                            fontSize: 80
                        ),
                      ),
                      Text(
                        'Sistema Almacén',
                        style: TextStyle(
                            fontFamily: 'NickMin',
                            fontSize: 28
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(60)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 0,
                                        blurRadius: 7,
                                        offset: Offset(0,0)
                                    )
                                  ]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20,top: 60, right: 20, bottom: 40),
                                child: Column(
                                  children: <Widget>[
                                    _buildEmailTF(),
                                    SizedBox(height: 10.0,),
                                    _buildPasswordTF(),
                                    _buildLoginBtn(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: ExactAssetImage('logos/Canal12.png')
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 0,
                                      blurRadius: 7,
                                      offset: Offset(0,-5)
                                  )
                                ]
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }

  signIn(BuildContext context, String emailText, String passwordText) async{

    if(emailText!=''&&passwordText!=''){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> _MainMenuPageState()),);
      Servidor _servidor = Servidor();
      _servidor.login(emailText,passwordText);
    }else{
      EasyLoading.showError("El usuario y la contraseña no deben ser nulos!");
    }



  }



}
