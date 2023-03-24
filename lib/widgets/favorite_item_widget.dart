import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/favorites/bloc/favorites_bloc.dart';
import 'package:internship_project/models/product_model.dart';
import 'package:internship_project/products/view/product_detail_view.dart';

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
    return GestureDetector(
      onTap: () {
        var bloc = context.read<FavoritesBloc>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductDetail(
                bloc: bloc,
                product: widget.favoriteItem,
              );
            },
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(widget.favoriteItem.name),
            leading: Image.network(
              widget.favoriteItem.image,
            ),
            trailing: IconButton(
              color: Colors.red,
              icon: const Icon(Icons.favorite),
              onPressed: () => context.read<FavoritesBloc>().add(
                    FavoriteItemRemoved(widget.favoriteItem.id),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
