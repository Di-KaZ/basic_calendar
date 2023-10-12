import 'package:calendar_basic/calendar_basic.dart';
import 'package:calendar_basic/src/event.dart';

/// SuperSet of [BasicCalendar] that implement a basic event system
class CalendarWithRdv extends BasicCalendar {
  CalendarWithRdv({DateTime? startDate}) : super(startDate: startDate);

  /// List of in Memory [Event] per day
  final Map<DateTime, List<Event>> _events = {};

  /// get all the event occuring at [currentDate]
  /// They are not order guarented
  List<Event> get currentDateEvents =>
      _events.containsKey(currentDate) ? _events[currentDate]! : [];

  /// Add an [Event] to the cache
  void addEvent(Event event) {
    final date = DateTime(event.date.year, event.date.month, event.date.day);

    if (_events.containsKey(date)) {
      _events[date] = _events[date]!..add(event);
    } else {
      _events[date] = [event];
    }
  }

  /// Remove an [Event] from the cache
  /// /!\ Silently fail if event is not found
  void removeEvent(Event event) {
    final date = DateTime(event.date.year, event.date.month, event.date.day);

    if (_events.containsKey(date)) {
      _events[date]!.removeWhere((element) => element.date == event.date);
    }
  }
}
