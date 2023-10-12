import 'package:calendar_basic/calendar_basic.dart';
import 'package:calendar_basic/src/event.dart';

class CalendarWithRdv extends BasicCalendar {
  final Map<DateTime, List<Event>> _events = {};
}
