import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/controllers/book_provider.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/model/book_model.dart';

import '../../screens/book_details.dart';

class SliverGridWidget extends StatefulWidget {
  const SliverGridWidget({super.key});

  @override
  State<SliverGridWidget> createState() => _SliverGridWidgetState();
}

class _SliverGridWidgetState extends State<SliverGridWidget> {
  @override
  void initState() {
    super.initState();
    context.read<BookProvider>().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, bookProvider, child) {
        switch (bookProvider.generalState.requestState) {
          case RequestState.loading:
            return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));

          case RequestState.success:
            final List<BookModel> data = bookProvider.generalState.data;
            if (data.isEmpty) {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Center(
                    child: Text(
                      "No Books in this category 📚",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              );
            }
            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final BookModel book = data[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookDetails(id: book.id)),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ✅ Image
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              book.image,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // ✅ Title
                        Text(
                          book.title,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        // ✅ Author
                        Text(
                          book.autherName,
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                }, childCount: data.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // ✅ نفس السيرج
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.55,
                ),
              ),
            );

          case RequestState.error:
            return const SliverToBoxAdapter(child: Center(child: Text("Error")));

          case RequestState.empty:
            return const SliverToBoxAdapter(child: Center(child: Text("No data")));
        }
      },
    );
  }
}
