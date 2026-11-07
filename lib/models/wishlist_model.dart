class Wishlist {
  final String id;
  final String destinationId;
  final String destinationName;
  final String notes;
  final DateTime createdAt;

  Wishlist({
    required this.id,
    required this.destinationId,
    required this.destinationName,
    required this.notes,
    required this.createdAt,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) {
    return Wishlist(
      id: json['id']?.toString() ?? '',
      destinationId: json['destination_id']?.toString() ?? '',
      destinationName: json['destination_name']?.toString() ?? '',
      notes: json['notes']?.toString() ?? '',
      createdAt:
          DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destination_id': destinationId,
      'destination_name': destinationName,
      'notes': notes,
    };
  }
}
