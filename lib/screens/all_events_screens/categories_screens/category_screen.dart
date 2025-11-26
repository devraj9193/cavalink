import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';

import '../../../controllers/models/club_models/events_model.dart';
import '../../../controllers/providers/fence_providers.dart';
import '../../../utils/constants.dart';
import '../../../utils/navigation_helper.dart';
import '../../../utils/opacity_to_alpha.dart';
import '../../../widgets/common_app_bar_widget.dart';
import '../../../widgets/loading_indicator.dart';
import '../event_details_screen.dart';
import 'participants_list_screen.dart';

class CategoryScreen extends StatefulWidget {
  final Ongoing event;
  const CategoryScreen({super.key, required this.event});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List categoryList = [
    {
      "title": "100 mtr Race",
      "ageGroups": ["Under 7 Years", "Under 15 Years", "Under 21 Years"]
    },
    {
      "title": "200 mtr Race",
      "ageGroups": ["Under 7 Years", "Under 15 Years", "Under 21 Years"]
    },
    {
      "title": "Horse Jump Event",
      "ageGroups": ["Junior (U-10)", "Intermediate (U-18)", "Pro Level"]
    },
  ];

  int expandedIndex = -1; // Only one expanded at a time
  Map<int, String?> selectedByCategory = {}; // Selected subcategories

  @override
  void initState() {
    super.initState();

    // Fetch Categories
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FenceProvider>(context, listen: false)
          .fetchCategories(context, widget.event.id ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FenceProvider>(context);

    return PopScope(canPop: false,
      child: Scaffold(
        backgroundColor: gWhiteColor,
        appBar: CommonAppBarWidget(
          onBackTap: () {
            NavigationHelper.push(
              context,
              EventDetailsScreen(event: widget.event),
            );
          },
          showBack: true,
          elevation: 0,
          title: widget.event.name,
          showTitleText: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: provider.isCategoriesLoading
              ? LoadingIndicator()
              : provider.categories == null || provider.categories!.isEmpty
                  ? Center(
                      child: Text(
                        "No categories available",
                        style: TextStyle(
                          fontSize: fontSize14,
                          fontFamily: fontMedium,
                          color: gBlackColor,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: provider.categories!.length,
                      itemBuilder: (context, index) {
                        final category = provider.categories![index];
                        final subCategories = category.ageGroups ?? [];

                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.only(bottom: 2.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              key: UniqueKey(),
                              initiallyExpanded: expandedIndex == index,
                              onExpansionChanged: (expanded) {
                                setState(() {
                                  expandedIndex = expanded ? index : -1;
                                });
                              },
                              tilePadding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 0.h),
                              title: Text(
                                category.categoryName ?? '',
                                style: TextStyle(
                                  fontSize: fontSize15,
                                  fontFamily: fontMedium,
                                  color: gHintTextColor,
                                ),
                              ),
                              leading: Icon(
                                Icons.flag_outlined,
                                color: secondaryColor,
                                size: 3.h,
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 3.w,
                                    bottom: 2.h,
                                    right: 3.w,
                                  ),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: subCategories.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 1.h,
                                      crossAxisSpacing: 3.w,
                                      childAspectRatio: 3.5,
                                    ),
                                    itemBuilder: (context, i) {
                                      final sub = subCategories[i];
                                      final isSelected =
                                          selectedByCategory[index] ==
                                              sub.ageGroupName;

                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedByCategory[index] =
                                                sub.ageGroupName;
                                          });

                                          NavigationHelper.push(
                                            context,
                                            ParticipantsListScreen(
                                              event: widget.event,
                                              categories: category,
                                              ageGroups: sub,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 3.w),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? mainColor.withAlpha(
                                                    AlphaHelper.fromOpacity(0.5))
                                                : gWhiteColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: isSelected
                                                  ? mainColor
                                                  : gGreyColor.withAlpha(
                                                      AlphaHelper.fromOpacity(
                                                          0.3)),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: gBlackColor.withAlpha(
                                                    AlphaHelper.fromOpacity(
                                                        0.15)),
                                                blurRadius: 6,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              sub.ageGroupName ?? '',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: fontSize13,
                                                fontFamily: isSelected
                                                    ? fontMedium
                                                    : fontBook,
                                                color: isSelected
                                                    ? gWhiteColor
                                                    : gHintTextColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
