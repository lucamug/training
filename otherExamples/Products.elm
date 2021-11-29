module Main exposing (main)

import Browser
import Codec
import Element exposing (..)
import Element.Font as Font
import Html
import Http
import Process
import Task



-- MAIN TYPES


type alias Model =
    { httpRequest : HttpRequest }


type ProductId
    = ProductId String


type HttpRequest
    = NotRequested
    | Fetching
    | Failure String
    | Success (List Product)


type alias Product =
    { id : ProductId
    , name : String
    , description : String
    , stars : Int
    , price : Int
    , tag : String
    , bg : Int
    }


type alias Flags =
    ()



-- INIT


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { httpRequest = NotRequested }
    , Process.sleep 0 |> Task.perform (always Request)
    )


type Msg
    = Request
    | Response (Result Http.Error (List Product))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Request ->
            ( model
            , Http.get
                { url = "/products.json"
                , expect = Http.expectJson Response decoderListProducts
                }
            )

        Response response ->
            ( case response of
                Ok listProducts ->
                    { model | httpRequest = Success listProducts }

                Err error ->
                    { model | httpRequest = Failure <| httpErrorToString error }
            , Cmd.none
            )


codecProduct : Codec.Codec Product
codecProduct =
    Codec.object Product
        |> Codec.field "id" .id (Codec.map stringToProductId productIdToString Codec.string)
        |> Codec.field "name" .name Codec.string
        |> Codec.field "description" .description Codec.string
        |> Codec.field "stars" .stars Codec.int
        |> Codec.field "price" .price Codec.int
        |> Codec.field "tag" .tag Codec.string
        |> Codec.field "bg" .bg Codec.int
        |> Codec.buildObject


stringToProductId : String -> ProductId
stringToProductId string =
    ProductId string


productIdToString : ProductId -> String
productIdToString (ProductId string) =
    string


decoderListProducts : Codec.Decoder (List Product)
decoderListProducts =
    Codec.decoder (Codec.list codecProduct)


httpErrorToString : Http.Error -> String
httpErrorToString error =
    case error of
        Http.BadUrl string ->
            "Bad URL " ++ string

        Http.Timeout ->
            "Timeout"

        Http.NetworkError ->
            "Network Error"

        Http.BadStatus status ->
            "Bad Status " ++ String.fromInt status

        Http.BadBody string ->
            string



-- VIEW


view : Model -> Html.Html msg
view model =
    layout [] <|
        column [ padding 30, spacing 30 ]
            [ el [ Font.size 30 ] <| text <| "Products"
            , column [ spacing 10 ] <|
                case model.httpRequest of
                    Success products ->
                        List.map
                            (\product ->
                                row [ spacing 40 ]
                                    [ image [ width <| px 100 ] { description = "", src = "https://training-assets.surge.sh/media/" ++ productIdToString product.id ++ ".png" }
                                    , text <| productIdToString product.id
                                    ]
                            )
                            products

                    _ ->
                        []
            ]



-- MAIN


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = \model -> { title = "Mini-Ichiba", body = [ view model ] }
        , update = update
        , subscriptions = \_ -> Sub.none
        }
