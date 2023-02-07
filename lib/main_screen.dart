import 'package:assignement_1/model_class.dart';
import 'package:assignement_1/request_class.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart' as map;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late Future<Address> address;
  String add = '';
  bool showButton = false;

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      var snackBar = const SnackBar(content: Text('Turn on your Location.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Future.error('Location services are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Distance App"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0,right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(onPressed: (){
              RequestClass().fetchData().then((value) {
                setState(() {});
                add = '${value.address},${value.cityName},${value.stateName},${value.country}';
                showButton = true;
              });
              setState(() {});
            }, child: const Text("Get Location from API",style: TextStyle(
              fontSize: 18
            ))),
            Center(
              child: Text(add,style: const TextStyle(
                  fontSize: 18
              )),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: showButton,
        child: FloatingActionButton.extended(
          onPressed: () async {
            Position position = await getCurrentLocation();
            List<Location> locations = await locationFromAddress(add);
            map.MapLauncher.showDirections(mapType: map.MapType.google,
                destination: map.Coords(position.latitude, position.longitude),
            origin: map.Coords(locations.first.latitude, locations.first.longitude));
          },
          label: const Text("Get Distance from Current Location"),
          icon: const Icon(Icons.location_history),
        ),
      ),
    );
  }
}
