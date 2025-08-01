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
    // Expecting data to be an array of objects with 'id' and 'todo'
    var todos = [];
    if (data != null && data.size() > 0) {
      for (var i = 0; i < data.size(); ++i) {
        var item = data[i];
        todos.add(item.get("todo"));
      }
    }

    Ui.switchToView(new GarminQrcodeView(todos), null, Ui.SLIDE_IMMEDIATE);
  }
}
