using Toybox.WatchUi as Ui;

class GarminQrcodeViewDelegate extends Ui.BehaviorDelegate {
  private var longPressTimer;
  private var isLongPressTriggered = false;
  private var longPressThreshold = 1000; // 1 second in milliseconds

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
      isLongPressTriggered = false;
      longPressTimer = new Timer.Timer();
      longPressTimer.start(method(:onLongPress), longPressThreshold, false);

      return true;
    }

    return false;
  }

  function onKeyReleased(keyEvent) {
    var key = keyEvent.getKey();

    if (key == WatchUi.KEY_UP) {
      if (longPressTimer != null) {
        longPressTimer.stop();
        longPressTimer = null;
      }
      if (!isLongPressTriggered) {
        handleKeyUpShortPress();
      }

      isLongPressTriggered = false;
      return true;
    }
    return false;
  }

  function handleKeyUpShortPress() {
    var view = Ui.getCurrentView()[0];
    if (view instanceof GarminQrcodeView) {
      view.updateQrcodeItem(-1);
    }
  }

  function onLongPress() {
    isLongPressTriggered = true;
    longPressTimer = null;

    System.println("KEY_UP long press detected!");
    handleKeyUpLongPress();
  }
  function handleKeyUpLongPress() {
    System.println("KEY_UP long press!");

    WatchUi.pushView(
      new WatchUi.Confirmation("Long Press Action?"),
      new MyConfirmationDelegate(),
      WatchUi.SLIDE_UP
    );
  }
}

class MyConfirmationDelegate extends Ui.ConfirmationDelegate {
  function initialize() {
    ConfirmationDelegate.initialize();
  }

  function onResponse(response) {
    if (response == WatchUi.CONFIRM_YES) {
      System.println("Long press action confirmed!");
      // Perform the confirmed action

      // [TODO] set to first page
    } else {
      System.println("Long press action cancelled");

      // [TODO] set to first page
    }

    // Pop the confirmation view
    WatchUi.popView(WatchUi.SLIDE_DOWN);

    return true;
  }
}
