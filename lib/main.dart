import 'package:flutter/material.dart';
import 'package:game/src/app.dart';
import 'package:flutter/services.dart';

void main() async {
  // Con esto me aseguro que flutter este inicializado
  WidgetsFlutterBinding.ensureInitialized();
  // Es para mantener que siempre se vea horizontal
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}
