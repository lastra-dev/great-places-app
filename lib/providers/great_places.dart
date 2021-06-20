import 'dart:io';

import 'package:flutter/foundation.dart';

import '../helpers/db_helper.dart';
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

    DBHelper.insert('user_places', {
      'id': item.id,
      'title': item.title,
      'image': pickedImage.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final placesData = await DBHelper.getData('user_places');
    _items = placesData
        .map(
          (item) => Place(
            id: item['id'].toString(),
            title: item['title'].toString(),
            image: File(item['image'].toString()),
            location: PlaceLocation(
              address: '',
              longitude: 0,
              latitude: 0,
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
