class ParticipantsModel {
  bool? status;
  String? message;
  Data? data;

  ParticipantsModel({this.status, this.message, this.data});

  ParticipantsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'].toString();
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Participants>? participants;

  Data({this.participants});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(Participants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (participants != null) {
      data['participants'] = participants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Participants {
  int? eventParticipantsId;
  int? eventId;
  String? eventName;
  int? clubId;
  String? clubName;
  String? clubRegistrationNumber;
  int? categoryId;
  String? categoryName;
  int? riderId;
  String? riderName;
  String? riderDob;
  String? riderEfiId;
  String? riderGender;
  int? horseId;
  String? horseName;
  String? horseDob;
  String? horseEfiId;
  String? horseGender;
  String? horseColor;
  String? jumpingPenalty;
  String? timeSeconds;
  String? timePenalty;
  String? totalPenalty;
  String? finalRank;
  String? status;
  AgeGroups? ageGroups;

  Participants(
      {this.eventParticipantsId,
        this.eventId,
        this.eventName,
        this.clubId,
        this.clubName,
        this.clubRegistrationNumber,
        this.categoryId,
        this.categoryName,
        this.riderId,
        this.riderName,
        this.riderDob,
        this.riderEfiId,
        this.riderGender,
        this.horseId,
        this.horseName,
        this.horseDob,
        this.horseEfiId,
        this.horseGender,
        this.horseColor,
        this.jumpingPenalty,
        this.timeSeconds,
        this.timePenalty,
        this.totalPenalty,
        this.finalRank,
        this.status,
        this.ageGroups});

  Participants.fromJson(Map<String, dynamic> json) {
    eventParticipantsId = json['event_participant_id'];
    eventId = json['event_id'];
    eventName = json['event_name'].toString();
    clubId = json['club_id'];
    clubName = json['club_name'].toString();
    clubRegistrationNumber = json['club_registration_number'].toString();
    categoryId = json['category_id'];
    categoryName = json['category_name'].toString();
    riderId = json['rider_id'];
    riderName = json['rider_name'].toString();
    riderDob = json['rider_dob'].toString();
    riderEfiId = json['rider_efi_id'].toString();
    riderGender = json['rider_gender'].toString();
    horseId = json['horse_id'];
    horseName = json['horse_name'].toString();
    horseDob = json['horse_dob'].toString();
    horseEfiId = json['horse_efi_id'].toString();
    horseGender = json['horse_gender'].toString();
    horseColor = json['horse_color'].toString();
    jumpingPenalty = json['jumping_penalty'].toString();
    timeSeconds = json['time_seconds'].toString();
    timePenalty = json['time_penalty'].toString();
    totalPenalty = json['total_penalty'].toString();
    finalRank = json['final_rank'].toString();
    status = json['status'].toString();
    ageGroups = json['age_groups'] != null
        ? AgeGroups.fromJson(json['age_groups'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_participant_id'] = eventParticipantsId;
    data['event_id'] = eventId;
    data['event_name'] = eventName;
    data['club_id'] = clubId;
    data['club_name'] = clubName;
    data['club_registration_number'] = clubRegistrationNumber;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['rider_id'] = riderId;
    data['rider_name'] = riderName;
    data['rider_dob'] = riderDob;
    data['rider_efi_id'] = riderEfiId;
    data['rider_gender'] = riderGender;
    data['horse_id'] = horseId;
    data['horse_name'] = horseName;
    data['horse_dob'] = horseDob;
    data['horse_efi_id'] = horseEfiId;
    data['horse_gender'] = horseGender;
    data['horse_color'] = horseColor;
    data['jumping_penalty'] = jumpingPenalty;
    data['time_seconds'] = timeSeconds;
    data['time_penalty'] = timePenalty;
    data['total_penalty'] = totalPenalty;
    data['final_rank'] = finalRank;
    data['status'] = status;
    if (ageGroups != null) {
      data['age_groups'] = ageGroups!.toJson();
    }
    return data;
  }
}

class AgeGroups {
  int? ageGroupId;
  String? ageGroupName;
  String? maxPenalty;
  String? height;
  String? speed;
  String? length;
  String? timeAllowed;
  String? timeLimit;
  String? startTime;
  String? obstacle;
  String? efforts;
  String? courseWalk;
  String? ageGroupTable;
  List<Fences>? fences;

  AgeGroups(
      {this.ageGroupId,
        this.ageGroupName,
        this.maxPenalty,
        this.height,
        this.speed,
        this.length,
        this.timeAllowed,
        this.timeLimit,
        this.startTime,
        this.obstacle,
        this.efforts,
        this.courseWalk,
        this.ageGroupTable,
        this.fences});

  AgeGroups.fromJson(Map<String, dynamic> json) {
    ageGroupId = json['age_group_id'];
    ageGroupName = json['age_group_name'].toString();
    maxPenalty = json['max_penalty'].toString();
    height = json['height'].toString();
    speed = json['speed'].toString();
    length = json['length'].toString();
    timeAllowed = json['time_allowed'].toString();
    timeLimit = json['time_limit'].toString();
    startTime = json['start_time'].toString();
    obstacle = json['obstacle'].toString();
    efforts = json['efforts'].toString();
    courseWalk = json['course_walk'].toString();
    ageGroupTable = json['age_group_table'].toString();
    if (json['fences'] != null) {
      fences = <Fences>[];
      json['fences'].forEach((v) {
        fences!.add(Fences.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['age_group_id'] = ageGroupId;
    data['age_group_name'] = ageGroupName;
    data['max_penalty'] = maxPenalty;
    data['height'] = height;
    data['speed'] = speed;
    data['length'] = length;
    data['time_allowed'] = timeAllowed;
    data['time_limit'] = timeLimit;
    data['start_time'] = startTime;
    data['obstacle'] = obstacle;
    data['efforts'] = efforts;
    data['course_walk'] = courseWalk;
    data['age_group_table'] = ageGroupTable;
    if (fences != null) {
      data['fences'] = fences!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fences {
  int? id;
  String? name;
  String? resultCode;
  String? faultPenalty;
  String? notes;

  Fences({this.id, this.name, this.resultCode, this.faultPenalty, this.notes});

  Fences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString();
    resultCode = json['result_code'].toString();
    faultPenalty = json['fault_penalty'].toString();
    notes = json['notes'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['result_code'] = resultCode;
    data['fault_penalty'] = faultPenalty;
    data['notes'] = notes;
    return data;
  }
}
