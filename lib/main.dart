import 'package:almacen_android/drawer.dart';
import 'package:almacen_android/packages/almacen/data/api_calls.dart';
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
/**
 * La primera pantalla que nos devuelve la aplicación es un login que pide usuario y contraseña.
 * En caso de validarse, se llega a la pantalla principal en la que nos deja elegir entre almacen, tecnica y llaves.
 */
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

  Widget _buildLoginBtn() {
    return Container(

      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => signIn(context, emailText, passwordText),
        style: ElevatedButton.styleFrom(padding: EdgeInsets.all(15.0),primary:Colors.white,elevation: 5,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
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
  String emailText = "root";

  String passwordText = "almacen.C12";
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
            cursorColor: Colors.white,
            
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
                            fontSize: 60
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
                                  color: Color.fromRGBO(255, 255, 255, 0.7),
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
                                    SizedBox(height: 20.0,),
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
                                    image: ExactAssetImage('assets/logos/canal12.png')
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

  /**
   * Método que valida tanto usuario como contraseña con la api.
   */
  signIn(BuildContext context, String emailText, String passwordText) async{

    if(emailText!=''&&passwordText!=''){
      Servidor _servidor = Servidor();
      bool logeado;
      logeado= await _servidor.login(emailText,passwordText);
      if(logeado) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> MainDrawer(true)),);
      }else EasyLoading.showError("Usuario o contraseña incorrectos.");
    }else{
      EasyLoading.showError("Por favor ingrese un usuario y contraseña.");
    }
  }
}