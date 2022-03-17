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