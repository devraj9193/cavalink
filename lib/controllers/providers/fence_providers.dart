import 'package:flutter/material.dart';
import '../../screens/all_events_screens/categories_screens/participants_list_screen.dart';
import '../../utils/api_end_points.dart';
import '../../utils/app_config.dart';
import '../../utils/navigation_helper.dart';
import '../../utils/network_service.dart';
import '../models/club_models/categories_model.dart';
import '../models/club_models/events_model.dart';
import '../models/club_models/paricipants_model.dart';

enum LoadingType { events, categories, participants,submitParticipants }

class FenceProvider extends ChangeNotifier {
  final pref = AppConfig().preferences;

  // -------------------------------------------------------------------
  // LOADING
  // -------------------------------------------------------------------
  bool isEventsLoading = false;
  bool isCategoriesLoading = false;
  bool isParticipantsLoading = false;
  bool isSubmitParticipants = false;

  void _setLoading(bool value, {required LoadingType type}) {
    switch (type) {
      case LoadingType.events:
        isEventsLoading = value;
        break;
      case LoadingType.categories:
        isCategoriesLoading = value;
        break;
      case LoadingType.participants:
        isParticipantsLoading = value;
        break;
      case LoadingType.submitParticipants:
        isSubmitParticipants = value;
        break;
    }
    notifyListeners();
  }

  // -------------------------------------------------------------------
  // EVENTS DATA
  // -------------------------------------------------------------------
  List<Ongoing> myUpcoming = [];
  List<Ongoing> myOngoing = [];
  List<Ongoing> myCompleted = [];
  List<Ongoing> otherUpcoming = [];
  List<Ongoing> otherOngoing = [];
  List<Ongoing> otherCompleted = [];

  Future<void> fetchEvents(BuildContext context, int clubId) async {
    _setLoading(true, type: LoadingType.events);

    try {
      final data = await NetworkService.get(ApiEndpoints.eventsApiUrl(clubId));

      if (data["status"] == true) {
        final model = EventsModel.fromJson(Map<String, dynamic>.from(data));

        myUpcoming = model.data?.myEvents?.upcoming ?? [];
        myOngoing = model.data?.myEvents?.ongoing ?? [];
        myCompleted = model.data?.myEvents?.completed ?? [];

        otherUpcoming = model.data?.otherEvents?.upcoming ?? [];
        otherOngoing = model.data?.otherEvents?.ongoing ?? [];
        otherCompleted = model.data?.otherEvents?.completed ?? [];
      } else {
        AppConfig().showSnackBar(context, data["message"], isError: true);
      }
    } catch (e) {
      AppConfig().showSnackBar(context, "Error $e", isError: true);
    }

    _setLoading(false, type: LoadingType.events);
  }

  // -------------------------------------------------------------------
  // CATEGORY DATA
  // -------------------------------------------------------------------
  List<Category>? categories = [];

  Future<void> fetchCategories(BuildContext context, int eventId) async {
    _setLoading(true, type: LoadingType.categories);

    try {
      final data =
          await NetworkService.get(ApiEndpoints.categoriesApiUrl(eventId));

      if (data["status"] == true) {
        final model = CategoriesModel.fromJson(Map<String, dynamic>.from(data));
        categories = model.data?.category ?? [];
      } else {
        AppConfig().showSnackBar(context, data["message"], isError: true);
      }
    } catch (e) {
      AppConfig().showSnackBar(context, "Error $e", isError: true);
    }

    _setLoading(false, type: LoadingType.categories);
  }

  // -------------------------------------------------------------------
  // PARTICIPANTS DATA
  // -------------------------------------------------------------------
  List<Participants>? participants = [];

  Future<void> fetchParticipants(
      BuildContext context, int eventId, int categoryId) async {
    _setLoading(true, type: LoadingType.participants);

    try {
      final data = await NetworkService.get(
          ApiEndpoints.participantsApiUrl(eventId, categoryId));

      if (data["status"] == true) {
        final model =
            ParticipantsModel.fromJson(Map<String, dynamic>.from(data));
        participants = model.data?.participants ?? [];
      } else {
        AppConfig().showSnackBar(context, data["message"], isError: true);
      }
    } catch (e) {
      AppConfig().showSnackBar(context, "Error $e", isError: true);
    }

    _setLoading(false, type: LoadingType.participants);
  }

