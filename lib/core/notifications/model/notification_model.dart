class NotificationModel{
  String _topic;
  Map<String,String> _data;


  NotificationModel(this._topic, this._data);

  Map<String, String> get data => _data;

  set data(Map<String, String> value) {
    _data = value;
  }

  String get topic => _topic;


  set topic(String value) {
    if(value.toString().isNotEmpty) {
      _topic = value;
    }
    else {
      _topic="No identified topics";
    }
  }

}