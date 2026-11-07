import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/destination_model.dart';
import '../providers/wishlist_provider.dart';

class AddWishlistScreen extends StatefulWidget {
  final Destination destination;

  const AddWishlistScreen({super.key, required this.destination});

  @override
  State<AddWishlistScreen> createState() => _AddWishlistScreenState();
}

class _AddWishlistScreenState extends State<AddWishlistScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveWishlist() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final provider = context.read<WishlistProvider>();

    if (provider.isSaved(widget.destination.id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Destinasi sudah ada di Wishlist.')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      await provider.addWishlist(
        destinationId: widget.destination.id,
        destinationName: widget.destination.name,
        notes: _notesController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wishlist berhasil ditambahkan!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan wishlist: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final destination = widget.destination;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Tambah Wishlist',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF173B57),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Destinasi Pilihan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF173B57),
                ),
              ),
              const SizedBox(height: 14),
              Card(
                color: Colors.white,
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFE5EDF3),
                    child: Icon(Icons.public, color: Color(0xFF173B57)),
                  ),
                  title: Text(
                    destination.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(destination.region),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Catatan Perjalanan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF173B57),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _notesController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Contoh: Ingin berlibur bersama keluarga',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Catatan perjalanan wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isSaving ? null : _saveWishlist,
                  icon: _isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.favorite),
                  label: Text(_isSaving ? 'Menyimpan...' : 'Simpan Wishlist'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF173B57),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
