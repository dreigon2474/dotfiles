-- xmonad.hs
--

import XMonad
import Data.Monoid
import System.Exit
import Graphics.X11.ExtraTypes.XF86
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Layout.NoBorders
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Spacing
import XMonad.Hooks.DynamicLog
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Util.SpawnOnce

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- ColorScheme module (SET ONLY ONE!)
    -- Possible choice are:
    -- DoomOne
    -- Dracula
    -- GruvboxDark
    -- MonokaiPro
    -- Nord
    -- OceanicNext
    -- Palenight
    -- SolarizedDark
    -- TomorrowNight
import Colors.Dracula

-- The preferred terminal program
myTerminal = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
myBorderWidth   = 1

-- Set mod key to 'windows'
myModMask       = mod4Mask

-- Set workspaces
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = colorBack
myFocusedBorderColor = color15

-- Key bindings. Add, modify or remove key bindings here.
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch rofi powermenu
    , ((modm              , xK_b     ), spawn "/home/ayman/.config/rofi/powermenu/powermenu.sh")

    -- volume keys
    , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%")
    , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%")

    -- launch rofi search
    , ((modm,               xK_p     ), spawn "/home/ayman/.config/rofi/launchers/slate/launcher.sh")


    -- screenshot tool
    , ((modm .|. shiftMask, xK_s     ), spawn ("maim -s -u | xclip -selection clipboard -t image/png -i"))

    -- close focused window
    , ((modm .|. shiftMask, xK_q     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_c    ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo | xmessage -file -"))
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-- Mouse bindings: default actions bound to mouse events
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

-- Layouts
myLayout = avoidStruts (smartBorders tiled ||| Mirror tiled ||| noBorders Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

-- Window rules
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

-- Event handling
myEventHook = handleEventHook def <+> fullscreenEventHook

-- Startup hook
--
myStartupHook = spawn ("trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 5 --transparent true --tint 0x111111 --height 24")

-- Run xmonad with the settings specified
main = do
	-- Spawn xmobar on all monitors
	xmproc0 <- spawnPipe ("xmobar -x 0 /home/ayman/.config/xmobar/xmobar0/" ++ colorScheme ++ "-xmobarrc0")
	xmproc1 <- spawnPipe ("xmobar -x 1 /home/ayman/.config/xmobar/xmobar1/" ++ colorScheme ++ "-xmobarrc1")

	-- Run xmonad with settings in defaults structure
	xmonad $ docks $ ewmh $ def {
      -- simple stuff
        terminal           = myTerminal
        , focusFollowsMouse  = myFocusFollowsMouse
        , clickJustFocuses   = myClickJustFocuses



        , borderWidth        = myBorderWidth
        , modMask            = myModMask
        , workspaces         = myWorkspaces
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor

      -- key bindings
        , keys               = myKeys
        , mouseBindings      = myMouseBindings

      -- hooks, layouts
        , layoutHook         = spacingRaw False (Border 0 14 0 14) True (Border 14 0 14 0) True $ myLayout
        , manageHook         = myManageHook
        , handleEventHook    = myEventHook
        , logHook            = dynamicLogWithPP $ xmobarPP
              -- xmobar settings
              { ppOutput = \x -> hPutStrLn xmproc0 x   -- xmobar on monitor 1
                              >> hPutStrLn xmproc1 x   -- xmobar on monitor 2
                -- Current workspace
              , ppCurrent = xmobarColor color06 "" . wrap
                           ("<box type=Top width=2 mt=2 color=" ++ color06 ++ ">") "</box>"
                -- Visible but not current workspace
              , ppVisible = xmobarColor color06 ""
                -- Hidden workspace
              , ppHidden = xmobarColor color05 "" . wrap
                           ("<box type=Top width=2 mt=2 color=" ++ color05 ++ ">") "</box>"
                -- Hidden workspaces (no windows)
              , ppHiddenNoWindows = xmobarColor color05 ""
                -- Title of active window
              , ppTitle = xmobarColor color16 "" . shorten 60
                -- Separator character
              , ppSep =  "<fc=" ++ color09 ++ "> <fn=1>|</fn> </fc>"
                -- Urgent workspace
              , ppUrgent = xmobarColor color02 "" . wrap "!" "!"
                -- order of things in xmobar
              , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
              }

        , startupHook        = myStartupHook
    }
