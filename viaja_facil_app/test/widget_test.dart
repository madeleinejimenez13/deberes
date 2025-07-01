import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:viaja_facil_app/main.dart';

void main() {
  testWidgets('Verifica que aparezca el título "Destinos Disponibles"', (WidgetTester tester) async {
    // Construye la app en el entorno de test
    await tester.pumpWidget(const ViajaFacilApp());

    // Busca el texto en pantalla
    expect(find.text('Destinos Disponibles'), findsOneWidget);
  });
}
