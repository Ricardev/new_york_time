import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_york_time_api/core/config/injector.dart';
import 'package:new_york_time_api/features/books/domain/entities/list_name_entity.dart';
import 'package:new_york_time_api/features/books/presentation/bloc/best_seller_bloc.dart';
import 'package:new_york_time_api/features/books/presentation/bloc/best_seller_states.dart';
import 'package:new_york_time_api/features/books/presentation/widgets/book_widget.dart';

class BestSellerPage extends StatelessWidget {
  const BestSellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<BestSellerBloc>(),
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            title: Text(
              "New York Times",
              style: TextStyle(color: Colors.black),
            ),
            floating: true,
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: 10,
              child: BlocBuilder<BestSellerBloc, BestSellerState>(
                builder: (context, state) {
                  final bestSellerBloc = context.read<BestSellerBloc>();
                  if (bestSellerBloc.listNames().isNotEmpty) {
                    return DropdownButton<ListNameEntity>(
                        value: state is BestSellerSuccessState
                            ? state.listName
                            : (state as BestSellerLoadingState).listName,
                        items: bestSellerBloc
                            .listNames()
                            .map((e) => DropdownMenuItem<ListNameEntity>(
                                  child: Text(e.displayName),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (listName) {
                          bestSellerBloc.loading(listName);
                          bestSellerBloc.obterBestSellers(listName!);
                        });
                  }

                  return Container();
                },
              ),
            ),
          )
        ],
        body: BlocBuilder<BestSellerBloc, BestSellerState>(
          builder: (context, state) {
            if (state is BestSellerSuccessState) {
              return ListView.builder(
                  itemCount: state.bestSellers.length,
                  itemBuilder: (context, index) => BookWidget(
                        bookAuthor: state.bestSellers[index].author,
                        bookTitle: state.bestSellers[index].title,
                        bookPrice: state.bestSellers[index].price,
                        bookImage: state.bestSellers[index].bookImage,
                        bookDescription: state.bestSellers[index].description,
                        bookUrls: state.bestSellers[index].buyLinks
                            .map((e) => e)
                            .toList(),
                      ));
            }

            if (state is BestSellerErrorState) {
              return Container();
            }

            if (state is BestSellerInitialState) {
              context.read<BestSellerBloc>().loading(null);
              context.read<BestSellerBloc>().obterListNames();
            }

            if (state is BestSellerLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            return Container();
          },
        ),
      )),
    );
  }
}
