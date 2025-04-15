import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/favorites/favorites_state.dart';
import '../widgets/hotel_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoaded) {
            final favorites = state.favoriteHotels;
            if (favorites.isEmpty) {
              return const Center(child: Text('No favorites added.'));
            }
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) => HotelCard(hotelElement: favorites[index], showRatingInfo: true),
            );
          } else if (state is FavoritesError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
