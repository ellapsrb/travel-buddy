import 'package:flutter/material.dart';

import '../models/wishlist_model.dart';
import '../repositories/wishlist_repository.dart';

class WishlistProvider extends ChangeNotifier {
  final WishlistRepository repository;

  WishlistProvider({required this.repository});

  List<Wishlist> _wishlists = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Wishlist> get wishlists => _wishlists;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool isSaved(String destinationId) {
    return _wishlists.any((item) => item.destinationId == destinationId);
  }

  // READ
  Future<void> fetchWishlists() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _wishlists = await repository.getWishlists();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // CREATE
  Future<void> addWishlist({
    required String destinationId,
    required String destinationName,
    required String notes,
  }) async {
    try {
      if (isSaved(destinationId)) {
        throw Exception('Destinasi sudah ada di Wishlist.');
      }

      final newWishlist = await repository.addWishlist(
        destinationId: destinationId,
        destinationName: destinationName,
        notes: notes,
      );

      _wishlists.insert(0, newWishlist);
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    }
  }

  // UPDATE
  Future<void> updateWishlist({
    required String id,
    required String notes,
  }) async {
    try {
      final updatedWishlist = await repository.updateWishlist(
        id: id,
        notes: notes,
      );

      final index = _wishlists.indexWhere((item) => item.id == id);

      if (index != -1) {
        _wishlists[index] = updatedWishlist;
      }

      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    }
  }

  // DELETE
  Future<void> deleteWishlist(String id) async {
    try {
      await repository.deleteWishlist(id);

      _wishlists.removeWhere((item) => item.id == id);

      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    }
  }
}
