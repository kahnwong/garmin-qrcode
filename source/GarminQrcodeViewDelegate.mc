using Toybox.WatchUi as Ui;
using Toybox.Application.Storage;
using Toybox.Timer;

class GarminQrcodeViewDelegate extends Ui.BehaviorDelegate {
  hidden var _view;

  function initialize(view) {
    BehaviorDelegate.initialize();
    _view = view;
  }

  function onKey(keyEvent) {
    var key = keyEvent.getKey();

    if (key == Ui.KEY_DOWN) {
      _view.updateQrcodeItem(1);
      return true;
    } else if (key == Ui.KEY_UP) {
      _view.updateQrcodeItem(-1);
      return true;
    }

    return false;
  }
}
