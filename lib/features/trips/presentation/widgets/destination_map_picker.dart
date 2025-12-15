import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class DestinationMapPicker extends StatefulWidget {
  const DestinationMapPicker({super.key});

  @override
  State<DestinationMapPicker> createState() => _DestinationMapPickerState();
}

class _DestinationMapPickerState extends State<DestinationMapPicker> {
  late AppleMapController mapController;
  final LatLng _initialPosition =
      const LatLng(37.7749, -122.4194); // San Francisco Default
  String? _selectedAddress;
  bool _isLoadingAddress = false;

  void _onMapCreated(AppleMapController controller) {
    mapController = controller;
  }

  Future<void> _onCameraIdle() async {
    setState(() {
      _isLoadingAddress = true;
    });

    try {
      final bounds = await mapController.getVisibleRegion();
      final centerLat =
          (bounds.northeast.latitude + bounds.southwest.latitude) / 2;
      final centerLng =
          (bounds.northeast.longitude + bounds.southwest.longitude) / 2;

      List<Placemark> placemarks =
          await placemarkFromCoordinates(centerLat, centerLng);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        // Construct a readable address: City, Country
        final city = place.locality ??
            place.subAdministrativeArea ??
            place.administrativeArea;
        final country = place.country;

        if (city != null && country != null) {
          setState(() {
            _selectedAddress = '$city, $country';
          });
        }
      }
    } catch (e) {
      // Handle geocoding errors (e.g. over map limits or network)
      print('Geocoding error: $e');
    } finally {
      setState(() {
        _isLoadingAddress = false;
      });
    }
  }

  void _onConfirm() {
    if (_selectedAddress != null) {
      Navigator.of(context).pop(_selectedAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Destination'),
        actions: [
          TextButton(
            onPressed: _selectedAddress != null ? _onConfirm : null,
            child: const Text('Confirm',
                style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          AppleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 12,
            ),
            onCameraIdle: _onCameraIdle,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          // Center Marker
          const Icon(Icons.location_on, size: 48, color: Colors.red),

          // Address Display
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.place, color: Colors.blue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _isLoadingAddress
                        ? const Text('Locating...',
                            style: TextStyle(color: Colors.grey))
                        : Text(
                            _selectedAddress ?? 'Pan map to select location',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                  ),
                  if (_selectedAddress != null)
                    Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
