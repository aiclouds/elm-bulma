
module Bulma.Layout exposing (..)

-- DOCS ------------------------------------------------------------------------

{-| 
# Table of Contents
- [Container](#container)
- [Level](#level)
- [Media](#media)
- [Hero](#hero)
- [Section](#section)
- [Footer](#footer)
- [Tile](#tile)

# Container
@docs Container
@docs container, fluidContainer
@docs widescreenContainer, fullHDContainer

# Level
@docs Level
@docs level, horizontalLevel
@docs centeredLevel

## Level Partition
@docs LevelPartition
@docs levelLeft, levelRight

## Level Item
@docs LevelItem
@docs levelItem, levelItemLink, levelItemText
@docs easyLevelItemWithHeading 

# Media Object
@docs Media
@docs media

## Media Object Partition
@docs MediaPartition 
@docs mediaContent
@docs mediaLeft, mediaRight

# Hero
@docs Hero, HeroModifiers, heroModifiers
@docs hero, easyHero

## Hero Partition
@docs HeroPartition 
@docs heroBody, heroFoot, heroHead

# Section
@docs Section, SectionSpacing
@docs section

# Footer
@docs Footer
@docs footer

# Tile
Learn more about tiled grids in the [official docs](http://bulma.io/documentation/grid/tiles/).

    myGrid : Html msg
    myGrid 
      = tileAncestor Auto []
        [ verticalTile Width8 []
          [ tile Auto []
            [ verticalTileParent Auto []
              [ tileChild Auto []
                [ text "I'm in the top-left corner!"
                ]
              , [ text "I'm on the middle-left edge!"
                ]
              ]
            , tileParent Auto []
              [ text "I'm a tile touching the top-middle edge!"
              ]
            ]
          , tileParent Auto []
            [ tileChild Auto []
              [ text "I'm taking up the bottom-left half of the grid!"
              ]
            ]
          ]
        , tileParent Auto []
          [ tileChild Auto []
            [ text "I'm a tall column taking up the entire right edge!"
            ]
          ]
        ]

@docs Tile
@docs tile
@docs tileAncestor, tileParent, tileChild
@docs verticalTile, verticalTileParent

-}

-- IMPORTS ---------------------------------------------------------------------

import Helpers exposing (..)

import BulmaClasses exposing (..)

import Bulma.Modifiers as Modifiers exposing (..)

import Html exposing ( Html, Attribute, div, p, text )
import Html.Attributes as Attr exposing ( class )


-- CONTAINER -------------------------------------------------------------------
   
{-| -}
type alias Container msg = Html msg

{-| A simple container to center your content horizontally.

    myContainer : Html msg
    myContainer
      = container []
        [ p []
          [ text "My container is centered on a desktop!"
          ]
        ]

Containers can be used in any context, but mostly as a direct child of:
- `navbar`
- `hero`
- `section`
- `footer`
-}
container : List (Attribute msg) -> List (Html msg) -> Container msg
container = node "div" [] [ bulma.feature.container ]

{-| If you don't want to have a maximum width, but want to keep the 24px margin on the left and right sides, `fluidContainer` is for you!

    myFluidContainer : Html msg
    myFluidContainer
      = container []
        [ p []
          [ text "My container will have a 24px gap on its left and right."
          ]
        [ p []
          [ text "This gap holds for all viewport sizes."
          ]
        ]
-}
fluidContainer : List (Attribute msg) -> List (Html msg) -> Container msg
fluidContainer = node "div" [] [ bulma.feature.container
                               , bulma.feature.sizing.isFluid
                               ]

{-| This container is full-width until the "widescreen" breakpoint.

    myWidescreenContainer : Html msg
    myWidescreenContainer
      = widescreenContainer []
        [ p [] [ text "This container fills the screen-width..." ]
        , p [] [ text "...until it hits the widescreen breakpoint." ]
        ]
-}
widescreenContainer : List (Attribute msg) -> List (Html msg) -> Container msg
widescreenContainer = node "div" [] [ bulma.feature.container
                                    , "is-widescreen"
                                      -- KLUDGE: add to BulmaClasses
                                    ]

{-| This container is full-width until the "fullHD" breakpoint.

    fullHDContainer : Html msg
    fullHDContainer
      = widescreenContainer []
        [ p [] [ text "This container fills the screen-width..." ]
        , p [] [ text "...until it hits the fullHD breakpoint." ]
        ]
-}
fullHDContainer : List (Attribute msg) -> List (Html msg) -> Container msg
fullHDContainer = node "div" [] [ bulma.feature.container
                                , "is-fullhd"
                                  -- KLUDGE: add to BulmaClasses
                                ]


-- LEVEL -----------------------------------------------------------------------

{-| -}
type alias Level msg = Html msg

{-|
    myLevel : Html msg
    myLevel
      = level []
        [ levelLeft []
          [ levelItem [] []
          , levelItem [] []
          , levelItem [] []
          ]
        , levelRight []
          [ levelItem [] []
          , levelItem [] []
          , levelItem [] []
          ]
        ]
-}
level : List (Attribute msg) -> List (LevelPartition msg) -> Level msg
level = node "nav" [] [ bulma.level.container ]

{-| -}
horizontalLevel : List (Attribute msg) -> List (LevelPartition msg) -> Level msg
horizontalLevel = node "nav" [] [ bulma.level.container
                                , bulma.level.mobile.isHorizontal
                                ]
{-|
    myLevel : Html msg
    myLevel
      = centeredLevel []
        [ levelItem [] []
        , levelItem [] []
        , levelItem [] []
        ]
-}
centeredLevel : List (Attribute msg) -> List (LevelItem msg) -> Level msg
centeredLevel = level


-- LEVEL PARTITONS --

{-| -}
type alias LevelPartition msg = Html msg

{-| -}
levelLeft : List (Attribute msg) -> List (LevelItem msg) -> LevelPartition msg
levelLeft = node "div" [] [ bulma.level.left ]

{-| -}
levelRight : List (Attribute msg) -> List (LevelItem msg) -> LevelPartition msg
levelRight = node "div" [] [ bulma.level.right ]

-- LEVEL ITEMS --

{-| -}
type alias LevelItem msg = Html msg

{-| -}
levelItem : List (Attribute msg) -> List (Html msg) -> LevelItem msg
levelItem = node "div" [] [ bulma.level.item ]

{-| -}
levelItemText : List (Attribute msg) -> List (Html msg) -> LevelItem msg
levelItemText = node "p" [] [ bulma.level.item ]

{-| -}
levelItemLink : List (Attribute msg) -> List (Html msg) -> LevelItem msg
levelItemLink = node "a" [] [ bulma.level.item ]

{-| -}
easyLevelItemWithHeading : List (Attribute msg) -> String -> String -> LevelItem msg
easyLevelItemWithHeading attrs heading title
  = levelItem attrs
    [ div []
      [ p [ class "heading" ] [ text heading ]
      , p [ class "title"   ] [ text title   ]
      ]
    ]


-- MEDIA OBJECT ----------------------------------------------------------------

{-| -}
type alias Media msg = Html msg

{-| 
    myMediaObject : Html msg
    myMediaObject
      = media []
        [ mediaLeft    [] []
        , mediaContent [] []
        , mediaRight   [] []
        ]
-}
media : List (Attribute msg) -> List (MediaPartition msg) -> Media msg
media = node "article" [] [ bulma.media.container ]

-- {-| -}
-- largeMedia : List (Attribute msg) -> List (MediaPartition msg) -> Media msg
-- largeMedia = node "article" [] [ bulma.media.container
--                                , bulma.media.size.isLarge
--                                ]

-- MEDIA PARTITION --

{-| -}
type alias MediaPartition msg = Html msg

{-| -}
mediaLeft : List (Attribute msg) -> List (Html msg) -> MediaPartition msg
mediaLeft = node "div" [] [ bulma.media.left ]

{-| -}
mediaContent : List (Attribute msg) -> List (Html msg) -> MediaPartition msg
mediaContent = node "div" [] [ bulma.media.content ]

{-| -}
mediaRight : List (Attribute msg) -> List (Html msg) -> MediaPartition msg
mediaRight = node "div" [] [ bulma.media.right ]


-- HERO ------------------------------------------------------------------------

{-| -}
type alias Hero msg = Html msg

{-| An imposing Hero banner to showcase something.

    import Bulma.Layout exposing (hero,heroBody,container)
    import Bulma.Elements exposing (TitleSize(H1,H2),title)

    myHero : Html msg
    myHero
      = hero myHeroModifiers []
        [ heroBody [] 
          [ container []
            [ title H1 [] [ text "Hero Title" ]
            , title H2 [] [ text "Hero Subtitle" ]
            ]
          ]
        ]
-}
hero : HeroModifiers -> List (Attribute msg) -> List (HeroPartition msg) -> Hero msg
hero {bold,size,color}
  = node "section" []
    [ bulma.hero.container
    , case bold of
        True  -> bulma.hero.style.isBold
        False -> ""
    , case size of
        Small  -> ""
        Standard -> bulma.hero.size.isMedium
        Medium -> bulma.hero.size.isLarge
        Large  -> bulma.hero.size.isFullheight
    , case color of
        Default -> ""
        White   -> bulma.hero.color.isWhite
        Black   -> bulma.hero.color.isBlack
        Light   -> bulma.hero.color.isLight
        Dark    -> bulma.hero.color.isDark
        Primary -> bulma.hero.color.isPrimary
        Link    -> "is-link"
        Info    -> bulma.hero.color.isInfo
        Success -> bulma.hero.color.isSuccess
        Warning -> bulma.hero.color.isWarning
        Danger  -> bulma.hero.color.isDanger
    ]

{-| The `hero` element with some added guard-rails.

    myHero : Html msg
    myHero
      = easyHero myHeroModifiers []
        { head = heroHead [] []
        , body = heroBody [] []
        , foot = heroFoot [] []
        }
-}
easyHero : HeroModifiers -> List (Attribute msg) -> { head : HeroPartition msg, body : HeroPartition msg, foot : HeroPartition msg } -> Hero msg
easyHero mods attrs {head,body,foot}
  = hero mods attrs [ head, body, foot ]


-- HERO MODIFIERS --

{-| -}
type alias HeroModifiers = { bold  : Bool
                           , size  : Size
                           , color : Color
                           }

{-| These are the stylistic defaults for `hero` containers.

    import Bulma.Modifiers exposing ( Size(Standard)
                                    , Color(Default)
                                    )

    -- Small    -> "is-small"
    -- Standard -> "is-medium"
    -- Medium   -> "is-large"
    -- Large    -> "is-fullheight"

    myHeroModifiers : HeroModifiers
    myHeroModifiers
      = { bold  = False
        , size  = Large
        , color = Default
        }
-}
heroModifiers : HeroModifiers
heroModifiers = { bold  = False
                , size  = Small
                , color = Default
                }

-- {-| -}
-- type HeroSize = Standard
--               | Medium
--               | Large
--               | FullHeight


-- HERO PARTITIONS --

{-| -}
type alias HeroPartition msg = Html msg

{-| -}
heroHead : List (Attribute msg) -> List (Html msg) -> HeroPartition msg
heroHead = node "div" [] [ bulma.hero.head ]

{-| -}
heroBody : List (Attribute msg) -> List (Html msg) -> HeroPartition msg
heroBody = node "div" [] [ bulma.hero.body ]

{-| -}
heroFoot : List (Attribute msg) -> List (Html msg) -> HeroPartition msg
heroFoot = node "div" [] [ bulma.hero.foot ]


-- SECTION ---------------------------------------------------------------------

{-| -}
type alias Section msg = Html msg

{-| Use sections as direct children of your top HTML element.

    view : Model -> Html msg
    view model
      = div []
        [ section NotSpaced []
          [ container []
            [ p [] [ text "Containers for your containers!" ]
            ]
          ]
        ]
-}
section : SectionSpacing -> List (Attribute msg) -> List (Html msg) -> Section msg
section spacing
  = node "section" []
    [ bulma.section.container
    , case spacing of
        NotSpaced  -> ""
        Spaced     -> bulma.section.spacing.isMedium
        VerySpaced -> bulma.section.spacing.isLarge
    ]

-- MODIFIERS --

{-| -}
type SectionSpacing = NotSpaced
                    | Spaced
                    | VerySpaced


-- FOOTER ----------------------------------------------------------------------

{-| -}
type alias Footer msg = Html msg

{-| A simple responsive footer which can include anything: lists, headings, columns, icons, buttons, etc.

    myFooter : Html msg
    myFooter
      = footer []
        [ container []
          [ content [ textCentered ]
            [ p [] 
              [ text "Ask your doctor if Bulma is right for you."
              ]
            ]
          ]
        ]

-}
footer : List (Attribute msg) -> List (Html msg) -> Footer msg
footer = node "footer" [] [ bulma.footer.container ]


-- TILES -----------------------------------------------------------------------

{-| -}
type alias Tile msg = Html msg

-- TODO: easyTiles

{-| This element is a plain tile container. 
It's best used as an intermediate tile in a 2D grid. 
You can also add "is-ancestor", "is-parent", "is-child", and "is-vertical" classes to to make a custom Bulma-grid implementation.
-}
tile : Width -> List (Attribute msg) -> List (Tile msg) -> Tile msg
tile width
  = node "div" []
    [ bulma.tile.container
    , case width of
        Auto    -> ""
        Width1  -> bulma.tile.width.is1
        Width2  -> bulma.tile.width.is2
        Width3  -> bulma.tile.width.is3
        Width4  -> bulma.tile.width.is4
        Width5  -> bulma.tile.width.is5
        Width6  -> bulma.tile.width.is6
        Width7  -> bulma.tile.width.is7
        Width8  -> bulma.tile.width.is8
        Width9  -> bulma.tile.width.is9
        Width10 -> bulma.tile.width.is10
        Width11 -> bulma.tile.width.is11
    ]

{-| If you want to stack tiles vertically, use a vertical tile!
-}
verticalTile : Width -> List (Attribute msg) -> List (Tile msg) -> Tile msg
verticalTile width
  = node "div" []
    [ bulma.tile.container
    , bulma.tile.orientation.isVertical
    , case width of
        Auto    -> ""
        Width1  -> bulma.tile.width.is1
        Width2  -> bulma.tile.width.is2
        Width3  -> bulma.tile.width.is3
        Width4  -> bulma.tile.width.is4
        Width5  -> bulma.tile.width.is5
        Width6  -> bulma.tile.width.is6
        Width7  -> bulma.tile.width.is7
        Width8  -> bulma.tile.width.is8
        Width9  -> bulma.tile.width.is9
        Width10 -> bulma.tile.width.is10
        Width11 -> bulma.tile.width.is11
    ]

{-| This should always be your outer-most tile.

    myGrid : Html msg
    myGrid
      = tileAncestor Auto []
        [ tileParent Width8 [] 
          [ tileChild Auto [] []
          , tileChild Auto [] []
          ]
        , verticalTileParent Width4 [] 
          [ tileChild Auto [] []
          , tileChild Auto [] []
          ]
        ]
-}
tileAncestor : Width -> List (Attribute msg) -> List (Tile msg) -> Html msg
tileAncestor width
  = node "div" []
    [ bulma.tile.container
    , bulma.tile.level.isAncestor
    , case width of
        Auto    -> ""
        Width1  -> bulma.tile.width.is1
        Width2  -> bulma.tile.width.is2
        Width3  -> bulma.tile.width.is3
        Width4  -> bulma.tile.width.is4
        Width5  -> bulma.tile.width.is5
        Width6  -> bulma.tile.width.is6
        Width7  -> bulma.tile.width.is7
        Width8  -> bulma.tile.width.is8
        Width9  -> bulma.tile.width.is9
        Width10 -> bulma.tile.width.is10
        Width11 -> bulma.tile.width.is11
    ]

{-| Your tile-children must always be accompanied by a parent!
-}
tileParent : Width -> List (Attribute msg) -> List (Tile msg) -> Tile msg
tileParent width
  = node "div" []
    [ bulma.tile.container
    , bulma.tile.level.isParent
    , case width of
        Auto    -> ""
        Width1  -> bulma.tile.width.is1
        Width2  -> bulma.tile.width.is2
        Width3  -> bulma.tile.width.is3
        Width4  -> bulma.tile.width.is4
        Width5  -> bulma.tile.width.is5
        Width6  -> bulma.tile.width.is6
        Width7  -> bulma.tile.width.is7
        Width8  -> bulma.tile.width.is8
        Width9  -> bulma.tile.width.is9
        Width10 -> bulma.tile.width.is10
        Width11 -> bulma.tile.width.is11
    ]

{-| Your tile-children must always be accompanied by a parent!
-}
verticalTileParent : Width -> List (Attribute msg) -> List (Tile msg) -> Tile msg
verticalTileParent width
  = node "div" []
    [ bulma.tile.container
    , bulma.tile.level.isParent
    , bulma.tile.orientation.isVertical
    , case width of
        Auto    -> ""
        Width1  -> bulma.tile.width.is1
        Width2  -> bulma.tile.width.is2
        Width3  -> bulma.tile.width.is3
        Width4  -> bulma.tile.width.is4
        Width5  -> bulma.tile.width.is5
        Width6  -> bulma.tile.width.is6
        Width7  -> bulma.tile.width.is7
        Width8  -> bulma.tile.width.is8
        Width9  -> bulma.tile.width.is9
        Width10 -> bulma.tile.width.is10
        Width11 -> bulma.tile.width.is11
    ]

{-| This tile holds your content! Its parent should always be `tileParent` or `verticalTileParent`.
-}
tileChild : Width -> List (Attribute msg) -> List (Html msg) -> Tile msg
tileChild width
  = node "div" []
    [ bulma.tile.container
    , bulma.tile.level.isChild
    , case width of
        Auto    -> ""
        Width1  -> bulma.tile.width.is1
        Width2  -> bulma.tile.width.is2
        Width3  -> bulma.tile.width.is3
        Width4  -> bulma.tile.width.is4
        Width5  -> bulma.tile.width.is5
        Width6  -> bulma.tile.width.is6
        Width7  -> bulma.tile.width.is7
        Width8  -> bulma.tile.width.is8
        Width9  -> bulma.tile.width.is9
        Width10 -> bulma.tile.width.is10
        Width11 -> bulma.tile.width.is11
    ]
