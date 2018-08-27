function iframeChange(){
  var fb = document.getElementById("feedback");
  var shim = document.getElementById("shim");
  var fbs = fb.style.marginTop;
  if (fbs === "-400px"){
    fb.style.marginTop = "-200px";
    shim.style.height = "300px";
  } else{
    fb.style.marginTop = "-400px";
    shim.style.height = "880px";
  }
 }
   options = {
     hls: {
      overrideNative: true
     },
     autoplay: false,
     muted: false,
     fluid: true,
     controls: true,
     playsinline:true,
     preload:"auto"
   }
   const video = videojs('player', options);
       video.src({
         src: 'http://%%SERVER_IP%%/hls/%%STREAM_NAME%%.m3u8',
         type: 'application/x-mpegURL'
       });
   var player = videojs(document.querySelector('#player'));
   var bpb = player.getChild('bigPlayButton');
   if (bpb) {
     bpb.hide();
     player.ready(function() {
       var promise = player.play();
       if (promise === undefined) {
         bpb.show();
       } else {
         promise.then(function() {
           bpb.show();
         }, function() {
           bpb.show();
         });
       }
     });
   }

// Warn non-Chrome/Firefox users
var parser = new UAParser();
// by default it takes ua string from current browser's window.navigator.userAgent
console.log(parser.getResult());
var result = parser.getResult();
var bn = result.browser.name;
if (bn != "Chrome" && bn != "Chromium" && bn != "Firefox"){
  var header = document.getElementById('header');
  header.insertAdjacentHTML('afterbegin', '<div class="alert alert-danger"><strong>'+bn+' Warning!</strong> Best viewed in Chrome or Firefox.</div>');
}