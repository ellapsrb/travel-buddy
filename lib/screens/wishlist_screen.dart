import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/wishlist_provider.dart';
import '../models/wishlist_model.dart';
import 'edit_wishlist_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WishlistProvider>().fetchWishlists();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WishlistProvider>();
    final wishlists = provider.wishlists;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Wishlist Saya',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF173B57),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: provider.isLoading ? null : provider.fetchWishlists,
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat ulang',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: provider.fetchWishlists,
        child: provider.isLoading && wishlists.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : provider.errorMessage != null && wishlists.isEmpty
            ? ListView(
                children: [
                  const SizedBox(height: 120),
                  const Icon(Icons.cloud_off, size: 60, color: Colors.grey),
                  const SizedBox(height: 12),
                  const Center(child: Text('Gagal memuat Wishlist')),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      provider.errorMessage!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: provider.fetchWishlists,
                      child: const Text('Coba Lagi'),
                    ),
                  ),
                ],
              )
            : wishlists.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: wishlists.length,
                itemBuilder: (context, index) {
                  return _buildWishlistCard(context, wishlists[index]);
                },
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      children: const [
        SizedBox(height: 140),
        Icon(Icons.favorite_border, size: 75, color: Colors.grey),
        SizedBox(height: 16),
        Center(
          child: Text(
            'Wishlist Masih Kosong',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF173B57),
            ),
          ),
        ),
        SizedBox(height: 8),
        Center(
          child: Text(
            'Simpan destinasi yang ingin kamu kunjungi.',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildWishlistCard(BuildContext context, Wishlist wishlist) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFE5EDF3),
          child: Icon(Icons.location_on, color: Color(0xFF173B57)),
        ),
        title: Text(
          wishlist.destinationName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF173B57),
          ),
        ),
        subtitle: Text(
          wishlist.notes.isEmpty ? 'Tidak ada catatan' : wishlist.notes,
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditWishlistScreen(wishlist: wishlist),
                ),
              );
            } else if (value == 'delete') {
              _showDeleteDialog(context, wishlist);
            }
          },
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'edit', child: Text('Edit Wishlist')),
            PopupMenuItem(value: 'delete', child: Text('Hapus Wishlist')),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Wishlist wishlist) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Wishlist?'),
          content: Text('Yakin ingin menghapus ${wishlist.destinationName}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(dialogContext);

                try {
                  await context.read<WishlistProvider>().deleteWishlist(
                    wishlist.id,
                  );

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Wishlist berhasil dihapus')),
                  );
                } catch (e) {
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal menghapus Wishlist: $e')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
