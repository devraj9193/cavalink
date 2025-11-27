import 'package:cavalink/controllers/models/club_models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:timelines_plus/timelines_plus.dart';
import '../../../utils/constants.dart';
import '../../controllers/models/club_models/events_model.dart';
import '../../controllers/providers/fence_providers.dart';
import '../../utils/navigation_helper.dart';
import '../../utils/opacity_to_alpha.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/common_app_bar_widget.dart';
import '../../widgets/loading_indicator.dart';
import '../dashboard_screen.dart';
import 'categories_screens/category_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  final Ongoing event;
  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final List<String> horseImages = [
    'https://cdn.britannica.com/29/226529-050-975D9CA5/White-horse-galloping-in-a-field.jpg',
    'https://cms.bet442.co.uk/wp-content/uploads/2024/09/runninghorse.jpg',
    'https://www.indiafilings.com/learn/wp-content/uploads/2019/12/GST-on-Horse-Racing.jpg',
    'https://media.istockphoto.com/id/521697371/photo/brown-pedigree-horse.jpg?s=612x612&w=0&k=20&c=x19W0K7iuQhQn_7l3wRqWq-zsbo0oRA33C3OF4nooL0=',
  ];

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

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: gWhiteColor,
        appBar: CommonAppBarWidget(
          onBackTap: () {
            NavigationHelper.push(
              context,
              DashboardScreen(initialIndex: 0),
            );
          },
          showBack: true,
          elevation: 0,
          title: widget.event.name,
          showTitleText: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          child: provider.isCategoriesLoading
              ? LoadingIndicator()
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: FixedTimeline.tileBuilder(
                          theme: TimelineThemeData(
                            nodePosition: 0,
                            indicatorPosition: 0,
                            connectorTheme: ConnectorThemeData(
                              color: gGreyColor,
                              thickness: 2,
                            ),
                          ),
                          builder: TimelineTileBuilder.connected(
                            connectionDirection: ConnectionDirection.before,
                            itemCount: 4,
                            indicatorBuilder: (_, i) => Icon(
                              [
                                Icons.image,
                                // Icons.confirmation_number,
                                Icons.access_time,
                                Icons.info_outline,
                                Icons.list_alt_outlined, // NEW ICON FOR INDEX 4
                              ][i],
                              color: gHintTextColor,
                              size: 3.h,
                            ),
                            connectorBuilder: (_, __, ___) =>
                                const SolidLineConnector(
                                    color: gGreyColor, thickness: 2),
                            contentsBuilder: (context, index) =>
                                _buildContent(index, provider),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: ButtonWidget(
                        text: "View Categories",
                        onPressed: () {
                          NavigationHelper.push(
                            context,
                            CategoryScreen(event: widget.event),
                          );
                        },
                        isLoading: false,
                        buttonWidth: double.infinity,
                        radius: 8,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  /// MAIN BUILDER SWITCH
  Widget _buildContent(int index, FenceProvider provider) {
    switch (index) {
      case 0:
        return _buildImageGallery();
      // case 1:
      //   return _buildCard(
      //     title: "Get Your Ticket",
      //     child: _buildInfoRow(Icons.calendar_today_outlined, widget.event["date"]),
      //     book: ButtonWidget(
      //       text: "Book",
      //       onPressed: () {},
      //       isLoading: false,
      //       radius: 20,
      //       buttonWidth: 20.w,
      //       color: gHintTextColor,
      //       textColor: gWhiteColor,
      //     ),
      //   );
      case 1:
        return _buildCard(
          title: "Time & Date",
          child: _buildInfoRow(
              Icons.calendar_today, widget.event.eventStartDate ?? ''),
        );
      case 2:
        return _buildCard(
          title: "About",
          child: Text(
            "The ${widget.event.name} brings together top jockeys and champion horses for a thrilling showcase of speed, skill, and style. Join us for an unforgettable day!",
            style: TextStyle(
              fontSize: fontSize13,
              fontFamily: fontBook,
              color: gHintTextColor,
            ),
          ),
        );
      case 3:
        return _buildEventDetailImages(provider);
      default:
        return const SizedBox();
    }
  }

  /// IMAGE GALLERY
  Widget _buildImageGallery() => Padding(
        padding: EdgeInsets.only(left: 5.w, bottom: 3.h),
        child: SizedBox(
          height: 30.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: horseImages.length,
            separatorBuilder: (_, __) => SizedBox(width: 5.w),
            itemBuilder: (_, i) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: gBlackColor.withAlpha(AlphaHelper.fromOpacity(0.15)),
                    blurRadius: 10,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  horseImages[i],
                  width: 60.w,
                  height: 30.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      );

  /// COMMON CARD WRAPPER
  Widget _buildCard(
          {required String title, required Widget child, Widget? book}) =>
      Container(
        margin: EdgeInsets.only(bottom: 3.h, left: 3.w),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gBlackColor.withAlpha(AlphaHelper.fromOpacity(0.2)),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: fontSize15,
                      fontFamily: fontMedium,
                      color: gBlackColor,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  child,
                ],
              ),
            ),
            book ?? SizedBox(),
          ],
        ),
      );

  /// SIMPLE ICON + TEXT ROW
  Widget _buildInfoRow(IconData icon, String text) => Row(
        children: [
          Icon(icon, color: gHintTextColor, size: 2.h),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: gHintTextColor,
                fontSize: fontSize12,
                fontFamily: fontBook,
              ),
            ),
          ),
        ],
      );

  Widget _buildEventDetailImages(FenceProvider provider) {
    return Container(
      margin: EdgeInsets.only(left: 3.w, bottom: 3.h),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gBlackColor.withAlpha(AlphaHelper.fromOpacity(0.12)),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: provider.categories == null || provider.categories!.isEmpty
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
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Event Details",
                    style: TextStyle(
                      fontSize: fontSize15,
                      fontFamily: fontMedium,
                      color: gBlackColor,
                    ),
                  ),
                  SizedBox(height: 2.h),

                  // Replaced ListView with Column
                  ...provider.categories!.asMap().entries.map((entry) {
                    int index = entry.key;
                    var category = entry.value;

                    return GestureDetector(
                      onTap: () {
                        showSubCategoryPopup(category, index);
                      },
                      child: Card(
                        elevation: 4,
                        margin: EdgeInsets.only(bottom: 2.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 2.h),
                          child: Row(
                            children: [
                              Icon(Icons.flag_outlined,
                                  color: secondaryColor, size: 3.h),
                              SizedBox(width: 3.w),
                              Text(
                                category.categoryName ?? '',
                                style: TextStyle(
                                  fontSize: fontSize15,
                                  fontFamily: fontMedium,
                                  color: gHintTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label :",
            style: TextStyle(
              fontSize: fontSize13,
              fontFamily: fontBook,
              color: gHintTextColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize14,
              fontFamily: fontMedium,
              color: gBlackColor,
            ),
          ),
        ],
      ),
    );
  }

  void showSubCategoryPopup(Category categories, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading
                Center(
                  child: Text(
                    categories.categoryName ?? '',
                    style: TextStyle(
                      fontSize: fontSize16,
                      fontFamily: fontMedium,
                      color: gBlackColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: Divider(),
                ),
                ListView.builder(
                  itemCount: categories.ageGroups?.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    final sub = categories.ageGroups?[i];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sub category name heading
                        Text(
                          sub?.ageGroupName ?? '',
                          style: TextStyle(
                            fontSize: fontSize14,
                            fontFamily: fontMedium,
                            color: gBlackColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.h),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _detailRow("Table", sub?.ageGroupTable ?? ''),
                              _detailRow("Max Penalty", sub?.maxPenalty ?? ''),
                              _detailRow("Height", sub?.height ?? ''),
                              _detailRow("Speed", sub?.speed ?? ''),
                              _detailRow("Length", sub?.length ?? ''),
                            ],
                          ),
                        ),

                      ],
                    );
                  },
                ),

                SizedBox(height: 2.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
