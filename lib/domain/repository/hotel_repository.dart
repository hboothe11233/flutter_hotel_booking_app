import 'package:http/http.dart' as http;
import '../../data/models/hotel.dart';

class HotelRepository {
  final String baseUrl = 'https://dkndmolrswy7b.cloudfront.net/hotels.json';

  /// Fetches hotel data from the API.
  ///
  /// This method uses the provided `hotelFromJson` function to parse the entire JSON
  /// into a top-level [Hotel] object and then returns its `hotels` list, which is a
  /// list of [HotelElement] objects.
  Future<List<HotelElement>> fetchHotels() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      try {
        // Parse the JSON response into a top-level Hotel object.
        final hotelResponse = hotelFromJson(response.body);
        // Return the inner list of HotelElement objects; if null, return an empty list.
        return hotelResponse.hotels ?? [];
      } catch (e) {
        throw Exception('Error parsing hotel data: $e');
      }
    } else {
      throw Exception('Failed to load hotels. Status code: ${response.statusCode}');
    }
  }
}
