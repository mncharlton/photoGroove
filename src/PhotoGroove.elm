module PhotoGroove exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


urlPrefix : String
urlPrefix =
    "http://elm-in-action.com/"


view model =
    div [ class "content" ]
        [ h1 [] [ text "Photo Groove" ]
        , div [ id "thumbnails" ] (List.map (viewThumbnail model.selectedURL) model.photos)
        , img [ class "large", src (urlPrefix ++ "large/" ++ model.selectedURL) ] []
        ]


viewThumbnail selectedURL thumb =
    img
        [ src (urlPrefix ++ thumb.url)
        , classList [ ( "selected", selectedURL == thumb.url ) ]
        , onClick { description = "ClickedPhoto", data = thumb.url }
        ]
        []


initialModel : { photos : List { url : String }, selectedURL : String }
initialModel =
    { photos =
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ]
    , selectedURL = "1.jpeg"
    }


update msg model =
    if msg.description == "ClickedPhoto" then
        { model | selectedURL = msg.data }

    else
        model


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
