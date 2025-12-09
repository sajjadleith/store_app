import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:store/controllers/comment_provider.dart';
import 'package:store/controllers/details_provider.dart';
import 'package:store/controllers/favourite_provider.dart';
import 'package:store/controllers/rating_provider.dart';
import 'package:store/core/app_constains.dart';
import 'package:store/core/app_icons.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/core/widgets/custom_button_widget.dart';
import 'package:store/core/widgets/navigate_back_widget.dart';
import 'package:store/model/book_model.dart';
import 'package:store/model/comment_model.dart';
import 'package:store/repo/api_repo.dart';
import 'package:store/screens/widgets/show_bottom_sheet_widget.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key, required this.id, this.maxStar = 5, this.size = 28});
  final String id;
  final int maxStar;
  final double size;

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  void initState() {
    super.initState();
    context.read<DetailsProvider>().fetchData(widget.id);
    context.read<CommentProvider>().fetchData(widget.id);
  }

  TextEditingController addCommentController = TextEditingController();
  @override
  void dispose() {
    addCommentController.dispose();
    super.dispose();
  }

  String formatCustomDate(String dateString) {
    final date = DateTime.parse(dateString);
    final day = intl.DateFormat('d').format(date); // 12
    final month = intl.DateFormat('MMMM').format(date); // March
    final year = intl.DateFormat('yy').format(date); // 20

    return "$day $month, $year";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFBF5F4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 120),
            child: Consumer<DetailsProvider>(
              builder: (context, detailsProvider, child) {
                final rating = context.watch<DetailsProvider>().rating;
                switch (detailsProvider.generalState.requestState) {
                  case RequestState.loading:
                    return Center(child: CircularProgressIndicator());
                  case RequestState.success:
                    final BookModel data = detailsProvider.generalState.data;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              NavigateBackWidget(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              SvgPicture.asset(AppIcons.account, width: 30),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            spacing: 20,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 5),
                              Expanded(
                                child: Container(
                                  width: 150,
                                  height: 220,
                                  padding: EdgeInsets.symmetric(horizontal: 22),
                                  decoration: BoxDecoration(
                                    color: AppConstain.secondaryColor,
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(data.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      data.title.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      "by ${data.autherName}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.amber, size: 20),
                                      SizedBox(width: 5),
                                      Text(
                                        "(${data.totalRatings} ratings)",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Text(
                                        "Page Numbers: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "${data.pageNumbers} pages",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Published At: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          data.publishedAt,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          InfoTable(
                            data: {
                              "Categorys": data.categories.map((i) => i.name).join(", "),
                              "Auther Name": data.autherName,
                              "Published At": data.publishedAt,
                              "Page Numbers": "${data.pageNumbers} pages",
                            },
                          ),
                          SizedBox(height: 20),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 5,
                            children: [
                              Text("Tags: "),
                              ...data.categories.map((cat) {
                                return Container(
                                  alignment: Alignment.center,
                                  width: 80,
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.black, width: 2),
                                  ),
                                  child: Text(
                                    cat.name,
                                    style: TextStyle(color: Colors.black, fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(widget.maxStar, (index) {
                              return GestureDetector(
                                onTap: () async {
                                  context.read<DetailsProvider>().setRating(index + 1);
                                  data.totalRatings = index + 1;
                                  await Provider.of<RatingProvider>(
                                    context,
                                    listen: false,
                                  ).postRate(rate: index + 1, bookId: widget.id);
                                  Provider.of<DetailsProvider>(
                                    context,
                                    listen: false,
                                  ).fetchData(widget.id);
                                },
                                child: Icon(
                                  index < rating ? Icons.star : Icons.star_border,
                                  color: index < rating ? Colors.amber : Colors.grey,
                                  size: widget.size,
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextField(
                              controller: addCommentController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: "Leave a comment",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                filled: true,
                                fillColor: Colors.white,
                                suffix: Consumer<CommentProvider>(
                                  builder: (context, value, child) {
                                    return value.isLoadingComment
                                        ? CircularProgressIndicator()
                                        : TextButton(
                                            onPressed: () {
                                              value.addComment(
                                                addCommentController.text,
                                                widget.id,
                                              );
                                              addCommentController.clear();
                                            },
                                            child: Text(
                                              "Post",
                                              style: TextStyle(
                                                color: AppConstain.primaryColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          );
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Consumer<CommentProvider>(
                            builder: (context, commentProvider, child) {
                              switch (commentProvider.generalState.requestState) {
                                case RequestState.loading:
                                  return Center(child: CircularProgressIndicator());

                                case RequestState.success:
                                  final List<CommentModel> comments =
                                      commentProvider.generalState.data ?? [];

                                  if (comments.isEmpty) {
                                    return Text(
                                      "No comments yet",
                                      style: TextStyle(color: Colors.grey),
                                    );
                                  }
                                  // Comment List
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    reverse: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: comments.length,
                                    separatorBuilder: (_, __) => SizedBox(height: 10),
                                    itemBuilder: (context, index) {
                                      final c = comments[index];

                                      return Container(
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFE8E8),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "by ${c.user.userName} . ${formatCustomDate(c.user.createdAt.toString())}",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff474A57),
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  c.content,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                ShowBottomSheetWidget(
                                                  commentId: c.id,
                                                ).showBottomSheet(context);
                                              },
                                              icon: Icon(Icons.edit),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );

                                case RequestState.error:
                                  return Text("Error: ${commentProvider.generalState.error}");

                                case RequestState.empty:
                                  return SizedBox();
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  case RequestState.error:
                    return Center(child: Text("Error ${detailsProvider.generalState.error}"));
                  case RequestState.empty:
                    return SizedBox();
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(),
          SizedBox(
            width: 250,
            child: CustomButtonWidget(title: "Reserved", onPressed: () {}),
          ),
          Material(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black,
            child: InkWell(
              onTap: () async {
                await context.read<FavouriteProvider>().addFavourite(widget.id);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Added to favourites ❤️"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(12),
              splashColor: AppConstain.primaryColor.withOpacity(0.3),
              highlightColor: Colors.white.withOpacity(0.1),
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                child: Icon(Icons.favorite, color: AppConstain.primaryColor, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoTable extends StatelessWidget {
  final Map<String, String> data;

  const InfoTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Left titles
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.keys.map((key) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  key,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(width: 10),

          // ✅ Divider
          Container(width: 1.3, height: (data.length * 34).toDouble(), color: Colors.grey.shade600),

          SizedBox(width: 15),

          // ✅ Right values (مهم جداً Expanded)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.values.map((value) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
