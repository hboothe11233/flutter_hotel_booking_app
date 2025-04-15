import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/hotel.dart';
import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/favorites/favorites_event.dart';
import '../blocs/favorites/favorites_state.dart';

class HotelCard extends StatelessWidget {
  final HotelElement hotelElement;
  final bool showRatingInfo; // When true, we are on the favorites screen.
  const HotelCard({super.key, required this.hotelElement, this.showRatingInfo = false});

  /// Helper function to fix mis-encoded text.
  /// The issue occurs when UTF‑8 bytes are misinterpreted as Latin‑1.
  /// This function converts the string as if it were encoded in Latin1, then decodes it as UTF‑8.
  String fixTextEncoding(String? text) {
    if (text == null || text.isEmpty) return '';
    try {
      List<int> latin1Bytes = latin1.encode(text);
      return utf8.decode(latin1Bytes);
    } catch (e) {
      return text;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Choose the primary image URL from the hotel's images list, if available.
    final imageUrl = (hotelElement.images != null && hotelElement.images!.isNotEmpty)
        ? hotelElement.images!.first.large ?? ''
        : '';

    // Derive the number of stars from the hotel's category.
    final starCount = hotelElement.ratingInfo?.score ?? 0.0;

    // Use hotel.destination for location.
    final location = hotelElement.destination ?? '';

    // Travel duration info from bestOffer.travelDate (using 0 if not available).
    final days = hotelElement.bestOffer?.travelDate?.days ?? 0;
    final nights = hotelElement.bestOffer?.travelDate?.nights ?? 0;

    // Room information: room type and boarding.
    final roomType = hotelElement.bestOffer?.rooms?.overall?.name ?? 'Doppelzimmer';
    final boarding = hotelElement.bestOffer?.rooms?.overall?.boarding ?? 'n/a';

    // Traveler count:
    final adultCount = hotelElement.bestOffer?.rooms?.overall?.adultCount ?? 2;
    final childrenCount = hotelElement.bestOffer?.rooms?.overall?.childrenCount ?? 0;
    final flightIncluded = hotelElement.bestOffer?.flightIncluded ?? false;

    // Price info:
    final totalPrice = hotelElement.bestOffer?.total ?? 0;
    final pricePerPerson = hotelElement.bestOffer?.simplePricePerPerson ?? 0;

    // Apply the text-encoding fix to dynamic text fields.
    final decodedName = fixTextEncoding(hotelElement.name).isEmpty
        ? 'Hotel Name'
        : fixTextEncoding(hotelElement.name);
    final decodedLocation = fixTextEncoding(location);
    final decodedRoomType = fixTextEncoding(roomType);
    final decodedBoarding = fixTextEncoding(boarding);

    // Determine the rating info overlay if on favorites screen.
    final ratingInfo = hotelElement.ratingInfo;
    Widget? ratingOverlay;
    if (showRatingInfo && ratingInfo != null) {
      final score = ratingInfo.score ?? 0;
      final scoreDescription = ratingInfo.scoreDescription ?? '';
      final reviewsCount = ratingInfo.reviewsCount ?? 0;
      // Use smiley face for scores ≥ 3, otherwise sad face.
      final IconData smileyFace =
      score >= 3 ? Icons.sentiment_satisfied : Icons.sentiment_dissatisfied;
      final Color ratingColor = score >= 3
          ? Colors.lightGreen.withOpacity(0.8)
          : Colors.redAccent.withOpacity(0.8);

      ratingOverlay = Positioned(
        bottom: 8,
        left: 8,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: ratingColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(smileyFace, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '$score / 5.0',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              ' $scoreDescription ($reviewsCount)',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE WITH OVERLAID FAVORITES BUTTON (and rating overlay if on favorites screen)
          Stack(
            children: [
              // Hotel image with rounded top corners.
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                  imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey,
                    child: const Icon(Icons.image, size: 80),
                  ),
                )
                    : Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey,
                  child: const Icon(Icons.image, size: 80),
                ),
              ),
              // Positioned favorites button at top-right.
              Positioned(
                right: 8,
                top: 8,
                child: BlocBuilder<FavoritesBloc, FavoritesState>(
                  builder: (context, state) {
                    bool isFavorited = false;
                    if (state is FavoritesLoaded) {
                      isFavorited = state.favoriteHotels
                          .any((fav) => fav.hotelId == hotelElement.hotelId);
                    }
                    return IconButton(
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                        shadows: <Shadow>[Shadow(color: Colors.black, blurRadius: 15.0)],
                      ),
                      onPressed: () {
                        context
                            .read<FavoritesBloc>()
                            .add(ToggleFavoriteEvent(hotel: hotelElement));
                      },
                    );
                  },
                ),
              ),
              // If on favorites screen and rating info exists, show the overlay.
              if (ratingOverlay != null) ratingOverlay,
            ],
          ),
          // CONTENT BELOW THE IMAGE
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: showRatingInfo
            // Favorites screen layout: only show hotel name, location and a CTA.
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HOTEL NAME with wrapping allowed.
                Text(
                  decodedName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                ),
                const SizedBox(height: 4),
                // LOCATION with wrapping allowed.
                Text(
                  decodedLocation,
                  style: const TextStyle(color: Colors.grey),
                  softWrap: true,
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
                const SizedBox(height: 12),
                // CTA BUTTON: text changed to "Zum Hotel"
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      // Handle navigation or other actions.
                    },
                    child: const Text(
                      "Zum Hotel",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
            // Default layout: show full details in two columns beneath the divider.
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // STAR RATING
                Row(
                  children: _buildStarRating(starCount),
                ),
                const SizedBox(height: 4),
                // HOTEL NAME (decoded)
                Text(
                  decodedName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // LOCATION (decoded)
                Text(
                  decodedLocation,
                  style: const TextStyle(color: Colors.grey),
                  softWrap: true,
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
                const SizedBox(height: 8),

                // Two-column layout for details vs. price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left column: Duration, room/boarding, travelers
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$days Tage | $nights Nächte',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$decodedRoomType | $decodedBoarding',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                            softWrap: true,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$adultCount Erw., $childrenCount Kinder'
                                '${flightIncluded ? " | inkl. Flug" : ""}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Right column: Price info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'ab ${_formatPrice(totalPrice)} €',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${_formatPrice(pricePerPerson)} € p.P.',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                // CTA BUTTON: "Zu den Angeboten"
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      // Handle navigation or other actions.
                    },
                    child: Text(
                      fixTextEncoding("Zu den Angeboten"),
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a list of star icons for the given [starCount].
  List<Widget> _buildStarRating(double starCount) {
    final validStars = starCount.clamp(0, 5);
    return List.generate(5, (index) {
      return Icon(
        index < validStars ? Icons.star : Icons.star_border,
        size: 18,
        color: Colors.amber,
      );
    });
  }

  /// Helper function to format price into a string with thousands separators.
  String _formatPrice(int price) {
    final priceString = price.toString();
    if (price >= 1000) {
      final before = priceString.substring(0, priceString.length - 3);
      final after = priceString.substring(priceString.length - 3);
      return '$before.$after,00';
    } else {
      return '$priceString,00';
    }
  }
}
