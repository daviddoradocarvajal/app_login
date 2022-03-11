import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';
import 'package:widget_login/bienvenida.dart';
import 'package:widget_login/miformulario.dart';
import 'package:widget_login/user.dart';
// Método main de la aplicación
void main() => runApp(const MyApp());

// Clase a lanzar por el método main, se encarga de la barra superior con el título
class MyApp extends StatelessWidget {
  // Constructor
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Aplicación Widget Formulario';
  // Método que construye un Widget MaterialApp
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      // Como apartado home de MaterialApp se indica un widget Scaffold que tiene las propiedades appBar y body
      home: Scaffold(
        // Se asigna a la propiedad appBar un widget AppBar con la propiedad title
        appBar: AppBar(title: const Text(_title)),
        // Se asigna a la propiedad body un widget MyStatefulWidget
        body: const MyStatefulWidget(),
      ),
    );
  }
}
// Widget MyStatefulWidget que hereda de StatefulWidget (Widget con estado)
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
  // Se crea como estado del Widget un Widget _MyStatefulWidgetState
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
// Widget _MyStatefulWidgetState que hereda de State tipado y que representa un estado
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  // Método que devuelve un Widget como estado al construir el Widget
  @override
  Widget build(BuildContext context) {
    // Devuelve un Widget MiFormulario que es un formulario personalizado, recibe como parámetro
    // dos eventos onPressed uno para el login y otro para el registro
    return  MiFormulario(      
      loginEvent: (() => {
        if(validateData(MiFormulario.email,MiFormulario.pass))
        {
          recuperarUsuario(MiFormulario.email.toString(), MiFormulario.pass.toString())
        }
      }),      
      registerEvent: (() => {
        if (validateData(MiFormulario.email, MiFormulario.pass)){
          registrarUsuario(MiFormulario.email.toString(),MiFormulario.pass.toString())
        }
      }),

    );
  }
  
  // Método que se va a ejecutar para comprobar los datos del formulario
  validateData(String? email, String? pass){
    // Patron de expresion regular de un email
    String patternEmail = r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    // Patron de expresion regular de una contraseña
    String patternPasswd = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    // Se asigna al objeto RegExp el patron para comprobar la expresion del email
    RegExp regex = RegExp(patternEmail);    
    // Se realizan comprobaciones de que el email no esta en blanco y sigue el patron especificado
    if (email == null || email.isEmpty || regex.hasMatch(email)==false ) {
      mostarMensaje('Error', 'Debe introducir un e-mail');
      return false;
    }
    // Se asigna al objeto RegExp el patron para comprobar la expresion de la contraseña
    regex = RegExp(patternPasswd);
    // Se realizan comprobaciones de que la constraseña no esta en blanco y sigue el patron especificado
    if (pass==null || pass.isEmpty ){
      mostarMensaje('Error', 'Contraseña vacia');
      return false;
    }
    if (regex.hasMatch(pass)==false || pass.length < 8){
      mostarMensaje('Error', 'Debe introducir una contraseña con 8 o mas carácteres, 1 minuscula, 1 mayuscula, 1 numero y uno de los siguientes carácteres ( ! @ # \$ & * ~)');
      return false;
    }    
    return true;
  }

  // Método encargado de devolver un cuadro de diálogo para comunicaciones con el usuario
  mostarMensaje(String titulo, String mensaje){    
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Obliga a pulsar el botón para cerrar el cuadro
      builder: (BuildContext context) {
        return AlertDialog(
          // El titulo del cuadro se asigna con el primer parámetro
          title: Text(titulo),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // El texto se asigna con el segundo parámetro
                Text(mensaje),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );    
  }

  /*
   * Método encargado de recuperar un usuario de la base de datos, en funcion de su rol navegara a otra
   * ventana
   */ 
  Future recuperarUsuario(String email, String pass) async {
    // Se crea un objeto usuario
    User user = const User("email", "pass", "rol");
    // Conexión con la base de datos
    var conn = await MySqlConnection.connect(ConnectionSettings(
      host: '10.0.2.2',
      port: 3307,
      db: 'usuarios',
      user: 'root',
    ));
    // Se obtiene el resultado de la consulta, la contraseña deber ser descifrada con el método aes_decrypt
    var result = await conn.query("SELECT email,aes_decrypt(pass,'contraseniaaes'),rol FROM usuario where email='"+email+"'");
    // Si hay mas de 1 coincidencia devuelve un null 
    if (result.length>=2) return null;
    // Si encuentra un usuario lo guarda en una variable
    if (result.isNotEmpty){
      for (var data in result){
      user = User(data[0].toString(), data[1].toString(), data[2].toString());
     }
     // Comprueba el rol del usuario y lanza una ventana nueva en función de su rol
     if (user.rol=="administrador"){
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
        return const Bienvenida(rol: "administrador");
        }
      ));
     }
     if (user.rol=="usuario"){
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
        return const Bienvenida(rol: "usuario");
        }
      ));
     }
     //Si no encuentra ningun usuario muestra un mensaje
    }else {
      mostarMensaje("Error", "Usuario no encontrado");
    }
    // Cierre de la conexión
    conn.close();    
  }
  // Método encargado de registrar un usuario en la base de datos
  Future registrarUsuario(String email, String pass) async {
    // Conexión con la base de datos
    var conn = await MySqlConnection.connect(ConnectionSettings(
      host: '10.0.2.2',
      port: 3307,
      db: 'usuarios',
      user: 'root',
    ));
    /*
     * Se lanza la consulta insert, se usa un then para esperar a su finalizacion antes de cerrar la conexion,
     * la contraseña se cifra antes de ser enviada 
     */ 
    await conn.query("Insert into usuario (email,pass,rol) values ('"+email+"',aes_encrypt('"+pass+"','contraseniaaes'),'usuario')").then((value) => null);
    // Cierre de la conexión
    conn.close();
  }
  

}
