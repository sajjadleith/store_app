import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/controllers/details_provider.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/model/book_model.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key, required this.id});
  final String id;

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  void initState() {
    super.initState();
    context.read<DetailsProvider>().fetchData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Details")),
      body: SingleChildScrollView(
        child: Consumer<DetailsProvider>(
          builder: (context, detailsProvider, child) {
            switch (detailsProvider.generalState.requestState) {
              case RequestState.loading:
                return Center(child: CircularProgressIndicator());
              case RequestState.success:
                final BookModel data = detailsProvider.generalState.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(data.title, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 10),
                    Text(data.autherName),
                    SizedBox(height: 10),
                    Text(data.description, overflow: TextOverflow.ellipsis),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 10,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          label: Text("Enter a Comment"),
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      primary: false,
                      shrinkWrap: true,
                      itemCount: data.comments.length,
                      itemBuilder: (context, index) {
                        final comment = data.comments[index];
                        return ListTile(
                          title: Text(comment.user.userName),
                          subtitle: Text(comment.content),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.home),
                          ),
                        );
                      },
                    ),
                  ],
                );
              case RequestState.error:
                return Center(
                  child: Text("Error ${detailsProvider.generalState.error}"),
                );
              case RequestState.empty:
                return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
