function iframeChange(){
  let fb = document.getElementById("feedback");
  let shim = document.getElementById("shim");
  let fbs = fb.style.marginTop;
  if (fbs === "-400px"){
    fb.style.marginTop = "-200px";
    shim.style.height = "300px";
  } else{
    fb.style.marginTop = "-400px";
    shim.style.height = "720px";
  }
 }
   options = {
     hls: {
      overrideNative: true
     },
     autoplay: true,
     muted: true,
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