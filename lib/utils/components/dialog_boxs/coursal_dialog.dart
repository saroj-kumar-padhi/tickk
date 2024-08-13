import 'package:carousel_slider/carousel_slider.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CarouselDialog extends StatefulWidget {
  List<dynamic> images;

  CarouselDialog({super.key, required this.images});

  @override
  _CarouselDialogState createState() => _CarouselDialogState();
}

class _CarouselDialogState extends State<CarouselDialog> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    autoPlay: false,
                    aspectRatio: 2 / 4,
                    enableInfiniteScroll: false,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, _) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: widget.images.map((dynamic imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return SizedBox(
                          width: GlobalSizes.getDeviceWidth(context) * 0.75,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: GlobalSizes.getDeviceHeight(context) *
                                    0.007),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                    child: Text('Image not found'));
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Positioned(
                  top: 10.h,
                  right: 10.h,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Color(0xffFC8019),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.images.asMap().entries.map((entry) {
                int index = entry.key;
                return Container(
                  width: GlobalSizes.getDeviceWidth(context) * 0.01,
                  height: GlobalSizes.getDeviceHeight(context) * 0.01,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == _currentIndex ? Colors.orange : Colors.grey,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
