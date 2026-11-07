import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/destination_model.dart';
import '../providers/destination_provider.dart';
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
    final destinations = provider.destinations.take(20).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'TravelBuddy',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF173B57),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              context.read<DestinationProvider>().refreshDestinations();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 700;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  'Temukan destinasi menarik untuk perjalananmu.',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
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
                const SizedBox(height: 16),

                if (provider.isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (provider.errorMessage != null)
                  Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 45,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          provider.errorMessage!,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<DestinationProvider>()
                                .fetchDestinations();
                          },
                          child: const Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  )
                else if (destinations.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text('Belum ada destinasi.'),
                    ),
                  )
                else if (isWide)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: destinations.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 8,
                          childAspectRatio: 3.5,
                        ),
                    itemBuilder: (context, index) {
                      return DestinationCard(destination: destinations[index]);
                    },
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: destinations.length,
                    itemBuilder: (context, index) {
                      return DestinationCard(destination: destinations[index]);
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

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
