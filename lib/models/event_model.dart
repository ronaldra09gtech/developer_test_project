class Event {
  final int? id;
  final String button;
  final String timestamp;

  Event({this.id, required this.button, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {'id': id, 'button': button, 'timestamp': timestamp};
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(id: map['id'], button: map['button'], timestamp: map['timestamp']);
  }
}
