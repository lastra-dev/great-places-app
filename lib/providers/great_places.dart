import 'dart:io';
import 'package:flutter/foundation.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final item = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: PlaceLocation(
        latitude: 1,
        longitude: 1,
        address: 'a dummy location',
      ),
    );
    _items.add(item);
    notifyListeners();
  }
}
