// ignore_for_file: use_build_context_synchronously
import 'package:eatopia_refactored/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/maps_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  void Function(void Function())? mapStateSetter;
  GoogleMapController? mapController;
  Marker _marker = const Marker(
    markerId: MarkerId('Current Location'),
  );

  @override
  void initState() {
    super.initState();
  }

  void _onCameraMove(CameraPosition position) {
    _marker = _marker.copyWith(positionParam: position.target);
    mapStateSetter!(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map Screen'),
        ),
        body: SizedBox(
            child: FutureBuilder(
          future: context.read<MapsServices>().getCurrentLocation(),
          builder: (context, value) {
            if (value.connectionState == ConnectionState.waiting) {
              return const CustomShimmer();
            }
            _marker = _marker.copyWith(
              positionParam: value.data!,
            );
            return Stack(
              children: [
                StatefulBuilder(
                  builder: (context, mapState) {
                    mapStateSetter = mapState;

                    return GoogleMap(
                        onCameraMove: _onCameraMove,
                        onMapCreated: (controller) {
                          mapController = controller;
                        },
                        initialCameraPosition:
                            CameraPosition(target: value.data!, zoom: 16.0),
                        markers: {_marker});
                  },
                ),
                Positioned(
                  bottom: 15,
                  left: MediaQuery.sizeOf(context).width / 2 - 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 40),
                    ),
                    onPressed: () {},
                    child: const Text('Select Location'),
                  ),
                ),
                Positioned(
                    bottom: 50,
                    left: 10,
                    child: FloatingActionButton(
                        child: const Icon(Icons.location_pin),
                        onPressed: () async {
                          LatLng currentLocation = await context
                              .read<MapsServices>()
                              .getCurrentLocation();
                          mapController!.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: currentLocation, zoom: 16.0)));
                        })),
              ],
            );
          },
        )));
  }
}
