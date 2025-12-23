import 'package:hive_ce/hive.dart';
import 'package:uuid/uuid.dart';

import 'feed_item.dart';

part 'feed_folder.g.dart';

@HiveType(typeId: 3)
class FeedFolder extends FeedItem {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final List<FeedItem> children;

  FeedFolder({
    required this.id,
    required this.name,
    required this.children,
  });

  factory FeedFolder.create({required String name}) => FeedFolder(
    id: const Uuid().v4(),
    name: name,
    children: [],
  );

  @override
  String toString() => 'FeedFolder(id: $id, name: $name, children: $children)';

  @override
  bool operator ==(covariant FeedFolder other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name && other.children == children;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ children.hashCode;
}
