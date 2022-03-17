import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image/image.dart' as imagconverter;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as rutaprov;

/*
 * Clase encargada de construir una ventana con una imagen obtenida de una api publica, en funcion
 * del rol introducido en el constructor mostrara la imagen o la imagen y un boton para transformar
 * la imagen jpg en png. Hace uso de la api picsum que devuelve una imagen aleatoria cada vez
 */
class Bienvenida extends StatelessWidget{
  const Bienvenida({Key?key,required this.rol}): super(key:key);
  final String rol;
  
  @override
  Widget build(BuildContext context) {
    Widget bodyBienvenida; 
    // Si el rol es usuario
    if(rol=="usuario"){
      // Se asigna a bodyBienvenida un Widget Column con un Widget Image
      bodyBienvenida = Column(
        children: <Widget>[
          // Se obtiene la imagen y se muestra en un  widget Image
          Image.network('https://picsum.photos/200')
        ],
      );
      // Si el rol es administrador
    }else if(rol=="administrador"){
      // Se asigna a bodyBienvenida un Widget Column con un Widget Image y un widget ElevatedButton
      bodyBienvenida = Column(
        children:  <Widget>[
          // Se obtiene la imagen y se muestra en un  widget Image
          Image.network('https://picsum.photos/200'),
          // Boton que al pulsarlo ejecuta el método transformarImagen
          ElevatedButton(onPressed: transformarImagen, child: const Text("Transformar una imagen"))
        ],
      );
    }else {
      // Si se le pasa un rol no reconocido se asigna a bodyBienvenida un unido widget Text
      bodyBienvenida = const Text("Rol no reconocido");
      }
    return MaterialApp(
      // En el titulo se asigna el rol
      title: rol,
      home: Scaffold(
        // Se usa un widget AppBar para mostrar una barra superior dando la bienvenida al usuario o administrador
        appBar: AppBar(title: Text("Bienvenido "+rol)),
        // Se asigna al body del scaffold lo contenido en bodyBienvenida
        body: (
          bodyBienvenida
        ),        
      ),
    );
  }

  /*
   * Método encargado de transformar la imagen que se obtiene a través de http a otro formato 
   * no transforma la imagen mostrada, si no que obtiene una nueva y la transforma, esto lo he pensado
   * así para separar la transformación multimedia de las peticiones http aunque se haga uso de get en
   * este método también
   */
  transformarImagen() async{
    // Se crea una uri con el método estatico Uri.https
    var uri = Uri.https('picsum.photos', '/200'); // devuelve https://picsum.photos/200 como uri
    // Se realiza un get a la uri
    var response = await http.get(uri);
    // Se obtienen los bytes de la imagen del body y se decodifican en una imagen
    imagconverter.Image? imagdata =  imagconverter.decodeJpg(response.bodyBytes);
    // Se redimensiona la imagen
    imagconverter.Image? thumbnail = imagconverter.copyResize(imagdata!, width: 120); 
    // Si la plataforma es Android 
    if (Platform.isAndroid){      
      // Se declara la ruta a guardar el archivo
      const path = '/storage/self/primary/DCIM/imagenImportada.png';
      // Se guarda la imagen en la ruta como archivo png
      File(path).writeAsBytesSync(imagconverter.encodePng(thumbnail),flush:true);
    }
    
  
  }
  
}