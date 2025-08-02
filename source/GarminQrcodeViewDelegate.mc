using Toybox.WatchUi as Ui;

class GarminQrcodeViewDelegate extends Ui.BehaviorDelegate {
  function initialize() {
    BehaviorDelegate.initialize();
  }

  function onKeyPressed(keyEvent) {
    if (keyEvent.getKey() == Ui.KEY_DOWN) {
      var view = Ui.getCurrentView()[0];
      if (view instanceof GarminQrcodeView) {
        view.updateQrcodeItem(1);
      }
      return true;
    } else if (keyEvent.getKey() == Ui.KEY_UP) {
      var view = Ui.getCurrentView()[0];
      if (view instanceof GarminQrcodeView) {
        view.updateQrcodeItem(-1);
      }
      return true;
    }
    return false;
  }
}
