module Main exposing (main)

import Html exposing (..)


list : List number
list =
    [ 1, 2, 3 ]


head : List a -> Maybe a
head list_ =
    case list_ of
        x :: xs ->
            Just x

        [] ->
            Nothing


isEmpty : List a -> Bool
isEmpty list_ =
    head list_ == Nothing


case1 : List (Html msg)
case1 =
    if isEmpty list then
        [ div [] [ text "Empty list" ] ]

    else
        [ div [] [ text <| "Non empty list: " ++ Debug.toString list ]
        , div [] [ text <| "Head: " ++ Debug.toString (head list) ]
        ]


main : Html msg
main =
    div [] <|
        case1



-- ++ case2
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--


case2 : List (Html msg)
case2 =
    case nonEmptyfromList list of
        Just nonEmptyList ->
            [ br [] []
            , div [] [ text <| "Non empty list: " ++ Debug.toString nonEmptyList ]
            , div [] [ text <| "Head: " ++ Debug.toString (nonEmptyHead nonEmptyList) ]
            ]

        Nothing ->
            [ br [] []
            , div [] [ text "Empty list" ]
            ]


type Nonempty a
    = Nonempty a (List a)


nonEmptyHead : Nonempty a -> a
nonEmptyHead (Nonempty x xs) =
    x


nonEmptyfromList : List a -> Maybe (Nonempty a)
nonEmptyfromList ys =
    case ys of
        x :: xs ->
            Just (Nonempty x xs)

        _ ->
            Nothing
