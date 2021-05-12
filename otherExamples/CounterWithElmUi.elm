module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html
import Html.Events


type alias Model =
    { count : Int }


initialModel : Model
initialModel =
    { count = 0 }


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }


buttonAttrs : List (Attribute msg)
buttonAttrs =
    [ Border.rounded 60
    , Background.color <| rgb 0 0 0
    , Font.color <| rgb 0.3 0.9 0.4
    , Font.size 30
    , padding 30
    ]


view : Model -> Html.Html Msg
view model =
    layout [ Background.color <| rgb255 18 147 216 ] <|
        column
            [ Background.color <| rgb 0.7 1 1
            , Border.rounded 60
            , padding 30
            , centerX
            , centerY
            , width (fill |> maximum 300)
            ]
            [ row [ spacing 20, width fill ]
                [ Input.button buttonAttrs
                    { label = text "+1"
                    , onPress = Just Increment
                    }
                , Input.button (alignRight :: buttonAttrs)
                    { label = text "-1"
                    , onPress = Just Decrement
                    }
                ]
            , el [ Font.size 200, centerX ] <|
                text <|
                    String.fromInt model.count
            ]
