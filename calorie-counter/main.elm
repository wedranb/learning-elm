module Main exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- model

type alias Model =
  { calories: Int
  , inputContent : Int
  , error : Maybe String
  }

initModel : Model
initModel =
  { calories = 0, inputContent = 0, error = Nothing }

-- update

type Msg = AddCalories 
    | Change String
    | Clear

update : Msg -> Model -> Model
update msg model =
  case msg of
    AddCalories ->
      { model 
        | calories =  model.calories + model.inputContent
        , inputContent = 0
      }

    Change newContent ->
      case String.toInt newContent of
        Ok input ->
          { model
              | inputContent = input
              , error = Nothing
          }

        Err err ->
          { model
            | inputContent = 0
            , error = Just err
          }
    
    Clear ->
      initModel

      
-- view

view : Model -> Html Msg
view model =
  div []
    [ h3 []
       [ text ("Total Calories: " ++ (toString model.calories)) ]
       , div [] [ text (Maybe.withDefault "" model.error) ]
       , input 
        [ type_ "text"
        , placeholder "Calories"
        , onInput Change
        , value
          ( if model.inputContent == 0 then
           ""
           else
             toString model.inputContent
          )
        ] []
      , button
        [ type_ "button"
        , onClick AddCalories
        ] [ text "Add" ]
    , button
        [ type_ "button"
        , onClick Clear
        ] [ text "Clear" ]
    ]

main =
 Html.beginnerProgram
  { model = initModel
  , view = view 
  , update = update
  }