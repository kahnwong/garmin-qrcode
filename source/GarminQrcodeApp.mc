using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.System;
using Toybox.Communications;

class GarminQrcodeApp extends App.AppBase {
  function initialize() {
    AppBase.initialize();
  }

  function onStart(state) {
    // makeRequest();
  }

  function onStop(state) {}

  function getInitialView() {
    return [new GarminQrcodeView([])];
  }
}
