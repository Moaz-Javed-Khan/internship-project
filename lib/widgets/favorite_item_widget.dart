import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/favorites/bloc/favorites_bloc.dart';
import 'package:internship_project/models/product_model.dart';

class FavoriteItemWidget extends StatefulWidget {
  const FavoriteItemWidget({
    super.key,
    required this.favoriteItem,
  });

  final ProductModel favoriteItem;

  @override
  State<FavoriteItemWidget> createState() => _FavoriteItemWidgetState();
}

class _FavoriteItemWidgetState extends State<FavoriteItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.favoriteItem.name),
        trailing: IconButton(
          color: Colors.red,
          icon: const Icon(Icons.favorite),
          onPressed: () => context.read<FavoritesBloc>().add(
                FavoriteItemRemoved(widget.favoriteItem.id),
              ),
        ),
      ),
    );
  }
}
