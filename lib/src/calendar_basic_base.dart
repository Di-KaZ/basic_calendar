// TODO: Put public facing types in this file.

/// Basic class to help navigate a calendar
class BasicCalendar {
  DateTime _currentDate;

  BasicCalendar({
    DateTime? startDate,
  }) : _currentDate = startDate ?? DateTime.now();

  /// get all the days in the currently selected month
  Set<DateTime> get daysOfMonth {
    final startOfMonth = DateTime(_currentDate.year, _currentDate.month);
    final loopDate = startOfMonth;
    Set<DateTime> daysOfMonth = {};
    while (loopDate.month == startOfMonth.month) {
      daysOfMonth.add(loopDate);
      loopDate.add(const Duration(days: 1));
    }
    return daysOfMonth;
  }

  /// select a specific date
  void selectDate(DateTime date) {
    _currentDate = date;
  }

  /// select the previous month from the selected one
  /// it change year if needed
  void selectPreviousMonth() {
    final switchingYear = _currentDate.month == 1;
    final year = switchingYear ? _currentDate.year - 1 : _currentDate.year;
    final month = switchingYear ? _currentDate.month - 1 : 12;
    _currentDate = DateTime(year, month);
  }

  /// select the next month from the selected one
  /// it change year if needed
  void selectNextMonth() {
    final switchingYear = _currentDate.month == 12;
    final year = switchingYear ? _currentDate.year + 1 : _currentDate.year;
    final month = switchingYear ? _currentDate.month + 1 : 1;
    _currentDate = DateTime(year, month);
  }

  /// select prevous day from the selected one
  /// it change month and year if needed
  void selectPreviousDay() {
    _currentDate = _currentDate.subtract(const Duration(days: 1));
  }

  /// select next day from the selected one
  /// it change month and year if needed
  void selectNextDay() {
    _currentDate = _currentDate.add(const Duration(days: 1));
  }
}
