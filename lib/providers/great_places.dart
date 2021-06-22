import 'dart:io';

import 'package:flutter/foundation.dart';

import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addPlace(
    String pickedTitle,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getAdress(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
    );
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final item = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updatedLocation,
    );
    _items.add(item);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': item.id,
      'title': item.title,
      'image': pickedImage.path,
      'loc_lat': item.location.latitude,
      'loc_lng': item.location.longitude,
      'address': item.location.address,
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
                latitude: item['loc_lat'] as double,
                longitude: item['loc_lng'] as double,
                address: item['address'].toString(),
              )),
        )
        .toList();
    notifyListeners();
  }
}
