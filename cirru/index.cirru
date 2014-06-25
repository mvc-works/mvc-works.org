
doctype

html
  head
    title MVC.im
    meta (:charset utf-8)
    link (:rel stylesheet) (:href css/style.css)
    link (:rel icon) (:type image/png) (:href png/mvc.png)
    @if (@ inDev) $ @block
      link (:rel stylesheet) (:href css/dev.css)
      -- $ script (:src bower_components/react/react.js)
    @if (@ inBuild) $ @block
      link (:rel stylesheet) (:href css/build.css)
      -- $ script (:src //cdn.staticfile.org/react/0.10.0/react.min.js)
    script (:defer) (:src build/main.js)

  body
    #logo
      img
        :src png/mvc.png
    .page
      = "MVC.im shares a vision that MVC frameworks would one day "
      = "turn into design tools, that makes building apps a lot easier. "
      = "As we code, we see the entities of apps coming from imaginations. "
      = "At that time MVC would become a mean to connect ideas and daily lifes. "
      br
      br
      = "Don't stopping dreaming, but let's start building."
      br
      br
      = "As a current strategy, before such powerful tools is ready, "
      = "we would keep seeking and spreading new ideas on designing with code. "
      = "Yes, it could be the hard way, not that direct as Sketch app is. "
      = "But it's our idea on pushing the world towards a future "
      = "that would connect our dreams."