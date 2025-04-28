// models/multi_language_request_model.dart
class MultiLanguageRequest {
  final String? name;
  final String? description;
  final String? note;
  MultiLanguageRequest({this.note, this.name, this.description});

  // Add this copyWith method
  MultiLanguageRequest copyWith(
      {String? name, String? description, String? note}) {
    return MultiLanguageRequest(
      name: name ?? this.name,
      description: description ?? this.description,
      note: note ?? this.note,
    );
  }

// Handle missing keys in fromJson
  factory MultiLanguageRequest.fromJson(Map<String, dynamic> json) {
    return MultiLanguageRequest(
      name: json['name']?.toString(), // Safely parse `name` if present
      description: json['description']
          ?.toString(), // Safely parse `description` if present
      note: json['note_confirm']?.toString(),
    );
  }

  // Modified toJson to remove null or empty values
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (name != null && name!.isNotEmpty) {
      data['name'] = name;
    }
    if (description != null && description!.isNotEmpty) {
      data['description'] = description;
    }
    if (note != null && note!.isNotEmpty) {
      data['note_confirm'] = note;
    }
    return data;
  }
}
