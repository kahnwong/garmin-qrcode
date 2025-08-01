using Toybox.WatchUi as Ui;
using Toybox.System;
using Toybox.Lang;
using Toybox.Graphics;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class GarminQrcodeView extends Ui.View {
  var image;

  var dataReady = false;
  var apiData = null; // Will store the parsed JSON data

  function initialize(image) {
    View.initialize();
  }

  function onLayout(dc) {
    setLayout(Rez.Layouts.MainLayout(dc));

    // dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
    // dc.drawText(
    //     w / 2,
    //     h / 2 + imgH / 2,
    //     Graphics.FONT_XTINY,
    //     "foo",
    //     Graphics.TEXT_JUSTIFY_CENTER
    // );
  }

  function onShow() {
    makeRequest();
  }

  function onUpdate(dc) {
    View.onUpdate(dc);

    var displayMessage = "Loading data...";
    if (dataReady) {
      if (apiData != null) {
        var title = apiData.get("title");
        if (title != null) {
          displayMessage = "Title: " + title;
        } else {
          displayMessage = "Data received, but no title.";
        }
      } else {
        displayMessage = "Error: Failed to fetch data.";
      }
    }

    // dc.drawText(
    //   30,
    //   30,
    //   Graphics.FONT_MEDIUM,
    //   "foo",
    //   Graphics.TEXT_JUSTIFY_CENTER
    // );

    if (image != null) {
      dc.drawBitmap(30, 65, image);
      // View.findDrawableById("title").setText("foo3");

      dc.drawText(30, 30, Gfx.FONT_XTINY, "foo", Graphics.TEXT_JUSTIFY_LEFT);
    }
  }

  function onHide() {}

  //////// fetch png
  function makeRequest() {
    var qrcodeImageUrl = App.Properties.getValue("qrcodeImageUrl");
    var apiKey = App.Properties.getValue("apiKey");

    Ui.requestUpdate();

    var size = 90;
    if (qrcodeImageUrl != null) {
      var options = {
        :method => Communications.HTTP_REQUEST_METHOD_GET,
        :headers => {},
        :maxWidth => size,
        :maxHeight => size,
        :dithering => Communications.IMAGE_DITHERING_NONE,
      };

      Communications.makeImageRequest(
        qrcodeImageUrl,
        {},
        options,
        method(:onReceive)
      );
    }
  }
  function onReceive(responseCode, data) {
    System.println("onreceive 0" + "start");

    if (responseCode == 200) {
      System.println(responseCode);
      System.println("onReceive");
      if (data != null) {
        System.println("data not null");

        // Application.Storage.setValue("IMAGE", data);
        image = data;
      }
    } else {
      System.println("Error: " + responseCode);
    }

    dataReady = true; // Mark data as received (or error processed)

    Ui.requestUpdate();

    // Ui.switchToView(
    //   new GarminTodotxtWidgetView(image),
    //   null,
    //   Ui.SLIDE_IMMEDIATE
    // );
  }
}
