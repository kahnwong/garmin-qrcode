using Toybox.Application as App;
using Toybox.Communications;
using Toybox.System;
using Toybox.WatchUi as Ui;

class GarminQrcodeApp extends App.AppBase {
  function initialize() {
    AppBase.initialize();
  }

  function onStart(state) {}

  function onStop(state) {}

  function getInitialView() {
    return [new GarminQrcodeView([])];
  }
}
