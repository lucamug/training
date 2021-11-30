module HttpCatExample exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }



-- MODEL


type Model
    = Failure Http.Error
    | Loading
    | Success String


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading, getRandomCatGif )



-- UPDATE


type Msg
    = MorePlease
    | GotGif (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MorePlease ->
            ( Loading, getRandomCatGif )

        GotGif result ->
            case result of
                Ok url ->
                    ( Success url, Cmd.none )

                Err error ->
                    ( Failure error, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ style "margin" "20px" ] <|
        case model of
            Failure error ->
                [ div [ style "margin" "20px 0" ] [ text ("I could not load a random cat because: " ++ Debug.toString error) ]
                , button [ onClick MorePlease ] [ text "Try Again!" ]
                ]

            Loading ->
                [ text "Loading..." ]

            Success url ->
                [ button
                    [ onClick MorePlease
                    , style "display" "block"
                    , style "margin" "20px 0"
                    ]
                    [ text "More cats please!" ]
                , img [ src url ] []
                ]



-- HTTP


getRandomCatGif : Cmd Msg
getRandomCatGif =
    Http.get
        -- { url = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=cat"
        -- { url = "https://example.com/"
        -- { url = "xxx"
        -- { url = ""
        { url = "https://"
        , expect = Http.expectJson GotGif gifDecoder
        }


gifDecoder : Json.Decode.Decoder String
gifDecoder =
    Json.Decode.field "data" (Json.Decode.field "images" (Json.Decode.field "original" (Json.Decode.field "url" Json.Decode.string)))
