class EventsModel {
  bool? status;
  String? message;
  Data? data;

  EventsModel({this.status, this.message, this.data});

  EventsModel.fromJson(Map<String, dynamic> json) {
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
  MyEvents? myEvents;
  MyEvents? otherEvents;

  Data({this.myEvents, this.otherEvents});

  Data.fromJson(Map<String, dynamic> json) {
    myEvents = json['my_events'] != null
        ? MyEvents.fromJson(json['my_events'])
        : null;
    otherEvents = json['other_events'] != null
        ? MyEvents.fromJson(json['other_events'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (myEvents != null) {
      data['my_events'] = myEvents!.toJson();
    }
    if (otherEvents != null) {
      data['other_events'] = otherEvents!.toJson();
    }
    return data;
  }
}

class MyEvents {
  List<Ongoing>? upcoming;
  List<Ongoing>? ongoing;
  List<Ongoing>? completed;

  MyEvents({this.upcoming, this.ongoing, this.completed});

  MyEvents.fromJson(Map<String, dynamic> json) {
    if (json['upcoming'] != null) {
      upcoming = <Ongoing>[];
      json['upcoming'].forEach((v) {
        upcoming!.add(Ongoing.fromJson(v));
      });
    }
    if (json['ongoing'] != null) {
      ongoing = <Ongoing>[];
      json['ongoing'].forEach((v) {
        ongoing!.add(Ongoing.fromJson(v));
      });
    }
    if (json['completed'] != null) {
      completed = <Ongoing>[];
      json['completed'].forEach((v) {
        completed!.add(Ongoing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (upcoming != null) {
      data['upcoming'] = upcoming!.map((v) => v.toJson()).toList();
    }
    if (ongoing != null) {
      data['ongoing'] = ongoing!.map((v) => v.toJson()).toList();
    }
    if (completed != null) {
      data['completed'] = completed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ongoing {
  int? id;
  String? name;
  String? clubName;
  int? clubId;
  String? location;
  String? eventStartDate;
  String? eventEndDate;
  String? status;

  Ongoing(
      {this.id,
        this.name,
        this.clubName,
        this.clubId,
        this.location,
        this.eventStartDate,
        this.eventEndDate,
        this.status});

  Ongoing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString();
    clubName = json['club_name'].toString();
    clubId = json['club_id'];
    location = json['location'].toString();
    eventStartDate = json['event_start_date'].toString();
    eventEndDate = json['event_end_date'].toString();
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['club_name'] = clubName;
    data['club_id'] = clubId;
    data['location'] = location;
    data['event_start_date'] = eventStartDate;
    data['event_end_date'] = eventEndDate;
    data['status'] = status;
    return data;
  }
}