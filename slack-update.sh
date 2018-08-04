#!/bin/bash
#
# Usage: chmod +x install_black.sh; ./install_black.sh
#
#get css
SLACK_PATH='/Applications/Slack.app/Contents/Resources'
CSS_PATH=$(pwd)'/css/raw/variants/ochin.css'

cp "$CSS_PATH" "$SLACK_PATH/black.css" || exit 1


#make slack load css
if ! grep 'filePath = "/Applications/Slack.app/Contents/Resources/black.css";' /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js  ; then
    echo 'installing css';
echo 'document.addEventListener("DOMContentLoaded", function() {
  var fs = require("fs"),
  filePath = "/Applications/Slack.app/Contents/Resources/black.css";
  fs.readFile(filePath, {encoding: "utf-8"}, function(err, data) {
    if (!err) {
      var css = document.createElement("style")
      css.innerText = data;
      document.getElementsByTagName("head")[0].appendChild(css);
    }
  })
});' >> /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js;
else echo 'css already installed';
fi

