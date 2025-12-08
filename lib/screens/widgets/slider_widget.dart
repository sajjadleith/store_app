import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store/app_constant.dart';
import 'package:store/controllers/carousel_provider.dart';
import 'package:store/core/app_constains.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/model/carousel_model.dart';

class SliderWidget2 extends StatefulWidget {
  const SliderWidget2({super.key});

  @override
  State<SliderWidget2> createState() => _SliderWidget2State();
}

class _SliderWidget2State extends State<SliderWidget2> {
  int activeIndex = 0;
  @override
  void initState() {
    context.read<CarouselProvider>().providedData();
    super.initState();
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
    return Consumer<CarouselProvider>(
      builder: (context, carouselProvider, child) {
        // final dataText = carouselProvider.generalState.data![activeIndex];
        switch (carouselProvider.generalState.requestState) {
          case RequestState.loading:
            return Center(child: CircularProgressIndicator());
          case RequestState.success:
            final data = carouselProvider.generalState.data!;

            if (data.isEmpty) {
              return const Center(child: Text("No carousel items"));
            }

            if (activeIndex >= data.length) {
              activeIndex = 0;
            }

            final dataText = data[activeIndex];

            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CarouselSlider.builder(
                            itemCount: carouselProvider.generalState.data!.length,
                            itemBuilder: (context, index, realIndex) {
                              final data = carouselProvider.generalState.data![index];
                              return Image.network(
                                data.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              );
                              // return Text("data $index");
                            },
                            options: CarouselOptions(
                              viewportFraction: 1,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              onPageChanged: (index, reason) {
                                setState(() => activeIndex = index);
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataText.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              dataText.autherName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              formatCustomDate(dataText.publishedAt.toString()),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Center(
                  child: AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    count: carouselProvider.generalState.data!.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 6,
                      dotWidth: 10,
                      activeDotColor: AppConstain.primaryColor,
                      dotColor: Colors.grey.shade300,
                    ),
                  ),
                ),
              ],
            );
          case RequestState.error:
            return Center(child: Text("Error no Data"));
          case RequestState.empty:
            return Center(child: Text("no data"));
        }
      },
    );
  }
}
