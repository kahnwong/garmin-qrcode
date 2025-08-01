using Toybox.Application as App;
using Toybox.Communications;
using Toybox.System;
using Toybox.WatchUi as Ui;

class GarminQrcodeApp extends App.AppBase {
  function initialize() {
    AppBase.initialize();
  }

  function onStart(state) {
    makeTitleRequest();
  }

  function onStop(state) {}

  function getInitialView() {
    return [new GarminQrcodeView([])];
  }

  // ------- fetch title -------
  function makeTitleRequest() {
    var apiEndpoint = App.Properties.getValue("qrcodeTitleUrl");
    var apiKey = App.Properties.getValue("apiKey");

    var params = null;
    var options = {
      :method => Communications.HTTP_REQUEST_METHOD_GET,
      :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
      :headers => { "X-API-Key" => apiKey },
    };

    Communications.makeWebRequest(
      apiEndpoint,
      params,
      options,
      method(:onTitleReceive)
    );
  }
  function onTitleReceive(responseCode, data) {
    var title ;
    if (data != null) {
      title =  [data.get("name")];  // on init it's an array, this is to prevent it from borking
    }

    Ui.switchToView(new GarminQrcodeView(title), null, Ui.SLIDE_IMMEDIATE);
  }
}
