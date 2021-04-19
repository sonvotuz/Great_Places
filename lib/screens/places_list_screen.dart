import 'package:flutter/material.dart';
import 'package:great_places/provider/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: Center(
                  child: const Text('Got no places yet, start adding some..'),
                ),
                builder: (context, greatPlaces, ch) =>
                    greatPlaces.items.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                  greatPlaces.items[index].image,
                                ),
                              ),
                              title: Text(greatPlaces.items[index].title),
                              subtitle: Text(
                                  greatPlaces.items[index].location.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    PlaceDetalScreen.routeName,
                                    arguments: greatPlaces.items[index].id);
                              },
                            ),
                          ),
              ),
      ),
    );
  }
}
