// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:widget_login/miformulario.dart';

void main() {
  
  testWidgets('Pruebas sobre componente', (WidgetTester tester) async {    
    MiFormulario formulario = MiFormulario(
      loginEvent: (() => (() {})),
      registerEvent: (() => (() {}))
      );
      
    // Construye la aplicacion para el marco de pruebas
    await tester.pumpWidget(MaterialApp(
       home: Material(
         child: Directionality(
           textDirection: TextDirection.ltr,
           child: Center(
             child:formulario,
           ),
         ),
       ),
     ));
     expect(find.byType(MiFormulario), findsOneWidget);
     expect(find.byType(Form), findsOneWidget);
     expect(find.text("Enviar"), findsWidgets);
  });
}
