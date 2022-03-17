import 'package:flutter/material.dart';

/*
 * Widget personalizado que se representa un componente visual personalizado,
 * este componente es un formulario de login a una aplicación
 * En flutter todo se considera Widget (Al igual que Java con Object)
 */
class MiFormulario extends StatelessWidget{
  // Constructor de la clase
  MiFormulario({Key? key,required this.loginEvent,required this.registerEvent}) : super(key: key);
  // Variable global que tiene un mapa clave-valor de los campos del formulario
  final _formKey = GlobalKey<FormState>();
  // Variables para los eventos de los botones
  final GestureTapCallback loginEvent;
  final GestureTapCallback registerEvent;
  // Cadenas donde guardar los valores de los campos de texto
  static String? email;
  static String? pass;

  /*
   * En flutter todo comienza con el método build el cual recibe el contexto, 
   * esto permite que se pueda adaptar a la plataforma donde se esté ejecutando la aplicación
   * @param context Contexto de la construccion del Widget
   * @return Devuelve un Widget Form con el formulario
   */
   @override
   Widget build(BuildContext context) {
     /*
      * Se devuelve un Widget Form con las propiedades key y child
      * key almacena el mapa clave-valor y la propiedad child dentro de los widget es
      * la encargada de ir formando la estructura introduciendo widgets dentro de widgets
      * En este caso se usa un widget Column que tiene propiedades de alineación la
      * cual yo he decidido que todos los hijos se centren en el eje x y otra propiedad
      * llamada children que recibe un array de widget lo que permite encadenar varios widgets consecutivos
      */
    return Form(
     key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // 2 Widget de tipo campo de texto
          TextFormField(
            onChanged: ((newValue) => email = newValue),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'enter user email',
            ),
            
          ),
          // Este campo de texto oculta el texto insertado para la contraseña con la propiedad obscureText
          TextFormField(
            onChanged: ((newValue) => pass = newValue),
            obscureText: true,
            decoration: const InputDecoration(              
              border: OutlineInputBorder(),
              hintText: 'Enter your password',
            ),
            
          ),
          
         
            // Widget boton con el evento onPressed encargado del login
           ElevatedButton(              
              onPressed: loginEvent,
              child: const Text('Loguear')
            ),
          
          // Widget boton con el evento onPressed encargado del registro de un usuario
          ElevatedButton(
            onPressed: registerEvent, 
            child: const Text("Registrar")
          ),
        ],
      ),
    );
  }
}