enum VIEW {
  home,
  events,
  createEvent
}

extension ViewExtension on VIEW {
  String get toPath {
    switch (this) {
      case VIEW.home:
        return "/";
      case VIEW.events:
        return "/events";
      case VIEW.createEvent:
        return "/createEvent";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case VIEW.home:
        return "HOME";
      case VIEW.events:
        return "EVENTS";
      case VIEW.createEvent:
        return "CREATE_EVENT";
      default:
        return "HOME";
    }
  }

}