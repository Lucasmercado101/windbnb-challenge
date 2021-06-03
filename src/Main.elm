module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)

import LogoSvg exposing (logo)
import Data exposing (data, Item)
import Html.Events exposing (onClick)
import Set exposing (Set)

-- MODEL

type alias Model = {
    location: String,
    guests: Int,
    isNavBarToggledOpen: Bool,
    isLocationMenuOpen: Bool
  }

init: Model
init = {
    location = "Helsinki, Finland",
    guests = 0,
    isNavBarToggledOpen = False,
    isLocationMenuOpen = False
  }

-- UPDATE

type Msg = OpenNavBar
  | CloseNavBar
  | LocationChange String
  | OpenLocationFilterMenu
  | CloseLocationFilterMenu

update : Msg -> Model -> Model
update msg model =
  case msg of
    OpenNavBar ->
      { model | isNavBarToggledOpen = True}

    CloseNavBar ->
      { model | isNavBarToggledOpen = False}

    LocationChange newLocation ->
      { model | location = newLocation, isLocationMenuOpen = False }
    
    OpenLocationFilterMenu ->
      { model | isLocationMenuOpen = True }

    CloseLocationFilterMenu ->
      { model | isLocationMenuOpen = False }

-- VIEW

view: Model -> Html Msg
view model = 
    main_ [ class "container" ] [
      header []
          [
              (if model.isNavBarToggledOpen == True then
                openNavBar model
              else
                closedNavBar model)
          ]
    ]

closedNavBar : Model -> Html Msg
closedNavBar model = 
    nav [
      class "navbar navbar__closed"
    ] [
        logo,
        smallNavActions model
    ]

smallNavActions : Model -> Html Msg
smallNavActions model = 
    let 
      thereAreGuests = model.guests > 0
      guests = 
        if thereAreGuests then
          String.fromInt model.guests
        else 
          "Add guests"
      textClass = 
        if thereAreGuests then
          ""
        else 
          "faint-text"
    in
    div [ class "smallNavActions", onClick OpenNavBar] [
      p [] [ text model.location ],
      p [ class ("boxed " ++ textClass) ] [ text guests ],
      span [ class "material-icons primary-color"] [ text "search" ]
    ]

getLocations : List Item -> Set String
getLocations items = 
    Set.fromList (List.map2 
    (++) 
    (List.map (\el -> el.city ++ ", ") items) 
    (List.map .country items))

filterOutLocation : List String -> String -> List String
filterOutLocation locations location =
  List.filter (\l -> l /= location) locations

locationView : String -> Html Msg
locationView place =
    div [ class "location" ] [
      div [ class "location__left-content"] [
        span [ class "material-icons" ] [
          text "place"
        ],
        p [] [ text place ]
      ],
      span [ class "material-icons" ]
        [ text "chevron_right" ]
    ]

locationFilterContainerView : Model -> Html Msg
locationFilterContainerView model = 
        if model.isLocationMenuOpen then
            div [ class "filter-container", onClick CloseLocationFilterMenu] [
              div [ class "between align-center" ] [
                div [] [
                  p [ class "filter-label" ] [ text "Location" ],
                  p [] [ text model.location ]
                ],
                span [ class "material-icons" ] [
                  text "expand_less"
                ]
              ],
                div [ class "filter-conter__content" ] [
                  ul [ class "location-list" ]
                      (
                        List.map (
                            \l -> 
                              li [
                                class "location-list__item",
                                onClick (LocationChange l)
                              ] [ 
                              locationView l
                              ]
                          ) (filterOutLocation (Set.toList (getLocations data)) model.location)
                      )
                ]
            ]
          else 
            div [ class "filter-container", onClick OpenLocationFilterMenu] [
              div [ class "between align-center" ] [
                div [] [
                  p [ class "filter-label" ] [ text "Location" ],
                  p [] [ text model.location ]
                ],
                span [ class "material-icons" ] [
                  text "expand_more"
                ]
              ]
            ]
            
openNavBar : Model -> Html Msg
openNavBar model = 
    nav [
      class "navbar navbar__open"
    ] [
        div [ class "navbar-top" ] [
           p [ class "navbar-title" ] [ text "Edit your search" ],
           button [ class "close-navbar-icon" ] [
             span [ class "material-icons", onClick CloseNavBar ] [ text "close" ]
           ]
        ],
        div [ class "filters-container" ] [
          locationFilterContainerView model,
          div [ class "divider-horizontal"] [],
          div [ class "filter-container"] [
            p [ class "filter-label" ] [ text "Guests" ],
            p [] [ 
              text (if model.guests > 0
                    then String.fromInt model.guests
                    else "Add guests"
                    ) 
              ]
          ]
        ]
    ]

main = Browser.sandbox { init = init, update = update, view = view }