# widget_login

Proyecto que busca crear una pantalla de usuario en contexto de una aplicación, la pantalla en concreto
es una ventana de log-in que contiene 2 cajas de texto una con el usuario y la otra con la contraseña.
Este componente recibe como parámetro un método para ejecutar al pulsar el botón "Enviar".

Ejemplo de uso:

    MiFormulario(
      loginEvent: //Hace algo
      ,
      registerEvent: //Hace algo
    );

Como importar:

Añadir al pubspec.yaml las siguientes lineas en dependencies:

widget_login:
    git: https://github.com/daviddoradocarvajal/app_login
    version: 1.0.2


Aplicación principal:

Muestra un formulario y la pulsar sobre "Registrar" registra a un usuario con los datos introducidos en la base de datos con el rol usuario encriptando la clave con cifrado aes. Al pulsar sobre "Loguear" comprueba los datos contra la tabla usuarios de la base de datos, esta tabla tiene un id autoincremental, un campo email varchar, un campo pass BLOB para guardar la contraseña cifrada y un campo rol varchar también donde guardar el rol que puede ser "usuario" o "administrador". Si el usuario introducido tiene el rol "usuario" Se le mostrará una imagen. Si el usuario introducido tiene el rol "administrador" ademas se le dará la opción de descargar una imagen aleatoria diferente a la mostrada y tras cambiarle el formato a .png y reducirla de tamaño la almacenará en la carpeta DCIM del teléfono