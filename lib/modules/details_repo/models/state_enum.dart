enum StateStatus { closed, open, unknown }

extension StateToString on StateStatus {
  String get parseToString {
    switch (this) {
      case StateStatus.open:
        return 'Open';
      case StateStatus.closed:
        return 'Closed';
      default:
        return 'Unknown';
    }
  }
}

extension StringToState on String {
  StateStatus get parseToState {
    switch (this) {
      case 'open':
        return StateStatus.open;
      case 'closed':
        return StateStatus.closed;
      default:
        return StateStatus.unknown;
    }
  }
}