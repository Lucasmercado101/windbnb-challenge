module Main exposing (..)

import Browser
import Data exposing (Item, data)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import LogoSvg exposing (logo)
import Set exposing (Set)



-- MODEL


type alias Model =
    { location : String
    , guests :
        { adults : Int
        , children : Int
        }
    , isNavBarToggledOpen : Bool
    , isLocationMenuOpen : Bool
    , isGuestsMenuOpen : Bool
    }


init : Model
init =
    { location = "Helsinki, Finland"
    , guests =
        { adults = 0
        , children = 0
        }
    , isNavBarToggledOpen = False
    , isLocationMenuOpen = False
    , isGuestsMenuOpen = False
    }



-- UPDATE


type Msg
    = OpenNavBar
    | CloseNavBar
    | LocationChange String
    | OpenLocationFilterMenu
    | CloseLocationFilterMenu
    | OpenGuestsFilterMenu
    | CloseGuestsFilterMenu
    | AddAdult
    | RemoveAdult
    | AddChild
    | RemoveChild


update : Msg -> Model -> Model
update msg model =
    case msg of
        OpenNavBar ->
            { model | isNavBarToggledOpen = True }

        CloseNavBar ->
            { model | isNavBarToggledOpen = False, isLocationMenuOpen = False, isGuestsMenuOpen = False }

        LocationChange newLocation ->
            { model | location = newLocation, isLocationMenuOpen = False }

        OpenLocationFilterMenu ->
            { model | isLocationMenuOpen = True }

        CloseLocationFilterMenu ->
            { model | isLocationMenuOpen = False }

        OpenGuestsFilterMenu ->
            { model | isGuestsMenuOpen = True }

        CloseGuestsFilterMenu ->
            { model | isGuestsMenuOpen = False }

        RemoveAdult ->
            { model
                | guests =
                    { adults =
                        if model.guests.adults - 1 < 0 then
                            0

                        else
                            model.guests.adults - 1
                    , children = model.guests.children
                    }
            }

        AddAdult ->
            { model
                | guests =
                    { adults = model.guests.adults + 1
                    , children = model.guests.children
                    }
            }

        RemoveChild ->
            { model
                | guests =
                    { adults = model.guests.adults
                    , children =
                        if model.guests.children - 1 < 0 then
                            0

                        else
                            model.guests.children - 1
                    }
            }

        AddChild ->
            { model
                | guests =
                    { adults = model.guests.adults
                    , children = model.guests.children + 1
                    }
            }



-- VIEW


view : Model -> Html Msg
view model =
    main_ [ class "container" ]
        [ header []
            [ if model.isNavBarToggledOpen == True then
                openNavBar model

              else
                closedNavBar model
            ]
        , div [ class "row between stays-title" ]
            [ h2 [] [ text "Stays in Finland" ]
            , p [] [ text "12+ stays" ]
            ]
        , cardsGrid model
        ]


iff : Bool -> Html msg -> Html msg
iff cond html =
    if cond then
        html

    else
        text ""


cardsGrid : Model -> Html Msg
cardsGrid model =
    ul [ class "room-cards-grid-list" ]
        (List.map
            (\l ->
                li []
                    [ roomCard l
                    ]
            )
            data
        )


roomCard : Item -> Html Msg
roomCard roomData =
    let
        beds =
            String.fromInt (Maybe.withDefault 0 roomData.beds)

        roomType =
            if beds /= "0" then
                roomData.type_ ++ ". " ++ beds ++ " beds"

            else
                roomData.type_
    in
    div [ class "room-card" ]
        [ img [ src roomData.photo, class "room-card__image" ] []
        , div [ class "room-card-info" ]
            [ iff roomData.superHost
                (div
                    [ class "room-card-info__super-host" ]
                    [ text "Super Host" ]
                )
            , div [ class "room-card-info__details" ]
                [ div [ class "room-card-info__type faint-text" ]
                    [ text
                        roomType
                    ]
                , p [ class "room-card-info__rating" ]
                    [ span [ class "material-icons" ] [ text "star" ]
                    , text (String.fromFloat roomData.rating)
                    ]
                ]
            ]
        , p [ class "room-card__title" ] [ text roomData.title ]
        ]


closedNavBar : Model -> Html Msg
closedNavBar model =
    nav
        [ class "navbar navbar__closed"
        ]
        [ logo
        , smallNavActions model
        ]


smallNavActions : Model -> Html Msg
smallNavActions model =
    let
        thereAreGuests =
            (model.guests.adults + model.guests.children) > 0

        textClass =
            if thereAreGuests then
                ""

            else
                "faint-text"
    in
    div [ class "smallNavActions", onClick OpenNavBar ]
        [ p [] [ text model.location ]
        , p [ class ("boxed " ++ textClass) ]
            [ text
                (if thereAreGuests then
                    String.fromInt (model.guests.adults + model.guests.children) ++ " Guests"

                 else
                    "Add guests"
                )
            ]
        , span [ class "material-icons primary-color" ] [ text "search" ]
        ]


