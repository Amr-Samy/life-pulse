// lib/resources/helpers/youtube_helper.dart

class YoutubeHelper {
  /// Extracts the YouTube video ID from a variety of URL formats.
  static String? extractVideoId(String? url) {
    if (url == null) return null;
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    if ((uri.host.contains('youtube.com') || uri.host.contains('www.youtube.com')) &&
        uri.pathSegments.contains('watch') &&
        uri.queryParameters.containsKey('v')) {
      return uri.queryParameters['v'];
    }
    if (uri.host == 'youtu.be' && uri.pathSegments.isNotEmpty) {
      return uri.pathSegments.first;
    }
    if (uri.pathSegments.contains('embed') && uri.pathSegments.length > 1) {
      final embedIndex = uri.pathSegments.indexOf('embed');
      if (embedIndex + 1 < uri.pathSegments.length) {
        return uri.pathSegments[embedIndex + 1];
      }
    }
    if (uri.pathSegments.isNotEmpty) {
      return uri.pathSegments.last;
    }
    return null;
  }

  /// Validates if a given URL is a recognizable YouTube URL.
  static bool isValidYouTubeUrl(String? url) {
    return extractVideoId(url) != null;
  }
}