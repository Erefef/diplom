class Contraction {
  final DateTime start;
  final DateTime end;

  Contraction({required this.start, required this.end});

  Duration get duration => end.difference(start);



  Map<String, dynamic> toJson() => {
    'start': start.toIso8601String(),
    'end': end.toIso8601String(),
  };

  factory Contraction.fromJson(Map<String, dynamic> json) => Contraction(
    start: DateTime.parse(json['start']),
    end: DateTime.parse(json['end']),
  );
}
