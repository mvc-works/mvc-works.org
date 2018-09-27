
(ns app.comp.container
  (:require [hsl.core :refer [hsl]]
            [respo-ui.core :as ui]
            [respo.macros :refer [defcomp cursor-> list-> <> div button textarea span a]]
            [verbosely.core :refer [verbosely! log!]]
            [respo.comp.space :refer [=<]]
            [reel.comp.reel :refer [comp-reel]]))

(def projects
  [{:name "Respo",
    :url "https://github.com/Respo/respo",
    :desc "virtual DOM library built with ClojureScript"}
   {:name "Calcit Workflow",
    :url "https://github.com/mvc-works/calcit-workflow",
    :desc "App template based on ClojureScript, Respo, Cirru Editor... with support of hot code swapping."}
   {:name "File Sucker",
    :url "https://github.com/mvc-works/file-sucker",
    :desc "A simple tool for grabbing files from phone to laptop."}
   {:name "shell-page",
    :url "https://github.com/mvc-works/shell-page",
    :desc "small library to generate index.html with configurations."}
   {:name "verbosely",
    :url "https://github.com/mvc-works/verbosely",
    :desc "a macro for printing values of functions"}
   {:name "webpack-hud",
    :url "https://github.com/mvc-works/webpack-hud",
    :desc "devtool to show webpack messages inside running webpage"}
   {:name "Termina",
    :url "https://github.com/mvc-works/termina",
    :desc "A toy process management tool."}
   {:name "Fuzzy Filter",
    :url "https://github.com/mvc-works/fuzzy-filter",
    :desc "fuzzy filtering library"}])

(defcomp
 comp-container
 (reel)
 (let [store (:store reel), states (:states store)]
   (div
    {:style (merge ui/global)}
    (cursor-> :reel comp-reel states reel {})
    (div
     {:style (merge
              ui/center
              {:height 400, :background-color (hsl 200 80 50), :color :white})}
     (span
      {:style {:font-size 64, :font-family "Josefin Sans, sans-serif", :font-weight 100}}
      (<> "MVC Works")))
    (div
     {:style {:padding 40, :font-size 16, :font-family "Hind, Arial,serif-sans"}}
     (div
      {:style {:padding-bottom 40}}
      (<>
       "MVC is a insightful pattern for creating apps. In this organisation I'm exploring various of pieces trying to utilise the power of MVC pattern, and build tools and examples around MVC."))
     (list->
      :div
      {}
      (->> projects
           (map-indexed
            (fn [idx project]
              [idx
               (div
                {:style (merge
                         ui/row
                         {:background-color (hsl 180 50 96),
                          :margin-bottom 24,
                          :padding "8px 16px"})}
                (div
                 {:style {:width 160, :font-size 18}}
                 (a {:href (:url project), :target "_blank"} (<> (:name project))))
                (div {:style {:color (hsl 0 0 50)}} (<> (:desc project))))])))))
    (div
     {:style {:padding "16px 40px"}}
     (<> "Find mvc-works on ")
     (a {:href "https://github.com/mvc-works/"} (<> "GitHub."))))))
