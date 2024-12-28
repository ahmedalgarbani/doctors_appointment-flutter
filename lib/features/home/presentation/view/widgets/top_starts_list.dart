
import 'package:doctors_appointment/features/home/presentation/view/widgets/top_rating_start_list_item.dart';
import 'package:flutter/material.dart';

class TopRatingStartsList extends StatefulWidget {
  const TopRatingStartsList({super.key});

  @override
  State<TopRatingStartsList> createState() => _TopRatingStartsListState();
}

class _TopRatingStartsListState extends State<TopRatingStartsList> {
  int activeIndex = 0; 

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        6,
        (index) {
          final reverseNumber = 5 - index;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  activeIndex = index;
                });
              },
              child: TopRatingStartsListItem(
                activeIndex: activeIndex == index, 
                index: index,
                reverseNumber: reverseNumber,
              ),
            ),
          );
        },
      ),
    );
  }
}
