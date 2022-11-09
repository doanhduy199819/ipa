// ignore_for_file: file_names

class Helper {
  static String toFriendlyTime(DateTime date) {
    DateTime now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inMinutes <= 1) {
      return 'A minute ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 60 && difference.inHours < 2) {
      return 'An hour ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}