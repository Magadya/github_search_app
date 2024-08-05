import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:github_search_app/domain/extensions/extensions.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/models/repo_data_model.dart';
import '../../details_repo/details_repo_screen.dart';
import 'item_card.dart';

class CarouselWidget extends StatefulWidget {
  final List<RepoDataModel> list;

  const CarouselWidget({super.key, required this.list});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int currentSlider = 0;
  final CarouselController _pageController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 60.h,
            autoPlay: false,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                currentSlider = index;
              });
            },
          ),
          carouselController: _pageController,
          itemCount: widget.list.length,
          itemBuilder: (context, index, _) {
            return GestureDetector(
              onTap: () {
                context.push(DetailsRepoScreen(repo: widget.list[index]));
              },
              child: ItemCard(
                item: widget.list[index],
                key: ValueKey<int>(index),
                isVisible: index == currentSlider,
              ),
            );
          },
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.list.length, (index) => buildDotNav(index: index)),
        ),
      ],
    );
  }

  AnimatedContainer buildDotNav({required int index}) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentSlider == index ? 24 : 6,
      decoration: BoxDecoration(
        color: currentSlider == index ? colorScheme.primary : colorScheme.primary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
