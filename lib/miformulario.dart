import 'package:flutter/material.dart';

/*
 * Widget personalizado que se representa un componente visual personalizado,
 * este componente es un formulario de login a una aplicación
 * En flutter todo se considera Widget (Al igual que Java con Object)
 */
class MiFormulario extends StatelessWidget{
  MiFormulario({Key? key,required this.onPressed,required this.onPressed2}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final GestureTapCallback onPressed;
  final GestureTapCallback onPressed2;
  static String? email;
  static String? pass;

  
   @override
   Widget build(BuildContext context) {
    return Form(
     key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            onChanged: ((newValue) => email = newValue),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'enter user email',
            ),
            
          ),
          TextFormField(
            onChanged: ((newValue) => pass = newValue),
            obscureText: true,
            decoration: const InputDecoration(              
              border: OutlineInputBorder(),
              hintText: 'Enter your password',
            ),
            
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(              
              onPressed: onPressed,
              child: const Text('Loguear'),
            ),
          ),
          // Widget boton con el método onPressed2 Todo Cambiar nombre
          ElevatedButton(onPressed: onPressed2, 
          child: const Text("Registrar")
          ),
        ],
      ),
    );
  }
  }