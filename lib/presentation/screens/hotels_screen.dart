import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/hotels/hotels_bloc.dart';
import '../blocs/hotels/hotels_state.dart';
import '../widgets/hotel_card.dart';

class HotelsScreen extends StatelessWidget {
  const HotelsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hotels')),
      body: BlocBuilder<HotelsBloc, HotelsState>(
        builder: (context, state) {
          if (state is HotelsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HotelsLoaded) {
            return ListView.builder(
              itemCount: state.hotels.length,
              itemBuilder: (context, index) {
                return HotelCard(hotelElement: state.hotels[index]);
              },
            );
          } else if (state is HotelsError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
    );
  }
}
