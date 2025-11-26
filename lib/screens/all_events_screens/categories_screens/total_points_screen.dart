import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';

import '../../../controllers/models/club_models/categories_model.dart';
import '../../../controllers/models/club_models/events_model.dart';
import '../../../controllers/models/club_models/paricipants_model.dart';
import '../../../controllers/providers/fence_providers.dart';
import '../../../utils/constants.dart';
import '../../../utils/opacity_to_alpha.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/common_app_bar_widget.dart';
import '../../../widgets/text_field_widgets/custom_date_text_field.dart';

class TotalPointsScreen extends StatefulWidget {
  final Ongoing event;
  final Category categories;
  final AgeGroups ageGroups;
  final Participants participants;
  final String status;
  const TotalPointsScreen(
      {super.key,
      required this.event,
      required this.categories,
      required this.ageGroups,
      required this.participants, required this.status});

  @override
  State<TotalPointsScreen> createState() => _TotalPointsScreenState();
}

class _TotalPointsScreenState extends State<TotalPointsScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<FenceProvider>(context, listen: false);

      // Set timeAllowed from participant
      provider.setTimeAllowed(
          int.parse("${widget.participants.ageGroups?.timeAllowed}"));

      // Fill controllers
      provider.fillFinalControllers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: gWhiteColor,
        appBar: CommonAppBarWidget(
          onBackTap: () => Navigator.pop(context),
          showBack: true,
          elevation: 0,
          title:
              "${widget.categories.categoryName} - ${widget.ageGroups.ageGroupName}",
          showTitleText: true,
        ),
        body: Consumer<FenceProvider>(builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // Rider | Horse
                    Center(
                      child: Text(
                        "Rider : ${widget.participants.riderName} | ${widget.participants.riderId}",
                        style: TextStyle(
                          fontSize: fontSize14,
                          fontFamily: fontMedium,
                          color: gBlackColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Center(
                      child: Text(
                        "Horse : ${widget.participants.horseName} | ${widget.participants.horseId}",
                        style: TextStyle(
                          fontSize: fontSize12,
                          fontFamily: fontBook,
                          color: gBlackColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // const Text("Fence Answers:",
                    //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    //
                    // const SizedBox(height: 10),
                    //
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   itemCount: widget.answers.length,
                    //   itemBuilder: (context, index) {
                    //     return ListTile(
                    //       title: Text("Fence ${index + 1}"),
                    //       trailing: Text(
                    //         widget.answers[index] ?? "--",
                    //         style: const TextStyle(fontWeight: FontWeight.bold),
                    //       ),
                    //     );
                    //   },
                    // ),
                    //
                    // const SizedBox(height: 2.h),
                    Row(
                      children: [
                        Expanded(
                          child: buildFields(
                              "Total Fences Passed",
                              'Total Fences Passed',
                              provider.totalPointsController,
                              readOnly: true),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: buildFields("Fence Penalty", 'Fence Penalty',
                              provider.totalR1Controller,
                              readOnly: true),
                        ),
                      ],
                    ),

                    buildFields(
                        "Time Taken", 'Time taken', provider.timeController),
                    Row(
                      children: [
                        Expanded(
                          child: buildFields("Time Allowed", 'Time Allowed',
                              provider.timeAllowedController,
                              readOnly: true),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: buildFields("Time Penalty", 'Time penalty',
                              provider.timePenaltyController,
                              readOnly: true),
                        )
                      ],
                    ),

                    buildFields("Total Penalty", 'Total penalty',
                        provider.totalPenaltyController,
                        readOnly: true, isLast: true),

                    SizedBox(height: 5.h),
                    Center(
                      child: ButtonWidget(
                        text: "Submit",
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            String finalStatus = widget.status; // default status

                            if (provider.allAnswered) {
                              int totalPenalty = int.tryParse(provider.totalPenaltyController.text) ?? 0;
                              int maxPenalty = int.tryParse("${widget.participants.ageGroups?.maxPenalty}") ?? 0;

                              if (totalPenalty > maxPenalty) {
                                finalStatus = "eliminated";
                              }
                              // else keep widget.status as is (e.g., "registered" or "active")
                            }

                            await provider.submitFinalScore(
                              context: context,
                              event: widget.event,
                              category: widget.categories,
                              ageGroup: widget.ageGroups,
                              participants: widget.participants,
                              status: finalStatus,
                            );
                          }
                        },
                        isLoading: provider.isSubmitParticipants,
                        radius: 8,
                        buttonWidth: 20.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// Reusable Field Builder
  buildFields(String title, String hintText, TextEditingController controller,
      {bool readOnly = false, bool isLast = false}) {
    return Column(
      crossAxisAlignment:
          isLast ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          "$title : ",
          style: TextStyle(
            fontSize: fontSize13,
            fontFamily: fontMedium,
            color: gHintTextColor,
          ),
        ),
        SizedBox(height: readOnly ? 1.h : 0),
        SizedBox(
          width: isLast ? 40.w : double.maxFinite,
          child: CustomTextField(
            controller: controller,
            readOnly: readOnly,
            align: isLast ? TextAlign.center : TextAlign.start,
            fillColor: readOnly
                ? gHintTextColor.withAlpha(AlphaHelper.fromOpacity(0.1))
                : gWhiteColor,
            hintText: hintText,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            borderType: readOnly
                ? TextFieldBorderType.full
                : TextFieldBorderType.underline,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your Answer';
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 2.h),
      ],
    );
  }
}
