import 'package:cavalink/controllers/models/club_models/events_model.dart';
import 'package:cavalink/utils/opacity_to_alpha.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../utils/constants.dart';
import '../../utils/navigation_helper.dart';
import '../all_events_screens/event_details_screen.dart';

class MyEvents extends StatefulWidget {
  final List<Ongoing> ongoing;
  final List<Ongoing> upcoming;
  final List<Ongoing> completed;

  const MyEvents(
      {super.key,
      required this.ongoing,
      required this.upcoming,
      required this.completed});

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  final List<Map<String, dynamic>> events = [
    {
      "title": "Music Fiesta Night",
      "date": "Nov 20, 2025",
      "location": "Downtown Arena",
      "status": "New",
      "image":
          "https://images.unsplash.com/photo-1518972559570-7cc1309f3229?auto=format&fit=crop&w=800&q=60",
      "colors": [Color(0xFFff7e5f), Color(0xFFfeb47b)],
    },
    {
      "title": "Art & Soul Exhibition",
      "date": "Nov 22, 2025",
      "location": "City Art Hall",
      "status": "Upcoming",
      "image":
          "https://images.unsplash.com/photo-1529101091764-c3526daf38fe?auto=format&fit=crop&w=800&q=60",
      "colors": [Color(0xFF43cea2), Color(0xFF185a9d)],
    },
    {
      "title": "Food Carnival",
      "date": "Nov 25, 2025",
      "location": "Sunshine Park",
      "status": "Ongoing",
      "image":
          "https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?auto=format&fit=crop&w=800&q=60",
      "colors": [Color(0xFFe96443), Color(0xFF904e95)],
    },
    {
      "title": "Online Tech Innovation Summit",
      "date": "Nov 30, 2025",
      "location": "Virtual Event",
      "status": "Upcoming",
      "image":
          "https://images.unsplash.com/photo-1556761175-5973dc0f32e7?auto=format&fit=crop&w=800&q=60",
      "colors": [Color(0xFF4facfe), Color(0xFF00f2fe)],
    },
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: gWhiteColor,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.transparent),
              ),
            ),
            child: TabBar(
              controller: tabController,
              labelColor: gBlackColor,
              unselectedLabelColor: gHintTextColor,
              tabAlignment: TabAlignment.start,
              labelStyle: TextStyle(
                fontFamily: fontMedium,
                fontSize: fontSize18,
              ),
              unselectedLabelStyle: TextStyle(
                fontFamily: fontBook,
                fontSize: fontSize15,
              ),
              indicator: const BoxDecoration(), // no underline
              dividerColor: Colors.transparent, // no divider
              isScrollable: true,
              tabs: const [
                Tab(text: "Ongoing"),
                Tab(text: "Upcoming"),
                Tab(text: "Completed"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                _buildEventList(widget.ongoing, isOngoing: true),
                _buildEventList(widget.upcoming),
                _buildEventList(widget.completed),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventList(List<Ongoing> filteredEvents,
      {bool isOngoing = false}) {
    if (filteredEvents.isEmpty) {
      return const Center(
        child: Text(
          "No events found.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(4.w),
      itemCount: filteredEvents.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final event = filteredEvents[index];
        return _buildEventRow(event,isOngoing: isOngoing);
      },
    );
  }

  Widget _buildEventRow(Ongoing event, {bool isOngoing = false}) {
    final gradient = LinearGradient(
      colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Container(
      margin: EdgeInsets.only(bottom: 3.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT SIDE (status + date)
          if (isOngoing)
            Container(
              width: 25.w,
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 1.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: _getStatusColor(event.status.toString()),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      event.status?.toUpperCase() ?? '',
                      style: TextStyle(
                        color: gWhiteColor,
                        fontSize: fontSize12,
                        fontFamily: fontMedium,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    event.eventStartDate ?? '',
                    style: TextStyle(
                      color: gHintTextColor,
                      fontSize: fontSize12,
                      fontFamily: fontBook,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          SizedBox(width: 3.w),

          // RIGHT SIDE (image + details)
          Expanded(
            child: GestureDetector(
              onTap: () {
                NavigationHelper.push(
                  context,
                  EventDetailsScreen(event: event),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color:
                          gBlackColor.withAlpha(AlphaHelper.fromOpacity(0.2)),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Image.network(
                        "https://www.indiafilings.com/learn/wp-content/uploads/2019/12/GST-on-Horse-Racing.jpg",
                        height: 22.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: gBlackColor
                                .withAlpha(AlphaHelper.fromOpacity(0.2)),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(16),
                            ),
                          ),
                          padding: EdgeInsets.all(3.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.name ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.white70, size: 16),
                                  SizedBox(width: 2.w),
                                  Expanded(
                                    child: Text(
                                      event.location ?? '',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.5.h),
                              if(!isOngoing)
                                Row(
                                  children: [
                                    const Icon(Icons.date_range_outlined,
                                        color: Colors.white70, size: 16),
                                    SizedBox(width: 2.w),
                                    Expanded(
                                      child: Text(
                                        event.eventStartDate ?? '',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return Colors.green;
      case "upcoming":
        return Colors.orange;
      case "completed":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
