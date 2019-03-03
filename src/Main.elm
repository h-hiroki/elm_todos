module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- MAIN
main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }

-- MODEL
type alias Model =
    { input : String
    , todos : List String -- todoの内容
    }

init : Model
init =
    { input = ""
    , todos = []
    }

-- UPDATE
type Msg
    = Input String
    | Stock

update : Msg -> Model -> Model
update msg model =
    case msg of
        Input newInput ->
            { model | input = newInput }

        Stock ->
            { model
                | input = ""
                , todos = model.input :: model.todos
            }

-- VIEW
view : Model -> Html Msg
view model =
    div []
        [ Html.form [onSubmit Stock]
            [ input [ value model.input, onInput Input ] []
            , button
                [ disabled (String.length model.input < 1) ]
                [ text "Submit" ]
            ]
        , ul [] (List.map viewTodo model.todos)
        ]

viewTodo : String -> Html msg
viewTodo todo =
    li [] [ text todo ]
