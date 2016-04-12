module Demo.Page 
  ( demo, package, mds, mdl
  , fromMDL, fromMDS
  , body
  ) 
  where

import Html exposing (..)
import Html.Attributes exposing (href, class)
import Markdown

import Material.Grid exposing (..)
import Material.Style as Style exposing (styled, cs, css, attribute)
import Material.Button as Button
import Material.Color as Color
import Material.Icon as Icon


-- REFERENCES


demo : String -> (String, String)
demo url = 
  ( "Demo source", url )


package : String -> (String, String)
package url = 
  ( "Package documentation", url )
      

mds : String -> (String, String) 
mds url = 
  ( "Material Design Specification", url )
        
      
mdl : String -> (String, String)
mdl url = 
  ( "Material Design Lite documentation", url )


references : List (String, String) -> List Html
references links = 
  [ text "References" 
  , ul [] 
      ( links |> List.map (\(str, url) -> 
          li [] [ a [ href url ] [ text str ] ]
        )
      )
  ]


-- DOCUMENTATION QUOTES


from : String -> String -> String -> Html
from title url body = 
  div []
    [ text "From the "
    , a [ href url ] [ text title ] 
    , text ":"
    , Markdown.toHtml body
    ] 


fromMDL : String -> String -> Html 
fromMDL = 
  from "Material Design Lite documentation" 


fromMDS : String -> String -> Html
fromMDS = 
  from "Material Design Specification"


-- TITLES


title : String -> Html 
title t = 
  Style.styled Html.h1 
    [ Color.text Color.primary 
    --, cs "mdl-typography--display-4" 
    -- TODO. Typography module
    ]
    []
    [ text t ]


demoTitle : Html 
demoTitle = 
  Style.styled Html.h2
    [ Color.text Color.primary 
    ]
    []
    [ text "Example" ]

-- VIEW SOURCE BUTTON


addr : Signal.Address Button.Action
addr = (Signal.mailbox Button.Click).address


fab : String -> Html 
fab url = 
  Button.fab addr (Button.model False)
    [ css "position" "fixed"
    , css "right" "48px"
    , css "top" "72px"
    , css "z-index" "100"
    , Button.colored
    --, attribute (href srcUrl) 
    , attribute (Html.Attributes.attribute "onclick" ("alert('foo!');")) --("window.location.href = '" ++ srcUrl ++ "';") )
    ]
    [ Icon.i "link" ]


-- BODY 


body : String -> String -> Html -> List (String, String) -> List Html -> Html 
body t srcUrl contents links demo = 
  div []
    [ title t
    , grid [ noSpacing ]
       [ cell [ size All 6, size Phone 4 ] [ contents ]
       , cell 
           [ size All 5, offset Desktop 1, size Phone 4, align Top 
           , css "position" "relative" 
           ] 
           ( references <| ("Demo source", srcUrl) :: links )
       ]
    --, fab srcUrl
    -- TODO: buttons can't be links (yet)
    -- TODO: FAB placement.
    , demoTitle
    , Style.div 
      [ css "margin-bottom" "48px"
      --, css "margin-top" "48px"
        -- , Elevation.shadow 2 
      ]
    demo 
    ]



