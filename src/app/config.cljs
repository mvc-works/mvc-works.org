
(ns app.config (:require [app.util :refer [get-env!]]))

(def bundle-builds #{"release" "local-bundle"})

(def dev?
  (if (exists? js/window)
    (do ^boolean js/goog.DEBUG)
    (not (contains? bundle-builds (get-env! "mode")))))

(def site
  {:storage "mvc-works-org",
   :dev-ui "http://localhost:8100/main.css",
   :release-ui "http://cdn.tiye.me/favored-fonts/main.css",
   :cdn-url "http://cdn.tiye.me/mvc-works-org/",
   :cdn-folder "tiye.me:cdn/mvc-works-org",
   :title "MVC Works",
   :icon "http://cdn.tiye.me/logo/mvc-works.png",
   :upload-folder "tiye.me:repo/mvc-works/mvc-works.org/"})
