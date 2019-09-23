class ActionType<T> {
  T action;


  ActionType({this.action});

  @override
  String toString() {
    return '$runtimeType(${action?.runtimeType})';
  }
}

class VoidAction extends ActionType<void> {}
