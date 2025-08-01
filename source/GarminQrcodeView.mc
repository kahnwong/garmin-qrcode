using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi as Ui;

class GarminQrcodeView extends Ui.View {
  // api data
  var image;

  // rendering config
  var imageSize = 90;
  var titleLabel as Ui.Text?;

  // api request
  var dataReady = false;

  function initialize(image) {
    View.initialize();
  }

  function onLayout(dc) {
    setLayout(Rez.Layouts.MainLayout(dc));

    View.findDrawableById("title").setText("foo");
  }

  function onShow() {
    makeRequest();
  }

  function onUpdate(dc) {
    View.onUpdate(dc);

    if (image != null) {
      dc.drawBitmap(30, 65, image);
    }
  }

  function onHide() {}

  // ------- fetch png -------
  function makeRequest() {
    var qrcodeImageUrl = App.Properties.getValue("qrcodeImageUrl");
    var apiKey = App.Properties.getValue("apiKey");

    Ui.requestUpdate();

    if (qrcodeImageUrl != null) {
      var options = {
        :method => Communications.HTTP_REQUEST_METHOD_GET,
        :headers => {},
        :maxWidth => imageSize,
        :maxHeight => imageSize,
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
    if (responseCode == 200) {
      if (data != null) {
        image = data;
      }
    } else {
      System.println("Error: " + responseCode);
    }

    dataReady = true;
    Ui.requestUpdate();
  }
}
