using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi as Ui;

class GarminQrcodeView extends Ui.View {
  hidden var _pagenumber;
  hidden var _message;
  var _maxpage = 7;

  // api response
  var _title;
  var _image;

  function initialize() {
    View.initialize();
    _pagenumber = 1;
    _message = "Page: " + _pagenumber;

    makeTitleRequest(1);
    makeImageRequest(1);
  }

  function onLayout(dc) {}

  function onShow() {}

  function onUpdate(dc) {
    View.onUpdate(dc);

    // clear the screen
    dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
    dc.clear();

    // display content
    // -- pagination --
    dc.drawText(140, 80, Gfx.FONT_XTINY, _pagenumber, Gfx.TEXT_JUSTIFY_LEFT);
    dc.drawText(140, 100, Gfx.FONT_XTINY, "of", Gfx.TEXT_JUSTIFY_LEFT);
    dc.drawText(140, 120, Gfx.FONT_XTINY, _maxpage, Gfx.TEXT_JUSTIFY_LEFT);

    // -- content --
    if (_title != null) {
      dc.drawText(30, 30, Gfx.FONT_XTINY, _title, Gfx.TEXT_JUSTIFY_LEFT);
    }
    if (_image != null) {
      dc.drawBitmap(30, 65, _image);
    }
  }

  function onHide() {}

  function updateQrcodeItem(increment) {
    // set page number
    _pagenumber += increment;
    if (_pagenumber > _maxpage) {
      _pagenumber = 1;
    } else if (_pagenumber < 1) {
      _pagenumber = _maxpage;
    }
    _message = "Page: " + _pagenumber;
    System.println(_message);

    // fetch api response
    makeTitleRequest(_pagenumber);
    makeImageRequest(_pagenumber);

    // redraw
    Ui.requestUpdate();
  }

  // --------- api request: title ---------
  function makeTitleRequest(id) {
    var apiEndpoint = App.Properties.getValue("qrcodeTitleUrl");
    var apiKey = App.Properties.getValue("apiKey");
    // System.println(apiEndpoint);
    // System.println(apiKey);

    var params = null;
    var options = {
      :method => Communications.HTTP_REQUEST_METHOD_GET,
      :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
      :headers => { "X-API-Key" => apiKey },
    };

    System.println("Fetching title...");
    Communications.makeWebRequest(
      apiEndpoint + "/" + id,
      params,
      options,
      method(:onTitleReceive)
    );
  }
  function onTitleReceive(responseCode, data) {
    System.println("Fetching title: callback ...");
    if (data != null) {
      _title = data.get("name");
      // _title = _title + "foo" + _pagenumber; // debug
      Ui.requestUpdate();
    }
  }
  // --------- api request: qrcode ---------
  function makeImageRequest(id) {
    var qrcodeImageUrl = App.Properties.getValue("qrcodeImageUrl");
    var apiKey = App.Properties.getValue("apiImageGetKey");

    var imageSize = 90;
    if (qrcodeImageUrl != null) {
      var options = {
        :method => Communications.HTTP_REQUEST_METHOD_GET,
        // :headers => { "X-API-Key" => apiKey }, // this doesn't work with `makeImageRequest`
        :maxWidth => imageSize,
        :maxHeight => imageSize,
        :dithering => Communications.IMAGE_DITHERING_NONE,
        :packingFormat => Communications.PACKING_FORMAT_PNG,
      };

      System.println("Fetching image...");
      Communications.makeImageRequest(
        qrcodeImageUrl + "/" + id + "?apiKey=" + apiKey,
        {},
        options,
        method(:onImageReceive)
      );
    }
  }
  function onImageReceive(responseCode, data) {
    System.println("Fetching image: callback ...");
    if (responseCode == 200) {
      if (data != null) {
        _image = data;
      }
    } else {
      System.println("Fetching image: callback - error: " + responseCode);
    }

    Ui.requestUpdate();
  }
}
