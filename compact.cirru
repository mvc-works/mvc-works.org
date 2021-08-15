
{} (:package |app)
  :configs $ {} (:init-fn |app.main/main!) (:reload-fn |app.main/reload!)
    :modules $ [] |respo.calcit/ |lilac/ |memof/ |respo-ui.calcit/ |respo-markdown.calcit/ |reel.calcit/
    :version |0.0.1
  :files $ {}
    |app.comp.container $ {}
      :ns $ quote
        ns app.comp.container $ :require
          [] respo-ui.core :refer $ [] hsl
          [] respo-ui.core :as ui
          [] respo.core :refer $ [] defcomp >> list-> <> div button textarea span a
          [] respo.comp.space :refer $ [] =<
          [] reel.comp.reel :refer $ [] comp-reel
      :defs $ {}
        |comp-container $ quote
          defcomp comp-container (reel)
            let
                store $ :store reel
                states $ :states store
              div
                {} $ :style (merge ui/global)
                div
                  {} $ :style
                    merge ui/center $ {} (:height 400)
                      :background-color $ hsl 200 80 50
                      :color :white
                  span
                    {} $ :style
                      {} (:font-size 64) (:font-family "|Josefin Sans, sans-serif") (:font-weight 100)
                    <> "|MVC Works"
                div
                  {} $ :style
                    {} (:padding 40) (:font-size 16) (:font-family "|Hind, Arial,serif-sans")
                  div
                    {} $ :style
                      {} $ :padding-bottom 40
                    <> "|MVC is a insightful pattern for creating apps. In this organisation I'm exploring various of pieces trying to utilise the power of MVC pattern, and build tools and examples around MVC."
                  list-> ({})
                    -> projects $ map-indexed
                      fn (idx project)
                        [] idx $ div
                          {} $ :style
                            merge ui/row $ {}
                              :background-color $ hsl 180 50 96
                              :margin-bottom 24
                              :padding "|8px 16px"
                          div
                            {} $ :style
                              {} (:width 160) (:font-size 18)
                            a
                              {}
                                :href $ :url project
                                :target |_blank
                              <> $ :name project
                          div
                            {} $ :style
                              {} $ :color (hsl 0 0 50)
                            <> $ :desc project
                div
                  {} $ :style
                    {} $ :padding "|16px 40px"
                  <> "|Find mvc-works on "
                  a
                    {} $ :href |https://github.com/mvc-works/
                    <> |GitHub.
                comp-reel (>> states :reel) reel $ {}
        |projects $ quote
          def projects $ []
            {} (:name |Respo) (:url |https://github.com/Respo/respo) (:desc "|virtual DOM library built with ClojureScript")
            {} (:name "|Calcit Workflow") (:url |https://github.com/mvc-works/calcit-workflow) (:desc "|App template based on ClojureScript, Respo, Cirru Editor... with support of hot code swapping.")
            {} (:name "|File Sucker") (:url |https://github.com/mvc-works/file-sucker) (:desc "|A simple tool for grabbing files from phone to laptop.")
            {} (:name |shell-page) (:url |https://github.com/mvc-works/shell-page) (:desc "|small library to generate index.html with configurations.")
            {} (:name |webpack-hud) (:url |https://github.com/mvc-works/webpack-hud) (:desc "|devtool to show webpack messages inside running webpage")
            {} (:name |Termina) (:url |https://github.com/mvc-works/termina) (:desc "|A toy process management tool.")
            {} (:name "|Fuzzy Filter") (:url |https://github.com/mvc-works/fuzzy-filter) (:desc "\"fuzzy filtering library")
    |app.schema $ {}
      :ns $ quote (ns app.schema)
      :defs $ {}
        |store $ quote
          def store $ {}
            :states $ {}
            :content |
    |app.updater $ {}
      :ns $ quote
        ns app.updater $ :require
          [] respo.cursor :refer $ [] update-states
      :defs $ {}
        |updater $ quote
          defn updater (store op op-data op-id op-time)
            case-default op
              do (println "\"Unknown op:" op) store
              :states $ update-states store op-data
              :content $ assoc store :content op-data
              :hydrate-storage op-data
    |app.main $ {}
      :ns $ quote
        ns app.main $ :require
          [] respo.core :refer $ [] render! clear-cache! realize-ssr!
          [] app.comp.container :refer $ [] comp-container
          [] app.updater :refer $ [] updater
          [] app.schema :as schema
          [] reel.util :refer $ [] listen-devtools!
          [] reel.core :refer $ [] reel-updater refresh-reel
          [] reel.schema :as reel-schema
          [] cljs.reader :refer $ [] read-string
          [] app.config :as config
          "\"./calcit.build-errors" :default build-errors
          "\"bottom-tip" :default hud!
      :defs $ {}
        |render-app! $ quote
          defn render-app! () $ render! mount-target (comp-container @*reel) dispatch!
        |persist-storage! $ quote
          defn persist-storage! (? e)
            js/localStorage.setItem (:storage-key config/site)
              format-cirru-edn $ :store @*reel
        |mount-target $ quote
          def mount-target $ .querySelector js/document |.app
        |*reel $ quote
          defatom *reel $ -> reel-schema/reel (assoc :base schema/store) (assoc :store schema/store)
        |main! $ quote
          defn main! ()
            println "\"Running mode:" $ if config/dev? "\"dev" "\"release"
            if config/dev? $ load-console-formatter!
            render-app!
            add-watch *reel :changes $ fn (r p) (render-app!)
            listen-devtools! |a dispatch!
            js/window.addEventListener |beforeunload persist-storage!
            repeat! 60 persist-storage!
            let
                raw $ .getItem js/localStorage (:storage-key config/site)
              when (some? raw)
                dispatch! :hydrate-storage $ parse-cirru-edn raw
            println "|App started."
        |dispatch! $ quote
          defn dispatch! (op op-data) (; println |Dispatch: op)
            reset! *reel $ reel-updater updater @*reel op op-data
        |reload! $ quote
          defn reload! () $ if (nil? build-errors)
            do (remove-watch *reel :changes) (clear-cache!)
              add-watch *reel :changes $ fn (reel prev) (render-app!)
              reset! *reel $ refresh-reel @*reel schema/store updater
              hud! "\"ok~" "\"Ok"
            hud! "\"error" build-errors
        |repeat! $ quote
          defn repeat! (duration cb)
            js/setTimeout
              fn () (cb)
                repeat! (* 1000 duration) cb
              * 1000 duration
    |app.config $ {}
      :ns $ quote (ns app.config)
      :defs $ {}
        |cdn? $ quote
          def cdn? $ cond
              exists? js/window
              , false
            (exists? js/process) (= "\"true" js/process.env.cdn)
            :else false
        |dev? $ quote
          def dev? $ = "\"dev" (get-env "\"mode")
        |site $ quote
          def site $ {} (:dev-ui "\"http://localhost:8100/main.css") (:release-ui "\"http://cdn.tiye.me/favored-fonts/main.css") (:cdn-url "\"http://cdn.tiye.me/mvc-works-org/") (:title "\"MVC Works") (:icon "\"http://cdn.tiye.me/logo/mvc-works.png") (:storage-key "\"mvc-works-org")