getLocations : List Item -> Set String
getLocations items =
    Set.fromList
        (List.map2
            (++)
            (List.map (\el -> el.city ++ ", ") items)
            (List.map .country items)
        )


filterOutLocation : List String -> String -> List String
filterOutLocation locations location =
    List.filter (\l -> l /= location) locations


locationView : String -> Html Msg
locationView place =
    div [ class "location" ]
        [ div [ class "location__left-content" ]
            [ span [ class "material-icons" ]
                [ text "place"
                ]
            , p [] [ text place ]
            ]
        , span [ class "material-icons" ]
            [ text "chevron_right" ]
        ]


locationFilterContainerView : Model -> Html Msg
locationFilterContainerView model =
    if model.isLocationMenuOpen then
        div [ class "filter-container" ]
            [ div [ onClick CloseLocationFilterMenu ]
                [ div [ class "between align-center" ]
                    [ div []
                        [ p [ class "filter-label" ] [ text "Location" ]
                        , p [] [ text model.location ]
                        ]
                    , span [ class "material-icons" ]
                        [ text "expand_less"
                        ]
                    ]
                , div [ class "filter-conter__content" ]
                    [ ul [ class "location-list" ]
                        (List.map
                            (\l ->
                                li
                                    [ class "location-list__item"
                                    , onClick (LocationChange l)
                                    ]
                                    [ locationView l
                                    ]
                            )
                            (filterOutLocation (Set.toList (getLocations data)) model.location)
                        )
                    ]
                ]
            ]

    else
        div [ class "filter-container", onClick OpenLocationFilterMenu ]
            [ div [ class "between align-center" ]
                [ div []
                    [ p [ class "filter-label" ] [ text "Location" ]
                    , p [] [ text model.location ]
                    ]
                , span [ class "material-icons" ]
                    [ text "expand_more"
                    ]
                ]
            ]


guestsFilterContainerView : Model -> Html Msg
guestsFilterContainerView model =
    let
        totalGuests =
            model.guests.children + model.guests.adults
    in
    if model.isGuestsMenuOpen then
        div [ class "filter-container" ]
            [ div [ onClick CloseGuestsFilterMenu ]
                [ div [ class "between align-center" ]
                    [ div []
                        [ p [ class "filter-label" ] [ text "Guests" ]
                        , p []
                            [ text
                                (if totalGuests > 0 then
                                    String.fromInt totalGuests

                                 else
                                    "Add guests"
                                )
                            ]
                        ]
                    , span [ class "material-icons" ]
                        [ text "expand_less"
                        ]
                    ]
                ]
            , div [ class "filter-container-content" ]
                [ p [ class "guests-sub-title" ] [ text "Adults" ]
                , p [ class "faint-text" ] [ text "Ages 13 or above" ]
                , div
                    [ class "guests-action-buttons" ]
                    [ button [ onClick RemoveAdult ]
                        [ span [ class "material-icons" ]
                            [ text "remove" ]
                        ]
                    , p [] [ text (String.fromInt model.guests.adults) ]
                    , button [ onClick AddAdult ]
                        [ span [ class "material-icons" ]
                            [ text "add" ]
                        ]
                    ]
                ]
            , div [ class "filter-container-content" ]
                [ p [ class "guests-sub-title" ] [ text "Children" ]
                , p [ class "faint-text" ] [ text "Ages 2 - 12" ]
                , div
                    [ class "guests-action-buttons" ]
                    [ button [ onClick RemoveChild ]
                        [ span [ class "material-icons" ]
                            [ text "remove" ]
                        ]
                    , p [] [ text (String.fromInt model.guests.children) ]
                    , button [ onClick AddChild ]
                        [ span [ class "material-icons" ]
                            [ text "add" ]
                        ]
                    ]
                ]
            ]

    else
        div [ class "filter-container", onClick OpenGuestsFilterMenu ]
            [ div [ class "between align-center" ]
                [ div []
                    [ p [ class "filter-label" ] [ text "Guests" ]
                    , p []
                        [ text
                            (if totalGuests > 0 then
                                String.fromInt totalGuests

                             else
                                "Add guests"
                            )
                        ]
                    ]
                , span [ class "material-icons" ]
                    [ text "expand_more"
                    ]
                ]
            ]


openNavBar : Model -> Html Msg
openNavBar model =
    nav
        [ class "navbar navbar__open"
        ]
        [ div [ class "navbar-top" ]
            [ p [ class "navbar-title" ] [ text "Edit your search" ]
            , button [ class "close-navbar-icon" ]
                [ span [ class "material-icons", onClick CloseNavBar ] [ text "close" ]
                ]
            ]
        , div [ class "filters-container" ]
            [ locationFilterContainerView model
            , div [ class "divider-horizontal" ] []
            , guestsFilterContainerView model
            ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }
