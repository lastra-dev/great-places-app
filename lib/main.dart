import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:provider/provider.dart';

import 'screens/places_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Material App',
        home: PlacesListScreen(),
      ),
    );
  }
}
