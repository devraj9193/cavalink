class ApiEndpoints {
  static const String baseUrl =
      "https://cavalink.in/api";

  static String loginApiUrl() => "$baseUrl/club_login";

  static String eventsApiUrl(int clubId) => "$baseUrl/getHorseEvents/$clubId";

  static String categoriesApiUrl(int eventId) =>
      "$baseUrl/getEventCategory/$eventId";

  static String participantsApiUrl(int eventId, int categoryId) =>
      "$baseUrl/getEventParticipants/$eventId/category/$categoryId";

  static String submitFenceApiUrl() => "$baseUrl/submitParticipantResult";
}
