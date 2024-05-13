import 'package:carousel_slider/carousel_slider.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CarouselDialog extends StatefulWidget {
  CarouselDialog({Key? key}) : super(key: key);

  @override
  _CarouselDialogState createState() => _CarouselDialogState();
}

class _CarouselDialogState extends State<CarouselDialog> {
  int _currentIndex = 0;

  final List<String> images = [
    'assest/ImageViewCurasal.png',
    'assest/ImageViewCurasal.png',
    'assest/ImageViewCurasal.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: double.infinity, // Set width to match the parent constraints
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
                    aspectRatio: 4 / 4,
                    enableInfiniteScroll: false,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, _) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: images.map((String url) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: GlobalSizes.getDeviceWidth(context) * 0.78,
                          child: Padding(
                            padding: EdgeInsets.only(top: GlobalSizes.getDeviceHeight(context) * 0.007),
                            child: Image.asset(
                              url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child:Container(
                    width: 30, // Adjust width as needed
                    height: 30, // Adjust height as needed
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(Icons.close,color: Color(0xffFC8019),),
                ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: images.asMap().entries.map((MapEntry<int, String> entry) {
                int index = entry.key;
                return Container(
                  width: GlobalSizes.getDeviceWidth(context) * 0.01,
                  height: GlobalSizes.getDeviceHeight(context) * 0.01,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
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
