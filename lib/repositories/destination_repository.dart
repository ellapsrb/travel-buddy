import '../models/destination_model.dart';
import '../services/destination_api_service.dart';

class DestinationRepository {
  final DestinationApiService apiService;

  DestinationRepository({required this.apiService});

  Future<List<Destination>> getDestinations() async {
    return await apiService.fetchDestinations();
  }
}
