import 'package:flutter/material.dart';

import '../models/destination_model.dart';
import '../screens/detail_screen.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;

  const DestinationCard({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return DetailScreen(destination: destination);
              },
            ),
          );
        },
        leading: SizedBox(
          width: 75,
          child: destination.flagUrl.isNotEmpty
              ? Image.network(
                  destination.flagUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported);
                  },
                )
              : const Icon(Icons.landscape),
        ),
        title: Text(
          destination.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${destination.region} • ${destination.capital}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
