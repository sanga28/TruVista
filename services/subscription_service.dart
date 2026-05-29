class SubscriptionService {

  static bool isPremium = false;
  static DateTime? expiryDate;

  /// Activate subscription (demo)
  static void activatePremium({int days = 7}) {
    isPremium = true;
    expiryDate = DateTime.now().add(Duration(days: days));
  }

  /// Check if valid
  static bool get isActive {
    if (!isPremium) return false;

    if (expiryDate == null) return false;

    if (DateTime.now().isAfter(expiryDate!)) {
      isPremium = false;
      return false;
    }

    return true;
  }
}