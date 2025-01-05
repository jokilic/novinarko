String cleanUrl(String url) {
  /// Remove `https://www.` or `http://www.` if present
  var cleaned = url.replaceAll(RegExp(r'https?://www\.'), '');

  /// Remove trailing slash if present
  if (cleaned.endsWith('/')) {
    cleaned = cleaned.substring(0, cleaned.length - 1);
  }

  return cleaned;
}

String addHttpsInUrl(String url) {
  /// Remove any existing protocol (`http://` or `https://`)
  final cleaned = url.replaceAll(RegExp('https?://'), '');

  /// Return the URL with `https://` prefix
  return 'https://$cleaned';
}
