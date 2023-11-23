import 'package:calendar_basic/calendar_basic.dart';
import 'package:test/test.dart';

void main() {
  group('Calendar basics test', () {
    test('should create a calendar at today date', () {
      final calendar = BasicCalendar();
      expect(calendar.currentDate.year, DateTime.now().year);
      expect(calendar.currentDate.month, DateTime.now().month);
      expect(calendar.currentDate.day, DateTime.now().day);
    });

    test('should create a calendar at given date', () {
      final specificDate = DateTime(1999, 1, 17);
      final calendar = BasicCalendar(startDate: specificDate);
      expect(calendar.currentDate, specificDate);
    });

    test('should select the previous month', () {
      final calendar = BasicCalendar(startDate: DateTime(1999, 2, 17));
      calendar.selectPreviousMonth();
      expect(calendar.currentDate.month, 1);
    });

    test('should select the next month', () {
      final calendar = BasicCalendar(startDate: DateTime(1999, 4, 17));
      calendar.selectNextMonth();
      expect(calendar.currentDate.month, 5);
    });

    test('should select the next year', () {
      final calendar = BasicCalendar(startDate: DateTime(1999, 12, 17));
      calendar.selectNextMonth();
      expect(calendar.currentDate.month, 1);
      expect(calendar.currentDate.year, 2000);
    });

    test('should select the previous year', () {
      final calendar = BasicCalendar(startDate: DateTime(1999, 1, 17));
      calendar.selectPreviousMonth();
      expect(calendar.currentDate.month, 12);
      expect(calendar.currentDate.year, 1998);
    });

    test('january should contain 31 days', () {
      final calendar = BasicCalendar(startDate: DateTime(1999, 1, 17));
      expect(calendar.daysOfMonth.length, 31);
    });

    test('sould select the given day', () {
      final calendar = BasicCalendar(startDate: DateTime(1999, 1, 17));
      final givenDay = DateTime(2077, 5, 24);
      calendar.selectDate(givenDay);
      expect(calendar.currentDate, givenDay);
    });

    test('sould select the next day', () {
      final calendar = BasicCalendar(startDate: DateTime(1999, 1, 17));
      calendar.selectNextDay();
      expect(calendar.currentDate, DateTime(1999, 1, 18));
    });

    test('sould select the prev day', () {
      final calendar = BasicCalendar(startDate: DateTime(1999, 1, 17));
      calendar.selectPreviousDay();
      expect(calendar.currentDate, DateTime(1999, 1, 16));
    });
  });
}
