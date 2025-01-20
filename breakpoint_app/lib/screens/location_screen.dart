import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';
import '../model/LocationModel.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Verificar Localização'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (locationProvider.selectedLocation != null)
              Text(
                'Destino: ${locationProvider.selectedLocation!.latitude}, ${locationProvider.selectedLocation!.longitude}',
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                locationProvider.setSelectedLocation(
                  LocationModel(latitude: 37.4219999, longitude: -122.0840575),
                );
              },
              child: Text('Definir Localização de Teste'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await locationProvider.checkProximity();
                if (locationProvider.isWithinRadius) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Você está dentro do raio de 100 metros!'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Fora do raio de 100 metros.'),
                    ),
                  );
                }
              },
              child: Text('Verificar Proximidade'),
            ),
          ],
        ),
      ),
    );
  }
}
