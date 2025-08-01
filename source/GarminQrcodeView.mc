using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi as Ui;

class GarminQrcodeView extends Ui.View {
  // api data
  var image;
  var _title;

  // rendering config
  var imageSize = 90;

  // api request
  var dataReady = false;

  function initialize(title) {
    View.initialize();
    _title = title;
  }

  function onLayout(dc) {
    setLayout(Rez.Layouts.MainLayout(dc));

    if (_title != null && _title.size() > 0) {
      View.findDrawableById("title").setText(_title[0]);
    }
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

    if (qrcodeImageUrl != null) {
      var options = {
        :method => Communications.HTTP_REQUEST_METHOD_GET,
        // :headers => { "X-API-Key" => apiKey }, // this doesn't work with `makeImageRequest`
        :maxWidth => imageSize,
        :maxHeight => imageSize,
        :dithering => Communications.IMAGE_DITHERING_NONE,
        :packingFormat => Communications.PACKING_FORMAT_PNG,
      };

      Communications.makeImageRequest(
        qrcodeImageUrl + "?apiKey=" + apiKey,
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
