<template>
<div>
  <title>Aliplayer Functions</title>
  <link rel="stylesheet" href="https://g.alicdn.com/de/prismplayer/2.9.3/skins/default/aliplayer-min.css" />
 
<div id="player-con"></div>
</div>
</template>
 <script type="text/javascript" charset="utf-8" src="https://g.alicdn.com/de/prismplayer/2.9.3/aliplayer-min.js"></script>
<script>
  var player = new Aliplayer({
    id: "player-con",
    source: "6 - What If I Want to Move Faster.mp4",
    width: "100%",
    height: "500px",
    cover: 'https://img.alicdn.com/tps/TB1EXIhOFXXXXcIaXXXXXXXXXXX-760-340.jpg',
    /* To set an album art, you must set 'autoplay' and 'preload' to 'false' */
    autoplay: false,
    preload: false,
    isLive: false
  }, function (player) {
    console.log("The player is created");
  });
</script>
</body>
</html>
