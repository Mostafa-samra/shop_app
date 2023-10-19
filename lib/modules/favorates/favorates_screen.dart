import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/sheard/styles/colors/colors.dart';

class FavoretsScreen extends StatelessWidget {
  const FavoretsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildFavItem(
                ShopCubit.get(context).favoritesModel!.data!.data![index],
                context),
            separatorBuilder: (context, index) => const Divider(),
            itemCount:
                ShopCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildFavItem(FavoritesData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model.product!.image}'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200.0,
                  ),
                  if (1 != 0)
                    Container(
                      color: Colors.red,
                      child: const Text(
                        'Descount',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${model.product!.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${model.product!.price}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14.0,
                                height: 1.3,
                                color: defaultColor),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (model.product!.discount != 0)
                            Text(
                              "${model.product!.oldPrice}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 10.0,
                                height: 1.3,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .changeFavorites(model.product!.id!);
                            },
                            icon: CircleAvatar(
                              backgroundColor: ShopCubit.get(context)
                                      .favorates[model.product!.id]!
                                  ? defaultColor
                                  : Colors.grey,
                              radius: 15.0,
                              child: const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
