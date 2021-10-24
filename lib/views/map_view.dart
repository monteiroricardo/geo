import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geo/controllers/goelocator_controller.dart';
import 'package:geo/controllers/maps_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      Provider.of<MapsController>(context, listen: false).setUserLocation(
          await Provider.of<GoelocatorController>(context, listen: false)
              .getCurrentUserLocation());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mapController = Provider.of<MapsController>(context);
    final geolocatorController = Provider.of<GoelocatorController>(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.centerLeft,
        children: [
          GoogleMap(
            compassEnabled: false,
            initialCameraPosition: mapController.initialCamPosition,
            mapType: mapController.currentMapType,
            onCameraMove: (CameraPosition camPosition) {
              mapController.realtiveCamPosition = camPosition;
            },
            onMapCreated: (GoogleMapController controller) {
              mapController.googleMapsController.complete(controller);
            },
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * .5,
            padding: const EdgeInsets.symmetric(vertical: 15),
            width: 60,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(5))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => mapController.setMapType(MapType.hybrid),
                  icon: Icon(
                    FontAwesomeIcons.satelliteDish,
                    color: mapController.currentMapType == MapType.hybrid
                        ? Colors.white
                        : Colors.white38,
                  ),
                ),
                IconButton(
                  onPressed: () => mapController.setMapType(MapType.terrain),
                  icon: Icon(
                    FontAwesomeIcons.mountain,
                    color: mapController.currentMapType == MapType.terrain
                        ? Colors.white
                        : Colors.white38,
                  ),
                ),
                IconButton(
                  onPressed: () => mapController.setMapType(MapType.normal),
                  icon: Icon(
                    FontAwesomeIcons.road,
                    color: mapController.currentMapType == MapType.normal
                        ? Colors.white
                        : Colors.white38,
                  ),
                ),
                IconButton(
                  onPressed: () => mapController.setTilt(),
                  icon: const Icon(
                    FontAwesomeIcons.camera,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    mapController.setUserLocation(
                        await geolocatorController.getCurrentUserLocation());
                  },
                  icon: Image.asset(
                    'assets/images/map_icon.png',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
