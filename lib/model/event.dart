class EventList {
  final List<Event> events;

  EventList({
    this.events,
  });

  factory EventList.fromJson(List<dynamic> parsedJson) {

    List<Event> events = new List<Event>();
    events=parsedJson.map((i)=>Event.fromJson(i)).toList();
    return new EventList(
      events: events,
    );
  }
}


class Event{
  final int id;
  final String name;
  final String phoneNum;
  final String location;
  final String dateStart;
  final String dateEnd;
  final String time;
  Event({
    this.name,
    this.dateEnd,
    this.dateStart,
    this.id,
    this.location,
    this.phoneNum,
    this.time
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return new Event(
      name: json['name'],
      id: json['id'],
      location: json['location'],
      phoneNum: json['phoneNum'],
      time: json['time'],
      dateStart: json['dateStart'],
      dateEnd: json['dateEnd'],

    );
  }

}