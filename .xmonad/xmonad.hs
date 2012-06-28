import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig

myLayout = avoidStruts(spacing 5 $ tiled ||| Mirror tiled) |||
    noBorders (fullscreenFull Full)
    where
        tiled = ResizableTall 1 (3/100) (1/2) []

myMenu = "dmenu_run -fn 'terminus-9'"
    ++ " -sb '#dd1144' -nb '#000000'"

myLockscreen = "slimlock"

main = do
    xmonad $ defaultConfig
        { terminal = "urxvtc"
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
        , ("M-z", sendMessage MirrorShrink)
        , ("M-a", sendMessage MirrorExpand)
        ]
