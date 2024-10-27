class WidgetsData {
  dynamic _widget;
  dynamic _value;

  WidgetsData(this._widget, this._value);

  dynamic get value => _value;

  set value(dynamic value) {
    _value = value;
  }

  dynamic get widget => _widget;

  set widget(dynamic value) {
    _widget = value;
  }
}
