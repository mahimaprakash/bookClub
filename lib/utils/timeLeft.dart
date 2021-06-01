class MyTimeLeft {
  List<String> timeLeft(DateTime due) {
    List<String> retVal = [];

    Duration _timeUntilDue = due.difference(DateTime.now());
    int _daysUntil = _timeUntilDue.inDays;
    int _hoursUntil = _timeUntilDue.inHours - (_daysUntil * 24);
    int _minUntil =
        _timeUntilDue.inMinutes - (_daysUntil * 24 * 60) - (_hoursUntil * 60);

    if (_daysUntil > 0) {
      retVal[0] = _daysUntil.toString() +
          " days\n" +
          _hoursUntil.toString() +
          " hours\n" +
          _minUntil.toString() +
          " mins";
    } else if (_hoursUntil > 0) {
      retVal[0] =
          _hoursUntil.toString() + " hours\n" + _minUntil.toString() + " mins";
    } else if (_minUntil > 0) {
      retVal[0] = _minUntil.toString() + " mins";
    } else {
      retVal[0] = "oops! error";
    }

    Duration _timeUntilReveal =
        due.subtract(Duration(days: 7)).difference(DateTime.now());
    int _daysUntilReveal = _timeUntilReveal.inDays;
    int _hoursUntilReveal = _timeUntilReveal.inHours - (_daysUntilReveal * 24);
    int _minUntilReveal = _timeUntilReveal.inMinutes -
        (_daysUntilReveal * 24 * 60) -
        (_hoursUntilReveal * 60);

    if (_daysUntil > 0) {
      retVal[1] = _daysUntilReveal.toString() +
          " days\n" +
          _hoursUntilReveal.toString() +
          " hours\n" +
          _minUntilReveal.toString() +
          " mins";
    } else if (_hoursUntilReveal > 0) {
      retVal[1] = _hoursUntilReveal.toString() +
          " hours\n" +
          _minUntilReveal.toString() +
          " mins";
    } else if (_minUntilReveal > 0) {
      retVal[1] = _minUntilReveal.toString() + " mins";
    } else {
      retVal[1] = "oops! error";
    }

    return retVal;
  }
}
