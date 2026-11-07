import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/destination_model.dart';
import '../providers/wishlist_provider.dart';
import 'add_wishlist_screen.dart';

class DetailScreen extends StatelessWidget {
  final Destination destination;

  const DetailScreen({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = context.watch<WishlistProvider>();
    final isSaved = wishlistProvider.isSaved(destination.id);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Detail Destinasi',
          style: TextStyle(
            color: Color(0xFF173B57),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF173B57)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar bendera negara
            Container(
              width: double.infinity,
              height: 210,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              clipBehavior: Clip.antiAlias,
              child: destination.flagUrl.isNotEmpty
                  ? Image.network(
                      destination.flagUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) =>
                          const Icon(Icons.flag, size: 70, color: Colors.grey),
                    )
                  : const Icon(Icons.flag, size: 70, color: Colors.grey),
            ),

            const SizedBox(height: 24),

            // Nama negara
            Text(
              destination.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF173B57),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              destination.region,
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),

            const SizedBox(height: 24),

            const Text(
              'Informasi Negara',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF173B57),
              ),
            ),

            const SizedBox(height: 14),

            _buildInfoCard(
              icon: Icons.location_city,
              title: 'Ibu Kota',
              value: destination.capital,
            ),

            _buildInfoCard(
              icon: Icons.public,
              title: 'Wilayah',
              value: destination.region,
            ),

            _buildInfoCard(
              icon: Icons.people,
              title: 'Populasi',
              value: destination.population.toString(),
            ),

            _buildInfoCard(
              icon: Icons.flag,
              title: 'Kode Negara',
              value: destination.id,
            ),

            const SizedBox(height: 24),

            // Tombol tambah Wishlist
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isSaved
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddWishlistScreen(destination: destination),
                          ),
                        );
                      },
                icon: Icon(isSaved ? Icons.favorite : Icons.favorite_border),
                label: Text(isSaved ? 'Sudah Disimpan' : 'Simpan ke Wishlist'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF173B57),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade400,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Informasi Google Maps
            if (destination.mapsUrl.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Google Maps',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      destination.mapsUrl,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget informasi negara
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF173B57)),
        title: Text(
          title,
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF173B57),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
