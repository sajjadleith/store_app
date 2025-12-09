import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/controllers/favourite_provider.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/screens/book_details.dart';
import 'package:store/screens/custom_appbar.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavouriteProvider>().fetchFavourites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFBF5F4),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbarWidget(title: 'Favourite'),

            const SizedBox(height: 16),

            Expanded(
              child: Consumer<FavouriteProvider>(
                builder: (context, favProvider, child) {
                  switch (favProvider.generalState.requestState) {
                    case RequestState.loading:
                      return const Center(child: CircularProgressIndicator());

                    case RequestState.error:
                      return Center(child: Text("Error: ${favProvider.generalState.error}"));

                    case RequestState.success:
                      final favourites = favProvider.generalState.data!;

                      if (favourites.isEmpty) {
                        return const Center(child: Text("No favourites yet ❤️"));
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          itemCount: favourites.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            childAspectRatio: 0.55,
                          ),
                          itemBuilder: (context, index) {
                            final fav = favourites[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookDetails(id: fav.book.id),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        fav.book.image,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  // Title
                                  Text(
                                    fav.book.title,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  const SizedBox(height: 2),

                                  // Author
                                  Text(
                                    fav.book.autherName,
                                    style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );

                    case RequestState.empty:
                      return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
