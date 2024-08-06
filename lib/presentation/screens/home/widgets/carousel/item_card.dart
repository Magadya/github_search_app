import 'package:flutter/material.dart';
import 'package:github_search_app/data/models/repo_data_model.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/resources/app_images.dart';
import '../../../../../core/resources/styles/colors.dart';

class ItemCard extends StatefulWidget {
  final RepoDataModel item;
  final bool isVisible;

  const ItemCard({super.key, required this.item, required this.isVisible});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBackgroundContainer(),
        _buildImageContainer(),
        _buildScrollView(),
        _buildDescription(),
      ],
    );
  }

  Widget _buildBackgroundContainer() {
    return Container(
      height: 73.h,
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: defaultAppColor4.withOpacity(0.3),
      ),
    );
  }

  Widget _buildImageContainer() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: (widget.item.avatarUrl ?? '').isNotEmpty
                      ? NetworkImage(widget.item.avatarUrl!) as ImageProvider
                      : const AssetImage(AppImages.image1),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              bottom: 1.h,
              left: 0,
              right: 0,
              child: _buildStatsRow(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      height: 10.h,
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      child: Row(
        children: [
          _buildStatItem(Icons.remove_red_eye, widget.item.watchersCount.toString()),
          const Spacer(),
          _buildStatItem(Icons.star, widget.item.stargazersCount.toString()),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: defaultAppColor4),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: defaultAppColor4),
          ),
        ),
      ],
    );
  }

  Widget _buildScrollView() {
    return Positioned(
      bottom: 11.h,
      left: 2.h,
      right: 2.h,
      child: AnimatedOpacity(
        opacity: widget.isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Row(
          children: [
            _buildAvatarContainer(),
            SizedBox(width: 3.w),
            Expanded(
              child: SizedBox(
                width: 24.h + 4.w,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      6,
                      (index) => Padding(
                        padding: EdgeInsets.only(right: index == 5 ? 0 : 1.w),
                        child: _buildTestImageContainer(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarContainer() {
    return Container(
      height: 6.h,
      width: 6.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: (widget.item.avatarUrl ?? '').isNotEmpty
              ? NetworkImage(widget.item.avatarUrl!) as ImageProvider
              : const AssetImage(AppImages.image1),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildTestImageContainer() {
    return Container(
      width: 6.h,
      height: 6.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: AssetImage(AppImages.image1),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Positioned(
      bottom: 2.h,
      left: 2.h,
      right: 2.h,
      child: SizedBox(
        height: 8.h,
        width: 10.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.language,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20.sp),
            ),
            SizedBox(height: 1.h),
            Text(
              widget.item.description,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
