import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:provider/provider.dart';

import 'screens/add_place_screen.dart';
import 'screens/place_detail_screen.dart';
import 'screens/places_list_screen.dart';

Future main() async {
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        title: 'Material App',
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
