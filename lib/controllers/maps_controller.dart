import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsController extends ChangeNotifier {
  final Completer<GoogleMapController> googleMapsController = Completer();

  bool dynamicTilt = false;

  CameraPosition initialCamPosition = const CameraPosition(
    target: LatLng(
      -23.565314307293164,
      -46.65160146062957,
    ),
    zoom: 14,
  );

  CameraPosition realtiveCamPosition = const CameraPosition(
    target: LatLng(
      -23.565314307293164,
      -46.65160146062957,
    ),
    zoom: 14,
  );

  MapType currentMapType = MapType.normal;

  void setMapType(MapType type) {
    currentMapType = type;
    notifyListeners();
  }

  void setRelativePositon(CameraPosition latLng) {
    realtiveCamPosition = latLng;
    notifyListeners();
  }

  void setTilt() async {
    dynamicTilt = !dynamicTilt;
    GoogleMapController controller = await googleMapsController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: realtiveCamPosition.zoom,
          tilt: dynamicTilt ? 45 : 0,
          target: LatLng(
            realtiveCamPosition.target.latitude,
            realtiveCamPosition.target.longitude,
          ),
        ),
      ),
    );
  }

  void setUserLocation(LatLng latLng) async {
    GoogleMapController controller = await googleMapsController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: realtiveCamPosition.zoom,
          tilt: dynamicTilt ? 45 : 0,
          target: LatLng(
            latLng.latitude,
            latLng.longitude,
          ),
        ),
      ),
    );
  }
}
