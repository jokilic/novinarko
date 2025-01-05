String cleanUrl(String url) {
  /// Remove `https://www.` or `http://www.` if present
  var cleaned = url.replaceAll(RegExp(r'https?://www\.'), '');

  /// Remove trailing slash if present
  if (cleaned.endsWith('/')) {
    cleaned = cleaned.substring(0, cleaned.length - 1);
  }

  return cleaned;
}

/// Remove any existing protocol (`http://` or `https://`)
/// Return proper `Url` or `Google Search Url`
String processUrl(String addressValue) {
  final cleaned = addressValue.replaceAll(RegExp('https?://'), '');

  /// Split by dots and check the last part
  final parts = cleaned.split('.');

  /// There are no dots, return the URL with `https://` prefix
  if (parts.length > 1 && parts.last.length >= 2) {
    return 'https://$cleaned';
  }

  /// There are dots, return `Google Search Url`
  return 'https://www.google.com/search?q=$cleaned';
}
