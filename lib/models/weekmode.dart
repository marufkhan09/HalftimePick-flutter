class WeekModel {
  bool isSelected;
  List<DateTime> days;
  DateTime startDate;
  DateTime endDate;

  WeekModel({
    required this.isSelected,
    required this.days,
    required this.startDate,
    required this.endDate
  });
}
