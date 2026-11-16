
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :js) (:reload-fn 'app.main/reload!) (:target :browser)
      :feature-policy $ {}
      :modules $ [] |respo.calcit/ |respo-ui.calcit/
      :type-slots $ {} $ :dispatch-op 'app.schema/Action
  :files $ {}
    'app.comp.container $ %{} 'FileEntry
      :defs $ {}
        'comp-container $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-container ()
            div
              {} $ :style ui/global
              div
                {} $ :style $ merge ui/center
                  {} (:height 400) (:background-color "|hsl(200,80%,50%)") (:color :white)
                span
                  {} $ :style $ {} (:font-size 64) (:font-family "|Josefin Sans, sans-serif") (:font-weight 100)
                  <> "|MVC Works"
              div
                {} $ :style $ {} (:padding 40) (:font-size 16) (:font-family "|Hind, Arial,serif-sans")
                div
                  {} $ :style $ {} (:padding-bottom 40)
                  <> "|MVC is a insightful pattern for creating apps. In this organisation I'm exploring various of pieces trying to utilise the power of MVC pattern, and build tools and examples around MVC."
                list-> ({})
                  map-indexed projects $ fn (idx project)
                    [] idx $ comp-project project
              div
                {} $ :style $ {} (:padding "|16px 40px")
                <> "|Find mvc-works on "
                a
                  {} $ :href |https://github.com/mvc-works/
                  <> |GitHub.
          :examples $ []
          :schema $ quote $ Fn (-> respo.schema/Component)
        'comp-project $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-project (project)
            div
              {} $ :style $ merge ui/row
                {} (:background-color "|hsl(180,50%,96%)") (:margin-bottom 24) (:padding "|8px 16px")
              div
                {} $ :style $ {} (:width 160) (:font-size 18)
                a
                  {}
                    :href $ .unwrap-or (get project :url) |
                    :target |_blank
                  <> $ .unwrap-or (get project :name) |
              div
                {} $ :style $ {} (:color "|hsl(0,0%,50%)")
                <> $ .unwrap-or (get project :desc) |
          :examples $ []
          :schema $ quote $ Fn (Map Tag String) (-> respo.schema/Component)
        'projects $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def projects
            []
              {} (:name |Respo) (:url |https://github.com/Respo/respo) (:desc "|virtual DOM library built with ClojureScript")
              {} (:name "|Calcit Workflow") (:url |https://github.com/mvc-works/calcit-workflow)
                :desc "|App template based on ClojureScript, Respo, Cirru Editor... with support of hot code swapping."
              {} (:name "|File Sucker") (:url |https://github.com/mvc-works/file-sucker)
                :desc "|A simple tool for grabbing files from phone to laptop."
              {} (:name |shell-page) (:url |https://github.com/mvc-works/shell-page)
                :desc "|small library to generate index.html with configurations."
              {} (:name |webpack-hud) (:url |https://github.com/mvc-works/webpack-hud)
                :desc "|devtool to show webpack messages inside running webpage"
              {} (:name |Termina) (:url |https://github.com/mvc-works/termina) (:desc "|A toy process management tool.")
              {} (:name "|Fuzzy Filter") (:url |https://github.com/mvc-works/fuzzy-filter) (:desc "|fuzzy filtering library")
          :examples $ []
          :schema $ quote $ List (Map Tag String)
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require (respo-ui.core :as ui)
            respo.core :refer $ defcomp div span a <> list->
            respo.comp.space :refer $ =<
    'app.main $ %{} 'FileEntry
      :defs $ {}
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (action)
            match action $
              :noop
              , &unit
          :examples $ []
          :schema $ quote $ Fn schema/Action (-> Unit)
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! () (render-app!) &unit
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :io :js-ffi :state)
        'mount-target $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def mount-target
            .unwrap $ query-selector |.app
          :examples $ []
          :schema $ quote respo.dom/DomElement
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! ()
            if (nil? build-errors) (render-app!) (println build-errors)
            , &unit
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :io :js-ffi :state)
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! ()
            render-with! mount-target
              fn () $ comp-container
              , dispatch!
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :io :js-ffi :state)
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.main
          :require
            respo.core :refer $ render-with!
            respo.ffi.browser :refer $ query-selector
            app.comp.container :refer $ comp-container
            app.schema :as schema
            |./calcit.build-errors :default build-errors
    'app.schema $ %{} 'FileEntry
      :defs $ {} $ 'Action
        %{} 'CodeEntry (:doc |)
          :code $ quote $ defenum Action (:noop)
          :examples $ []
          :schema $ quote EnumDef
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.schema
