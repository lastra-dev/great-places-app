import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import 'add_place_screen.dart';
import 'place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    builder: (ctx, places, ch) => places.items.isEmpty
                        ? const Center(
                            child: Text(
                              'You have not added any places yet, start adding some!',
                            ),
                          )
                        : ListView.builder(
                            itemCount: places.items.length,
                            itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                  places.items[i].image,
                                ),
                              ),
                              title: Text(
                                places.items[i].title,
                              ),
                              subtitle: Text(
                                places.items[i].location.address,
                              ),
                              onTap: () => Navigator.of(context).pushNamed(
                                PlaceDetailScreen.routeName,
                                arguments: places.items[i].id,
                              ),
                            ),
                          ),
                  ),
      ),
    );
  }
}
