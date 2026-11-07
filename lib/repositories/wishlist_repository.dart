import '../models/wishlist_model.dart';
import '../services/wishlist_supabase_service.dart';

class WishlistRepository {
  final WishlistSupabaseService service;

  WishlistRepository({required this.service});

  Future<List<Wishlist>> getWishlists() {
    return service.getWishlists();
  }

  Future<Wishlist> addWishlist({
    required String destinationId,
    required String destinationName,
    required String notes,
  }) {
    return service.addWishlist(
      destinationId: destinationId,
      destinationName: destinationName,
      notes: notes,
    );
  }

  Future<Wishlist> updateWishlist({required String id, required String notes}) {
    return service.updateWishlist(id: id, notes: notes);
  }

  Future<void> deleteWishlist(String id) {
    return service.deleteWishlist(id);
  }
}
