import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/destination_provider.dart';
import '../models/destination_model.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DestinationProvider>().fetchDestinations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DestinationProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'TravelBuddy',
          style: TextStyle(
            color: Color(0xFF173B57),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: RefreshIndicator(
        onRefresh: provider.refreshDestinations,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isWide = constraints.maxWidth >= 700;

            final destinations = provider.destinations.take(20).toList();

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    const Text(
                      'Jelajahi Dunia!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF173B57),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Temukan inspirasi destinasi wisata impianmu.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),

                    // Banner utama
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF173B57),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Petualangan Baru Menantimu',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Cari tempat baru, simpan favoritmu, '
                            'dan rencanakan perjalanan berikutnya.',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Rekomendasi Destinasi',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF173B57),
                      ),
                    ),

                    const SizedBox(height: 14),

                    if (provider.isLoading)
                      const Padding(
                        padding: EdgeInsets.all(30),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else if (provider.errorMessage != null)
                      _buildError(provider.errorMessage!)
                    else if (destinations.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(child: Text('Belum ada data destinasi.')),
                      )
                    else if (isWide)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: destinations.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 0,
                              childAspectRatio: 4.0,
                            ),
                        itemBuilder: (context, index) {
                          return DestinationCard(
                            destination: destinations[index],
                          );
                        },
                      )
                    else
                      ...destinations.map(
                        (destination) =>
                            DestinationCard(destination: destination),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Icon(Icons.wifi_off, size: 45, color: Colors.grey),
          const SizedBox(height: 10),
          const Text('Gagal memuat data destinasi.'),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              context.read<DestinationProvider>().fetchDestinations();
            },
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }
}

// Widget kartu destinasi
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
              builder: (context) => DetailScreen(destination: destination),
            ),
          );
        },
        leading: SizedBox(
          width: 75,
          child: destination.flagUrl.isNotEmpty
              ? Image.network(
                  destination.flagUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      const Icon(Icons.image_not_supported),
                )
              : const Icon(Icons.landscape),
        ),
        title: Text(
          destination.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${destination.region} • ${destination.capital}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
