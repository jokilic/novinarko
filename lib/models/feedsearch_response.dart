import 'package:flutter/foundation.dart';

@immutable
class FeedsearchResponse {
  final int? bozo;
  final int? contentLength;
  final String? contentType;
  final String? description;
  final String? favicon;
  final List<dynamic>? hubs;
  final bool? isPodcast;
  final bool? isPush;
  final int? itemCount;
  final String? lastSeen;
  final DateTime? lastUpdated;
  final int? score;
  final String? selfUrl;
  final String? siteName;
  final String? siteUrl;
  final String? title;
  final String? url;
  final double? velocity;
  final String? version;

  const FeedsearchResponse({
    this.bozo,
    this.contentLength,
    this.contentType,
    this.description,
    this.favicon,
    this.hubs,
    this.isPodcast,
    this.isPush,
    this.itemCount,
    this.lastSeen,
    this.lastUpdated,
    this.score,
    this.selfUrl,
    this.siteName,
    this.siteUrl,
    this.title,
    this.url,
    this.velocity,
    this.version,
  });

  @override
  String toString() =>
      'FeedsearchResponse(bozo: $bozo, contentLength: $contentLength, contentType: $contentType, description: $description, favicon: $favicon, hubs: $hubs, isPodcast: $isPodcast, isPush: $isPush, itemCount: $itemCount, lastSeen: $lastSeen, lastUpdated: $lastUpdated, score: $score, selfUrl: $selfUrl, siteName: $siteName, siteUrl: $siteUrl, title: $title, url: $url, velocity: $velocity, version: $version)';

  factory FeedsearchResponse.fromJson(Map<String, dynamic> json) => FeedsearchResponse(
        bozo: json['bozo'] as int?,
        contentLength: json['content_length'] as int?,
        contentType: json['content_type'] as String?,
        description: json['description'] as String?,
        favicon: json['favicon'] as String?,
        hubs: json['hubs'] as List<dynamic>?,
        isPodcast: json['is_podcast'] as bool?,
        isPush: json['is_push'] as bool?,
        itemCount: json['item_count'] as int?,
        lastSeen: json['last_seen'] as String?,
        lastUpdated: json['last_updated'] == null ? null : DateTime.parse(json['last_updated'] as String),
        score: json['score'] as int?,
        selfUrl: json['self_url'] as String?,
        siteName: json['site_name'] as String?,
        siteUrl: json['site_url'] as String?,
        title: json['title'] as String?,
        url: json['url'] as String?,
        velocity: json['velocity'] as double?,
        version: json['version'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'bozo': bozo,
        'content_length': contentLength,
        'content_type': contentType,
        'description': description,
        'favicon': favicon,
        'hubs': hubs,
        'is_podcast': isPodcast,
        'is_push': isPush,
        'item_count': itemCount,
        'last_seen': lastSeen,
        'last_updated': lastUpdated?.toIso8601String(),
        'score': score,
        'self_url': selfUrl,
        'site_name': siteName,
        'site_url': siteUrl,
        'title': title,
        'url': url,
        'velocity': velocity,
        'version': version,
      };

  FeedsearchResponse copyWith({
    int? bozo,
    int? contentLength,
    String? contentType,
    String? description,
    String? favicon,
    List<dynamic>? hubs,
    bool? isPodcast,
    bool? isPush,
    int? itemCount,
    String? lastSeen,
    DateTime? lastUpdated,
    int? score,
    String? selfUrl,
    String? siteName,
    String? siteUrl,
    String? title,
    String? url,
    double? velocity,
    String? version,
  }) =>
      FeedsearchResponse(
        bozo: bozo ?? this.bozo,
        contentLength: contentLength ?? this.contentLength,
        contentType: contentType ?? this.contentType,
        description: description ?? this.description,
        favicon: favicon ?? this.favicon,
        hubs: hubs ?? this.hubs,
        isPodcast: isPodcast ?? this.isPodcast,
        isPush: isPush ?? this.isPush,
        itemCount: itemCount ?? this.itemCount,
        lastSeen: lastSeen ?? this.lastSeen,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        score: score ?? this.score,
        selfUrl: selfUrl ?? this.selfUrl,
        siteName: siteName ?? this.siteName,
        siteUrl: siteUrl ?? this.siteUrl,
        title: title ?? this.title,
        url: url ?? this.url,
        velocity: velocity ?? this.velocity,
        version: version ?? this.version,
      );

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }
    return other is FeedsearchResponse &&
        listEquals(other.hubs, hubs) &&
        other.bozo == bozo &&
        other.contentLength == contentLength &&
        other.contentType == contentType &&
        other.description == description &&
        other.favicon == favicon &&
        other.isPodcast == isPodcast &&
        other.isPush == isPush &&
        other.itemCount == itemCount &&
        other.lastSeen == lastSeen &&
        other.lastUpdated == lastUpdated &&
        other.score == score &&
        other.selfUrl == selfUrl &&
        other.siteName == siteName &&
        other.siteUrl == siteUrl &&
        other.title == title &&
        other.url == url &&
        other.velocity == velocity &&
        other.version == version;
  }

  @override
  int get hashCode =>
      bozo.hashCode ^
      contentLength.hashCode ^
      contentType.hashCode ^
      description.hashCode ^
      favicon.hashCode ^
      hubs.hashCode ^
      isPodcast.hashCode ^
      isPush.hashCode ^
      itemCount.hashCode ^
      lastSeen.hashCode ^
      lastUpdated.hashCode ^
      score.hashCode ^
      selfUrl.hashCode ^
      siteName.hashCode ^
      siteUrl.hashCode ^
      title.hashCode ^
      url.hashCode ^
      velocity.hashCode ^
      version.hashCode;
}
