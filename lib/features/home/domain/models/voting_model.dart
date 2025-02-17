class VotingModel {
  VotingModel({
    required this.voting,
    this.marked = false,
  });

  final String voting;
  bool marked;

  factory VotingModel.fromJson(Map<String, dynamic> json) {
    return VotingModel(
      voting: json['voting'] as String,
      marked: json['marked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'voting': voting,
        'marked': marked,
      };
}

