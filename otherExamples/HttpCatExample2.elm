module HttpCatExample2 exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html
import Http
import Json.Decode


type alias Model =
    { counter : Int
    , catStatus : CatStatus
    }


type CatStatus
    = NotRequested
    | Fetching
    | Error Http.Error
    | Success String


main : Program () Model Msg
main =
    Browser.element
        { init = \() -> ( { counter = 0, catStatus = NotRequested }, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment value ->
            ( { model | counter = model.counter + value }, Cmd.none )

        Decrement ->
            ( { model | counter = model.counter - 1 }, Cmd.none )

        Reset ->
            ( { model | counter = 0 }, Cmd.none )

        GotACat result ->
            case result of
                Ok string ->
                    ( { model | catStatus = Success string }, Cmd.none )

                Err err ->
                    ( { model | catStatus = Error err }, Cmd.none )

        GetACat ->
            ( { model | catStatus = Fetching }, getCat )


getCat : Cmd Msg
getCat =
    Http.get
        -- { url = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=cat"
        -- { url = "https://example.com/"
        { url = "cat.json"

        -- { url = "xxx"
        -- { url = ""
        -- { url = "https://elm-lang.org/assets/public-opinion.txt"
        , expect = Http.expectJson GotACat gifDecoder
        }


gifDecoder : Json.Decode.Decoder String
gifDecoder =
    Json.Decode.field "data"
        (Json.Decode.field "images"
            (Json.Decode.field "original"
                (Json.Decode.field "url"
                    Json.Decode.string
                )
            )
        )


type Msg
    = Increment Int
    | Decrement
    | Reset
    | GotACat (Result.Result Http.Error String)
    | GetACat


buttonAttrs : List (Attribute msg)
buttonAttrs =
    [ Border.width 1
    , Border.rounded 10
    , Border.color <| rgba 0 0 0 0.5
    , Background.color <| rgb 0.95 0.95 0.95
    , padding 10
    ]


view : Model -> Html.Html Msg
view model =
    layout []
        (column
            [ Element.width fill
            , Background.color (rgb 0.9 0.9 0.9)
            , padding 20
            , spacing 10

            -- , explain Debug.todo
            ]
            [ Input.button buttonAttrs { label = Element.text "Increment 7", onPress = Just (Increment 7) }
            , Input.button buttonAttrs { label = Element.text "Increment 8", onPress = Just (Increment 8) }
            , Input.button buttonAttrs { label = Element.text "Reset", onPress = Just Reset }
            , text (String.fromInt model.counter)
            , Input.button buttonAttrs { label = Element.text "Get a Cat", onPress = Just GetACat }
            , case model.catStatus of
                Success string ->
                    image [] { description = "a cat", src = string }

                _ ->
                    text "No cat, sorry"
            , paragraph [] [ text <| Debug.toString model.catStatus ]
            ]
        )



-- <div style="color: red">
--     <button>Increment</button>
--     <div>0</div>
--     <button>Decrement</button>
-- </div>
