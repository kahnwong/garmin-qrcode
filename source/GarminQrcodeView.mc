using Toybox.WatchUi as Ui;
using Toybox.System;
using Toybox.Lang;
using Toybox.Graphics;
using Toybox.Application as App;

class GarminQrcodeView extends Ui.View {
  var image;

  var dataReady = false;
  var apiData = null; // Will store the parsed JSON data

  function initialize(image) {
    View.initialize();
  }

  function onLayout(dc) {
    setLayout(Rez.Layouts.MainLayout(dc));

    System.println("start");

    View.findDrawableById("row" + "1").setText("foo");

    // // qrcode
    // var w = dc.getWidth();
    // var h = dc.getHeight();

    View.findDrawableById("row" + "2").setText("foo2");
    // System.println(image);

    // if (image != null) {
    //   dc.drawBitmap(30, 30, image);
    //   View.findDrawableById("row" + "3").setText("foo3");
    // }

    // // footer
    // // var w = dc.getWidth();
    // // var h = dc.getHeight();

    // var i = _image as Ui.BitmapResource;
    // var imgW = 160;
    // var imgH = 160;
    // var x = w / 2 - imgW / 2;
    // var y = h / 2 - imgH / 2;
    // var f = Graphics.getFontHeight(Graphics.FONT_XTINY);

    // dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
    // dc.fillRectangle(0, 0, w, h);

    // dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    // dc.fillRectangle(x - 5, y - 5, imgW + 10, imgH + 10 + f);

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
    System.println("start");
    makeRequest();
    System.println("done");
  }

  function onUpdate(dc) {
    View.onUpdate(dc);

    var displayMessage = "Loading data...";
    if (dataReady) {
      if (apiData != null) {
        // Access and display the data
        // Example: If data is {"title": "My Post", "id": 1}
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

    // Draw the message based on the current state
    // dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_MEDIUM, displayMessage, Graphics.COLOR_WHITE, Graphics.TEXT_JUSTIFY_CENTER);
    dc.drawText(
      30,
      30,
      Graphics.FONT_MEDIUM,
      "foo",
      Graphics.TEXT_JUSTIFY_CENTER
    );

    if (image != null) {
      dc.drawBitmap(30, 30, image);
      View.findDrawableById("row" + "3").setText("foo3");
    }
  }

  function onHide() {}

  //////// fetch png
  function makeRequest() {
    var qrcodeImageUrl = App.Properties.getValue("qrcodeImageUrl");
    var apiKey = App.Properties.getValue("apiKey");

    Ui.requestUpdate();

    if (qrcodeImageUrl != null) {
      var options = {
        :method => Communications.HTTP_REQUEST_METHOD_GET,
        :headers => {},
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