  // -------------------------------------------------------------------
  // FENCE QUIZ LOGIC
  // -------------------------------------------------------------------
  List<Fences> fences = [];
  int currentFence = 0;
  List<String?> answers = [];

  bool r1Used = false;                  // Global flag
  List<bool> r1SelectedForFence = [];   // Track R1 per fence

  List<List<String>> selections = [];

  void loadFences(List<Fences> fenceList) {
    fences = fenceList;
    answers = List<String?>.filled(fences.length, null);
    selections = List.generate(fences.length, (_) => []);
    r1Used = false;
    r1SelectedForFence = List<bool>.filled(fences.length, false);
    currentFence = 0;
    notifyListeners();
  }

  int get totalFences => fences.length;

  // -------------------------------------------------------------------
  // ANSWER SELECTION
  // -------------------------------------------------------------------
  void selectAnswer(String value) {
    List<String> list = selections[currentFence];

    bool isR1Fence = r1SelectedForFence[currentFence];

    // -------------------------------
    // FIRST SELECTION
    // -------------------------------
    if (list.isEmpty) {
      list.add(value);

      if (value == "R1") {
        r1Used = true;
        r1SelectedForFence[currentFence] = true;
        isR1Fence = true;
      }
    }

    // -------------------------------
    // R1 FENCE LOGIC (SPECIAL)
    // -------------------------------
    else if (isR1Fence) {

      // If tap R1 again → IGNORE (R1 locked)
      if (value == "R1") {
        notifyListeners();
        return;
      }

      // If second not selected yet → add it
      if (list.length == 1) {
        list.add(value);
      }

      // If second already exists → REPLACE only the second
      else {
        list[1] = value;
      }
    }

    // -------------------------------
    // OTHER FENCES → ALWAYS replace
    // -------------------------------
    else {
      list
        ..clear()
        ..add(value);
    }

    answers[currentFence] = list.join(",");
    notifyListeners();
  }

  bool get allAnswered => !answers.contains(null);

  bool isLastFence() => currentFence == totalFences - 1;

  bool canGoNext(int index) {
    final list = selections[index];

    // R1 fence → must have 2 selections
    if (r1SelectedForFence[index]) {
      return list.length == 2;
    }

    // Normal fence → must have 1 selection
    return list.isNotEmpty;
  }

  void goNext() {
    if (answers[currentFence] == null) return;
    if (currentFence < totalFences - 1) {
      currentFence++;
      notifyListeners();
    }
  }

  void goBack() {
    if (currentFence > 0) {
      currentFence--;
      notifyListeners();
    }
  }

  // -------------------------------------------------------------------
  // PENALTY LOGIC (NEW)
  // PASS = 1
  // R1/R2/4 = 4
  // -------------------------------------------------------------------
  int get passPoints {
    int p = 0;

    for (var ans in answers) {
      if (ans == null) continue;

      // Split multi-selections: "R1,PASS"
      List<String> parts = ans.split(",");

      for (String a in parts) {
        if (a.trim() == "PASS") p += 1;   // PASS = +1
      }
    }
    return p;
  }

  // For display only — R1 count (optional)
  int get penaltyPoints {
    int p = 0;

    for (var ans in answers) {
      if (ans == null) continue;

      List<String> parts = ans.split(",");

      for (String a in parts) {
        if (a.trim() != "PASS") {
          p += 4;   // R1, R2, 4 etc = 4 each
        }
      }
    }
    return p;
  }

  // -------------------------------------------------------------------
  // RESULT PER FENCE
  // -------------------------------------------------------------------
  List<Map<String, dynamic>> getFenceResult() {
    List<Map<String, dynamic>> list = [];

    for (int i = 0; i < fences.length; i++) {
      final ans = answers[i];

      if (ans == null) continue;

      // Split in case of multi-answers (R1,PASS)
      List<String> parts = ans.split(",");

      // Convert PASS → P, others unchanged
      List<String> converted = parts.map((a) {
        a = a.trim();
        return a == "PASS" ? "P" : a;
      }).toList();

      final resultCode = converted.join(",");  // "R1,P"

      // PENALTY: sum individually
      int totalPenalty = 0;
      for (String a in parts) {
        a = a.trim();
        totalPenalty += (a == "PASS") ? 1 : 4;
      }

      list.add({
        "fence_id": fences[i].id,
        "result_code": resultCode,   // Example: "R1,P"
        "fault_penalty": totalPenalty,
      });
    }

    return list;
  }

