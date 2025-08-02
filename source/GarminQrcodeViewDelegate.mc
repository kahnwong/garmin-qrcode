using Toybox.WatchUi as Ui;
using Toybox.Application.Storage;
using Toybox.Timer;

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
      new SimpleConfirmationView(),
      new SimpleConfirmationDelegate(),
      WatchUi.SLIDE_UP
    );
  }
}

class SimpleConfirmationView extends Ui.View {
  function initialize() {
    View.initialize();
  }

  function onUpdate(dc) {
    dc.setColor(Ui.Graphics.COLOR_WHITE, Ui.Graphics.COLOR_BLACK);
    dc.clear();
    dc.drawText(
      dc.getWidth() / 2,
      dc.getHeight() / 2 - 30,
      Ui.Graphics.FONT_MEDIUM,
      "Cache this?",
      Ui.Graphics.TEXT_JUSTIFY_CENTER
    );
    dc.drawText(
      dc.getWidth() / 2,
      dc.getHeight() / 2 + 10,
      Ui.Graphics.FONT_SMALL,
      "UP = Yes, DOWN = No",
      Ui.Graphics.TEXT_JUSTIFY_CENTER
    );
  }
}

class SimpleConfirmationDelegate extends Ui.BehaviorDelegate {
  function initialize() {
    BehaviorDelegate.initialize();
  }

  function onKeyPressed(keyEvent) {
    var key = keyEvent.getKey();

    if (key == Ui.KEY_UP) {
      System.println("User confirmed");

      WatchUi.popView(WatchUi.SLIDE_DOWN);
      return true;
    } else if (key == Ui.KEY_DOWN) {
      System.println("User cancelled");

      WatchUi.popView(WatchUi.SLIDE_DOWN);
      return true;
    }

    return false;
  }
}
// Storage.setValue("myKey", myData);
// Storage.getValue("myKey");
// Storage.deleteValue("myKey");
