import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image/image.dart' as importado;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as rutaprov;


class Bienvenida extends StatelessWidget{
  const Bienvenida({Key?key,required this.user}): super(key:key);
  final String user;
  
  @override
  Widget build(BuildContext context) {
    Widget bodyBienvenida;   
    if(user=="usuario"){
      bodyBienvenida = Column(
        children: <Widget>[
          Image.network('https://picsum.photos/200')
        ],
      );
    }else if(user=="administrador"){
      bodyBienvenida = Column(
        children:  <Widget>[
          Image.network('https://picsum.photos/200'),
          ElevatedButton(onPressed: transformarImagen, child: const Text("Transformar imagen"))
        ],
      );
    }else {
      bodyBienvenida = const Text("Rol no reconocido");
      }
    return MaterialApp(
      title: user,
      home: Scaffold(
        appBar: AppBar(title: Text("Bienvenido "+user)),
        body: (
          bodyBienvenida
        ),
        
      ),
    );
  }

  /*
   * Método encargado de transformar la imagen que se obtiene a través de http a otro formato 
   */
  transformarImagen() async{
    var uri = Uri.https('picsum.photos', '/200');
    var response = await http.get(uri);
    importado.Image? imagdata =  importado.decodeJpg(response.bodyBytes);
    importado.Image? thumbnail = importado.copyResize(imagdata!, width: 120);  
    final dir = await rutaprov.getExternalStorageDirectory();
    final path = '${dir!.path}/imagenImportada.png';
    File(path).writeAsBytesSync(importado.encodePng(thumbnail),flush:true);
  
  }
  
}