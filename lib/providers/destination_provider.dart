import 'package:flutter/material.dart';

import '../models/destination_model.dart';
import '../repositories/destination_repository.dart';

class DestinationProvider extends ChangeNotifier {
  final DestinationRepository repository;

  DestinationProvider({required this.repository});

  List<Destination> _destinations = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Destination> get destinations => _destinations;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchDestinations() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _destinations = await repository.getDestinations();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshDestinations() async {
    await fetchDestinations();
  }
}
