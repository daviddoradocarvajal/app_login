import 'package:flutter/material.dart';
import 'package:widget_login/miformulario.dart';
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
    // un evento onPressed para el botón del formulario
    return  MiFormulario(      
      onPressed: (() => validarButton(MiFormulario.email,MiFormulario.pass)),

    );
  }
  // Método que se va a ejecutar como evento que realiza una comprobación del correo y contraseña
  // introducidos en el formulario
  validarButton(String? email, String? pass){
    // Se realizan comprobaciónes de login (en este caso ficticias) y devuelve un cuadro de dialogo
    if (email == null || email.isEmpty) {
      return mostarMensaje('Error', 'Debe introducir un e-mail');         
    }
    if (pass==null || pass.isEmpty || pass!='aaa'){
      return mostarMensaje('Error', 'Contraseña incorrecta');
    }
    return mostarMensaje('', 'Login correcto');
  }
  // Método encargado de devolver un cuadro de diálogo
  mostarMensaje(String titulo, String mensaje){    
    return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titulo),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
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

}
