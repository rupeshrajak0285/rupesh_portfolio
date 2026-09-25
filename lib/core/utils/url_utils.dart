import 'package:url_launcher/url_launcher.dart';

class UrlUtils {
  UrlUtils._();

  static Future<void> open(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // ignore: avoid_print
      print('Could not launch $url');
    }
  }

  static Future<void> email(String address, {String? subject, String? body}) {
    final uri = Uri(
      scheme: 'mailto',
      path: address,
      query: _encodeQuery({
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      }),
    );
    return launchUrl(uri);
  }

  static Future<void> phone(String number) =>
      launchUrl(Uri(scheme: 'tel', path: number));

  static String? _encodeQuery(Map<String, String> params) {
    if (params.isEmpty) return null;
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
