import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/favorites/bloc/favorites_bloc.dart';
import 'package:internship_project/widgets/favorite_item_widget.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.favoriteItem.length,
            itemBuilder: (context, index) {
              final item = state.favoriteItem[index];
              return FavoriteItemWidget(
                favoriteItem: item,
              );
            },
          );
        },
      ),
    );
  }
}
