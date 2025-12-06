import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<CarouselProvider>(
      builder: (context, carouselProvider, child) {
        switch (carouselProvider.generalState.requestState) {
          case RequestState.loading:
            return Center(child: CircularProgressIndicator());
          case RequestState.success:
            return Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CarouselSlider.builder(
                      itemCount: carouselProvider.generalState.data.length,
                      itemBuilder: (context, index, realIndex) {
                        final data = carouselProvider.generalState.data[index];
                        return Image.network(data.image, fit: BoxFit.cover, width: double.infinity);
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

                Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: carouselProvider.generalState.data.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 6,
                        dotWidth: 10,
                        activeDotColor: AppConstain.primaryColor,
                        dotColor: Colors.grey.shade300,
                      ),
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
