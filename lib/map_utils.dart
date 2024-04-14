import 'package:url_launcher/url_launcher.dart';

class Maptutils {
  static Future<void> openmap(String long, String lang) async {
    Uri googleMapUrl = Uri.parse(
        "https://www.google.com/maps/search/gas_station/@${lang}${lang}?filters=distance");

    if (await canLaunchUrl(googleMapUrl as Uri)) {
      await launchUrl(googleMapUrl as Uri);
    } else {
      throw 'Couldnot open map';
    }
  }
}
