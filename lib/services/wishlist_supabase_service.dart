import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/wishlist_model.dart';

class WishlistSupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  // READ: Mengambil semua Wishlist
  Future<List<Wishlist>> getWishlists() async {
    final response = await _client
        .from('wishlists')
        .select()
        .order('created_at', ascending: false);

    return (response as List)
        .map((item) => Wishlist.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // CREATE: Menambahkan Wishlist
  Future<Wishlist> addWishlist({
    required String destinationId,
    required String destinationName,
    required String notes,
  }) async {
    final response = await _client
        .from('wishlists')
        .insert({
          'destination_id': destinationId,
          'destination_name': destinationName,
          'notes': notes,
        })
        .select()
        .single();

    return Wishlist.fromJson(response);
  }

  // UPDATE: Mengubah catatan Wishlist
  Future<Wishlist> updateWishlist({
    required String id,
    required String notes,
  }) async {
    final response = await _client
        .from('wishlists')
        .update({'notes': notes})
        .eq('id', id)
        .select()
        .single();

    return Wishlist.fromJson(response);
  }

  // DELETE: Menghapus Wishlist
  Future<void> deleteWishlist(String id) async {
    await _client.from('wishlists').delete().eq('id', id);
  }
}
