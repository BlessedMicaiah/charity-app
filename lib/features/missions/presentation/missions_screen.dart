import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/theme/app_colors.dart';

class MissionsScreen extends StatelessWidget {
  const MissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(20.0, 30.0), // Focus on 10/40 window
              initialZoom: 3.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.charity.digital_sanctuary',
              ),
              CircleLayer(
                circles: _generateHeatmapPoints(),
              ),
            ],
          ),
          _buildOverlay(context),
        ],
      ),
    );
  }

  List<CircleMarker> _generateHeatmapPoints() {
    // Simulated heatmap points concentrated in the 10/40 window
    // Colors represent "Heat" (intensity of evangelism or need)
    final points = <CircleMarker>[
      _createHeatPoint(31.0, 35.0, Colors.red), // Israel/Jordan
      _createHeatPoint(30.0, 31.0, Colors.orange), // Egypt
      _createHeatPoint(35.0, 44.0, Colors.red), // Iraq
      _createHeatPoint(24.0, 46.0, Colors.orange), // Saudi
      _createHeatPoint(28.0, 77.0, Colors.red), // India (North)
      _createHeatPoint(35.0, 105.0, Colors.yellow), // China
      _createHeatPoint(10.0, 10.0, Colors.orange), // Nigeria/West Africa
      _createHeatPoint(-1.0, 36.0, Colors.yellow), // Kenya
      _createHeatPoint(41.0, 29.0, Colors.red), // Turkey
      _createHeatPoint(33.0, 51.0, Colors.orange), // Iran
    ];
    return points;
  }

  CircleMarker _createHeatPoint(double lat, double lng, Color color) {
    return CircleMarker(
      point: LatLng(lat, lng),
      color: color.withOpacity(0.4),
      borderStrokeWidth: 0,
      useRadiusInMeter: false,
      radius: 20, // pixels
    );
  }

  Widget _buildOverlay(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
             BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Global Impact", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Icon(Icons.public, color: AppColors.primary),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat("Reached", "12k"),
                _buildStat("Praying", "5k"),
                _buildStat("Workers", "340"),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Commit to Pray"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}
