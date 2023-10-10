/// Navigate a himar calendar with *ease* !
class BasicCalendar {
  late DateTime _currentDate;

  BasicCalendar({
    /// Initial date for the calendar to start on
    /// If ignored will use [DateTime.now]
    DateTime? startDate,
  }) {
    if (startDate == null) {
      final now = DateTime.now();
      _currentDate = DateTime(now.year, now.month, now.day);
    } else {
      _currentDate = startDate;
    }
  }

  /// Retrieve all the day in the [currentDate] month ordered from 1..31
  Set<DateTime> get daysOfMonth {
    final startOfMonth = DateTime(_currentDate.year, _currentDate.month);
    DateTime loopDate = startOfMonth;
    Set<DateTime> daysOfMonth = {};
    while (loopDate.month == startOfMonth.month) {
      daysOfMonth.add(loopDate);
      loopDate = loopDate.add(const Duration(days: 1));
    }
    return daysOfMonth;
  }

  /// The currently selected date in this [BasicCalendar]
  DateTime get currentDate => _currentDate;

  /// Select the given date replacing [currentDate]
  void selectDate(DateTime date) {
    _currentDate = date;
  }

  /// Select the previous month from [currentDate] month
  /// Note: It __automagicly 🧙🏾__ change the year if needed
  void selectPreviousMonth() {
    final switchingYear = _currentDate.month == 1;
    final year = switchingYear ? _currentDate.year - 1 : _currentDate.year;
    final month = switchingYear ? 12 : _currentDate.month - 1;
    _currentDate = DateTime(year, month);
  }

  /// Select the next month from [currentDate] month
  /// Note: It __automagicly 🧙🏾__ change the year if needed
  void selectNextMonth() {
    final switchingYear = _currentDate.month == 12;
    final year = switchingYear ? _currentDate.year + 1 : _currentDate.year;
    final month = switchingYear ? 1 : _currentDate.month + 1;
    _currentDate = DateTime(year, month);
  }

  /// Select the prev day from [currentDate]
  /// Note: It __automagicly 🧙🏾__ change the year and month if needed
  void selectPreviousDay() {
    _currentDate = _currentDate.subtract(const Duration(days: 1));
  }

  /// Select the next day from [currentDate]
  /// Note: It __automagicly 🧙🏾__ change the year and month if needed
  void selectNextDay() {
    _currentDate = _currentDate.add(const Duration(days: 1));
  }
}
