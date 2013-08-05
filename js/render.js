var system = require('system');
var page = require('webpage').create();

page.content = system.args[1];

var result = page.evaluate(function(){
  return document.documentElement.outerHTML;
});

console.log(result);

phantom.exit();