  // -------------------------------------------------------------------
  // WITHDRAWN LOGIC
  // -------------------------------------------------------------------
  void withdrawn(BuildContext context, {required Function onYes}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Withdraw Rider?"),
        content: const Text("Do you want to withdraw?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onYes();
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // FINAL SCORE CONTROLLERS (UPDATED LOGIC)
  // -------------------------------------------------------------------
  final TextEditingController totalPointsController = TextEditingController();
  final TextEditingController totalR1Controller = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController timeAllowedController = TextEditingController();
  final TextEditingController timePenaltyController = TextEditingController();
  final TextEditingController totalPenaltyController = TextEditingController();

  int timeAllowed = 0; // <-- get from TotalPointsScreen

  // -------------------------------------------------------------------
  // SET TIME ALLOWED (from TotalPointsScreen)
  // -------------------------------------------------------------------
  void setTimeAllowed(int value) {
    timeAllowed = value;
    timeAllowedController.text = value.toString();
    notifyListeners();
  }

  // -------------------------------------------------------------------
  // INITIAL FILL CONTROLLERS
  // -------------------------------------------------------------------
  void fillFinalControllers() {
    totalPointsController.text = passPoints.toString();
    totalR1Controller.text = penaltyPoints.toString();
    totalPenaltyController.text = penaltyPoints.toString(); // initially same

    // LISTEN FOR TIME CHANGES FROM UI
    timeController.addListener(_calculateTimePenalty);
  }

  // -------------------------------------------------------------------
  // CALCULATE TIME PENALTY BASED ON TIME ALLOWED
  // -------------------------------------------------------------------
  void _calculateTimePenalty() {
    final actualTime = int.tryParse(timeController.text) ?? 0;

    if (actualTime <= 0) {
      timePenaltyController.text = "0";
      totalPenaltyController.text = penaltyPoints.toString();
      notifyListeners();
      return;
    }

    // SIMPLE LOGIC:
    // IF TIME TAKEN > TIME ALLOWED → TIME PENALTY = DIFFERENCE
    int penalty = 0;

    if (actualTime > timeAllowed) {
      penalty = actualTime - timeAllowed;
    }

    timePenaltyController.text = penalty.toString();

    // TOTAL PENALTY = fencePenalty + timePenalty
    totalPenaltyController.text = (penaltyPoints + penalty).toString();

    notifyListeners();
  }

  // -------------------------------------------------------------------
  // SUBMIT SCORE TO API
  // -------------------------------------------------------------------
  Future<void> submitFinalScore({
    required BuildContext context,
    required Ongoing event,
    required Category category,
    required AgeGroups ageGroup,
    required Participants participants,
    required String status,
  }) async {
    _setLoading(true, type: LoadingType.submitParticipants);

    final payload = {
      "event_id": event.id,
      "event_participant_id": participants.eventParticipantsId,
      "jumping_penalty": penaltyPoints.toString(),
      "time_seconds": timeController.text,
      "time_penalty": timePenaltyController.text,
      "total_penalty": totalPenaltyController.text,
      "status": status,
      "fences": getFenceResult(),
    };

    debugPrint("PAYLOAD : $payload");

    try {
      final res = await NetworkService.post(
        ApiEndpoints.submitFenceApiUrl(),
        payload,
      );

      if (res["status"] == true) {
        timeController.clear();
        AppConfig().showSnackBar(context, "Submitted Successfully!");
        NavigationHelper.push(
          context,
          ParticipantsListScreen(
            event: event,
            categories: category,
            ageGroups: ageGroup,
          ),
        );
      } else {
        AppConfig().showSnackBar(context, res["message"], isError: true);
      }
    } catch (e) {
      AppConfig().showSnackBar(context, "Error $e", isError: true);
    }

    _setLoading(false, type: LoadingType.submitParticipants);
  }
}
