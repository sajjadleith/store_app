import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/controllers/search_provider.dart';
import 'package:store/core/app_constains.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/screens/custom_appbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchProvider>().fetchBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFBF5F4),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbarWidget(title: "Search"),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        context.read<SearchProvider>().search(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Book, ISBN, Author, Publisher...",
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppConstain.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Consumer<SearchProvider>(
                builder: (context, provider, child) {
                  switch (provider.generalState.requestState) {
                    case RequestState.loading:
                      return const Center(child: CircularProgressIndicator());

                    case RequestState.error:
                      return Center(child: Text(provider.generalState.error));

                    case RequestState.success:
                      final data = provider.generalState.data!;

                      if (data.isEmpty) {
                        return const Center(child: Text("No result found"));
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          itemCount: data.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            childAspectRatio: 0.55,
                          ),
                          itemBuilder: (context, index) {
                            final book = data[index];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                Text(
                                  book.title,
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  book.autherName,
                                  style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
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
