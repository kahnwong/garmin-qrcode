using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.System;
using Toybox.Communications;

class GarminTodotxtWidgetApp extends App.AppBase {
  function initialize() {
    AppBase.initialize();
  }

  // onStart() is called on application start up
  function onStart(state) {}

  // onStop() is called when your application is exiting
  function onStop(state) {}

  // Return the initial view of your application here
  function getInitialView() {
    return [new GarminQrcodeView(), new GarminQrcodeViewDelegate()];
  }
}

////

using Toybox.WatchUi as Ui;
using Toybox.System;
using Toybox.Lang;
using Toybox.Graphics;

// Garmin Connect IQ SDK - View (GarminQrcodeView.mc)
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class GarminQrcodeView extends Ui.View {
  hidden var _message;

  function initialize() {
    View.initialize();
    _message = "Press Down Button";
  }

  // Load your resources here
  function onLayout(dc) {
    // No layout to load from resources, we'll draw everything manually
  }

  // Called when this View is brought to the foreground
  function onShow() {}

  // Update the view
  function onUpdate(dc) {
    // Clear the screen
    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
    dc.clear();

    // Set font and color
    dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    dc.drawText(
      dc.getWidth() / 2,
      dc.getHeight() / 2 - 20, // Adjust position for better centering
      Gfx.FONT_MEDIUM,
      _message,
      Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER
    );
  }

  // Called when this View is removed from the foreground
  function onHide() {}

  // Method to update the displayed message
  function updateMessage(newMessage) {
    _message = newMessage;
    Ui.requestUpdate(); // Request a redraw of the view
  }
}

// Garmin Connect IQ SDK - View Delegate (GarminQrcodeViewDelegate.mc)
using Toybox.WatchUi as Ui;

class GarminQrcodeViewDelegate extends Ui.BehaviorDelegate {
  function initialize() {
    BehaviorDelegate.initialize();
  }

  function onKeyPressed(keyEvent) {
    if (keyEvent.getKey() == Ui.KEY_DOWN) {
      // Get the current view instance
      var view = Ui.getCurrentView()[0];
      if (view instanceof GarminQrcodeView) {
        view.updateMessage("Down button pressed!");
      }
      return true; // Event handled
    }
    return false; // Event not handled
  }
}
