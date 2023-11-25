import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String convertToPacificTime(String timeString) {
  initializeDateFormatting();
  final inputFormat = DateFormat('MM/dd - hh:mm a');

  try {
    final extractedTimeString = timeString.replaceAll(' EST', '');

    // Parse the extracted time string in Eastern Time
    final parsedDate = inputFormat.parse(extractedTimeString);
    final estTime = parsedDate.toLocal();

    // Define the time difference between EST and PST
    const int hoursDifference = 3;

    // Add the time difference to convert to Pacific Time
    final pacificTime = estTime.subtract(Duration(hours: hoursDifference));

    final outputFormat = DateFormat('MM/dd - hh:mm a zzz', 'en_US');
    return outputFormat.format(pacificTime) + ' PST';
  } catch (e) {
    // Return the original input if parsing fails
    return timeString;
  }
}
