import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig

myLayout = avoidStruts(spacing 5 $ tiled ||| Mirror tiled) |||
    noBorders (fullscreenFull Full)
    where
        tiled = Tall 1 (3/100) (1/2)

myMenu = "dmenu_run -fn '-xos4-terminus-medium-r-*-*-12-*-*-*-*-*-*-*' -sb '#dd1144' -nb '#000000'"

myLockscreen = "slimlock"

main = do
    xmonad $ defaultConfig
        { terminal = "roxterm"
        , normalBorderColor  = "#1a1a1a"
        , focusedBorderColor = "#dd1144"
        , workspaces = ["Angry","Bears","Chomp","Donks","Every","Friday"]
        , layoutHook = myLayout
        , manageHook = manageDocks
        , handleEventHook = fullscreenEventHook
        , focusFollowsMouse  = False
        }
        `additionalKeysP`
        [ ("M-<Space>", spawn myMenu)
        , ("M4-l", spawn myLockscreen)
        , ("M-C-<Space>", sendMessage NextLayout)
        ]