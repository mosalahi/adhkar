class AdhkarCategory {
  final int id;
  final String name;
  final String icon;
  final String description;
  final List<Dhikr> adhkar;

  const AdhkarCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.adhkar,
  });

  factory AdhkarCategory.fromJson(Map<String, dynamic> json) {
    return AdhkarCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String,
      adhkar: (json['adhkar'] as List<dynamic>)
          .map((item) => Dhikr.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Dhikr {
  final int id;
  final String text;
  final String? fadl;
  final String? source;
  final int count;

  const Dhikr({
    required this.id,
    required this.text,
    this.fadl,
    this.source,
    required this.count,
  });

  factory Dhikr.fromJson(Map<String, dynamic> json) {
    return Dhikr(
      id: json['id'] as int,
      text: json['text'] as String,
      fadl: json['fadl'] as String?,
      source: json['source'] as String?,
      count: ((json['count'] as int?) ?? 1).clamp(1, 10000),
    );
  }
}
