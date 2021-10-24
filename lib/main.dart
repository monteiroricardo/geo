import 'package:flutter/material.dart';
import 'package:geo/controllers/goelocator_controller.dart';
import 'package:geo/controllers/maps_controller.dart';
import 'package:geo/views/map_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GoelocatorController(),
        ),
        ChangeNotifierProvider(
          create: (_) => MapsController(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MapView(),
      ),
    ),
  );
}
