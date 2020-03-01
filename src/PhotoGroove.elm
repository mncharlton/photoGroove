module PhotoGroove exposing (main)

import Array exposing (Array)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


urlPrefix : String
urlPrefix =
    "http://elm-in-action.com/"


type alias Model =
    { photos : List Photo
    , selectedURL : String
    }


type alias Msg =
    { description : String
    , data : String
    }


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ h1 [] [ text "Photo Groove" ]
        , button
            [ onClick { description = "ClickedSupriseMe", data = "" } ]
            [ text "Surprise Me!" ]
        , div [ id "thumbnails" ] (List.map (viewThumbnail model.selectedURL) model.photos)
        , img [ class "large", src (urlPrefix ++ "large/" ++ model.selectedURL) ] []
        ]


viewThumbnail : String -> Photo -> Html Msg
viewThumbnail selectedURL thumb =
    img
        [ src (urlPrefix ++ thumb.url)
        , classList [ ( "selected", selectedURL == thumb.url ) ]
        , onClick { description = "ClickedPhoto", data = thumb.url }
        ]
        []


type alias Photo =
    { url : String }


initialModel : Model
initialModel =
    { photos =
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ]
    , selectedURL = "1.jpeg"
    }


photoArray : Array Photo
photoArray =
    Array.fromList initialModel.photos


update : Msg -> Model -> Model
update msg model =
    case msg.description of
        "ClickedPhoto" ->
            { model | selectedURL = msg.data }

        "ClickedSupriseMe" ->
            { model | selectedURL = "2.jpeg" }

        _ ->
            model


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
