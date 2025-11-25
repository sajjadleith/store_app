import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:store/controllers/book_provider.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/model/book_model.dart';

import '../../screens/book_details.dart';
import '../app_icons.dart';

class SliverGridWidget extends StatefulWidget {
  const SliverGridWidget({super.key});

  @override
  State<SliverGridWidget> createState() => _SliverGridWidgetState();
}

class _SliverGridWidgetState extends State<SliverGridWidget> {
  @override
  void initState() {
    context.read<BookProvider>().fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, bookProvider, child) {
        switch (bookProvider.generalState.requestState) {
          case RequestState.loading:
            return SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );

          case RequestState.success:
            return SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemCount: bookProvider.generalState.data.length,
              itemBuilder: (BuildContext context, int index) {
                final BookModel data = bookProvider.generalState.data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetails(id: data.id),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            // height: 40,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              height: 200,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 30,
                                  bottom: 30,
                                ),
                                child: Image.network(
                                  "https://picsum.photos/200/3$index",
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    data.title,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.star,
                                      colorFilter: ColorFilter.mode(
                                        Colors.yellow.shade900,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    Text(
                                      data.totalRatings.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              data.autherName,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );

          case RequestState.error:
            return SliverToBoxAdapter(child: Center(child: Text("Error")));

          case RequestState.empty:
            return SliverToBoxAdapter(child: Center(child: Text("no data")));
        }
      },
    );
  }
}
