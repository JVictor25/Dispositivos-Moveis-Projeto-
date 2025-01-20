import 'package:flutter/material.dart';
import '../model/LocationModel.dart';

class LocationDisplay extends StatelessWidget {
  final LocationModel? location;

  const LocationDisplay({Key? key, this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (location != null)
          Text(
            'Local: ${location!.latitude}, ${location!.longitude}',
            style: TextStyle(fontSize: 18),
          )
        else
          Text('Nenhuma localização definida.'),
      ],
    );
  }
}
