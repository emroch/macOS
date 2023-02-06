#!/bin/sh
# Sets reasonable macOS defaults.
#
# Mostly from https://github.com/caarlos0/dotfiles
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# More from:
#    https://gist.github.com/brandonb927/3195465
#
# Run ./set-defaults.sh and you'll be good to go.
if [ "$(uname -s)" != "Darwin" ]; then
    exit 0
fi

set +e

disable_agent() {
    mv "$1" "$1_DISABLED" >/dev/null 2>&1 ||
        sudo mv "$1" "$1_DISABLED" >/dev/null 2>&1
}

unload_agent() {
    launchctl unload -w "$1" >/dev/null 2>&1
}

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `set-defaults` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
echo ""
echo "› General UI/UX:"
###############################################################################

echo "  › Set dark interface style"
defaults write -g AppleInterfaceStyle -string "Dark"sysf

echo "  › Set accent color"
defaults delete -g AppleAccentColor
# Possible values: Multicolor: undefined, Blue: 4, Purple: 5, Pink: 6,
#                  Red: 0, Orange: 1, Yellow: 2, Green: 3, Graphite: -1

echo "  › Set highlight color"
defaults delete -g AppleHighlightColor
# As of Ventura 13.2, the default values are:
#   undefined: accent color
#   "0.698039 0.843137 1.000000 Blue"
#   "0.968627 0.831373 1.000000 Purple"
#   "1.000000 0.749020 0.823529 Pink"
#   "1.000000 0.733333 0.721569 Red"
#   "1.000000 0.874510 0.701961 Orange"
#   "1.000000 0.937255 0.690196 Yellow"
#   "0.752941 0.964706 0.678431 Green"
#   "0.847059 0.847059 0.862745 Graphite"
#   "0.500000 0.500000 0.500000 Other"

# if [ -f /System/Library/Desktop Pictures/Catalina.heic ]; then
#     echo "  › Set dynamic desktop backgroud"
#     osascript -e 'tell application "Finder" to "/System/Library/Desktop Pictures/Catalina.heic"'
# fi

echo "  › Set sidebar icon size to medium"
defaults write -g NSTableViewDefaultSizeMode -int 2
# Possible value: Small: 1, Medium: 2, Large: 3

echo "  › Show scrollbars automatically"
defaults write -g AppleShowScrollBars -string "Automatic"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# echo "  › Use AirDrop over every interface"
# defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# echo "  › Disable the 'Are you sure you want to open this application?' dialog"
# defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "  › Enable menubar extras"
# defaults write com.apple.systemuiserver menuExtras -array \
#     "/System/Library/CoreServices/Menu Extras/Clock.menu" \
#     "/System/Library/CoreServices/Menu Extras/Battery.menu" \
#     "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
#     "/System/Library/CoreServices/Menu Extras/Displays.menu" \
#     "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
#     "/System/Library/CoreServices/Menu Extras/Volume.menu"
defaults write com.apple.controlcenter "NSStatusItem Visible AccessibilityShortcuts" -bool false;
defaults write com.apple.controlcenter "NSStatusItem Visible AirDrop" -bool false;
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true;
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool false;
defaults write com.apple.controlcenter "NSStatusItem Visible Clock" -bool true;
defaults write com.apple.controlcenter "NSStatusItem Visible Display" -bool false;
defaults write com.apple.controlcenter "NSStatusItem Visible FocusModes" -bool false;
defaults write com.apple.controlcenter "NSStatusItem Visible NowPlaying" -bool false;
defaults write com.apple.controlcenter "NSStatusItem Visible ScreenMirroring" -bool false;
defaults write com.apple.controlcenter "NSStatusItem Visible Sound" -bool true;
defaults write com.apple.controlcenter "NSStatusItem Visible StageManager" -bool false;
defaults write com.apple.controlcenter "NSStatusItem Visible UserSwitcher" -bool false;
defaults write com.apple.controlcenter "NSStatusItem Visible WiFi" -bool true;

echo "  › Show battery percent"
defaults write com.apple.menuextra.battery ShowPercent -bool true

echo "  › Hide date from clock (assumes iStat Menus is displaying time)"
defaults write com.apple.menuextra.clock ShowDate -int 2
# Possible values: When Space Allows: 0, Always: 1, Never: 2
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool false

echo "  › Disable helpviewer always on top"
defaults write com.apple.helpviewer DevMode -bool True

###############################################################################
echo ""
echo "› Dock, Dashboard, Mission Control:"
###############################################################################

echo "  › Set the icon size of Dock items to 43 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 43

echo "  › Disable magnification"
defaults write com.apple.dock magnification -bool false

echo "  › Double click title bar to zoom"
defaults write -g AppleActionOnDoubleClick -string "Maximize"
# Possible values: `Minimize`, `Maximize` (Zoom), `None`

echo "  › Don't minimize windows into application icon"
defaults write com.apple.dock minimize-to-application -bool false

echo "  › Animate opening applications from the Dock"
defaults write com.apple.dock launchanim -bool true

echo "  › Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true
# defaults write com.apple.dock autohide-delay -float 0
# defaults write com.apple.dock autohide-time-modifier -float 0

echo "  › Show indicators for open applications"
defaults write com.apple.dock show-process-indicators -bool true

echo "  › Don't show recents"
defaults write com.apple.dock show-recents -bool false

# echo "  › Disable Dashboard"
# defaults write com.apple.dashboard mcx-disabled -bool true

echo "  › Don't automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

echo "  › Don't switch spaces when opening an application"
defaults write -g AppleSpacesSwitchOnActivate -bool false

echo "  › Don't group windows by app"
defaults write com.apple.dock expose-group-apps -bool false

# echo "  › Speed up Mission Control animations"
# defaults write com.apple.dock expose-animation-duration -float 0.1

echo "  › Displays have separate spaces"
defaults write com.apple.spaces spans-displays -bool false

###############################################################################
echo ""
echo "› Mac App Store & Software Update:"
###############################################################################

# echo "  › Enable the automatic update check"
# defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
# defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# echo "  › Download newly available updates in background"
# defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# echo "  › Install System data files & security updates"
# defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

echo "  › Disable in-app ratings and reviews"
defaults write com.apple.AppStore InAppReviewEnabled -bool false

###############################################################################
echo ""
echo "› Trackpad, mouse, keyboard, Bluetooth:"
###############################################################################

echo "  › Enable full keyboard access for all controls"
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# echo "  › Use scroll gesture with the Ctrl (^) modifier key to zoom"
# defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
# defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

echo "  › Disable press-and-hold for keys in favor of key repeat"
defaults write -g ApplePressAndHoldEnabled -bool false

echo "  › Set a really fast key repeat"
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 30

echo "  › Set trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 0.6875
defaults write -g com.apple.mouse.scaling 1

echo "  › Set language and text formats"
defaults write NSGlobalDomain AppleLanguages -array "en"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"
defaults write NSGlobalDomain AppleMetricUnits -bool false

# echo "  › Turn off keyboard illumination when computer is not used for 5 minutes"
# defaults write com.apple.BezelServices kDimTime -int 10

echo "  › Enable text replacement almost everywhere"
defaults write -g WebAutomaticTextReplacementEnabled -bool true

echo "  › Disable auto-correct"
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

echo "  › Disable smart quotes and smart dashes as they're annoying when typing code"
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false

# ###############################################################################
# echo ""
# echo "› Energy Saver:"
# ###############################################################################

# echo "  › Wake on lid"
# sudo pmset -a lidwake 1

# echo "  › Set sleep timeout"
# sudo pmset -b sleep 10
# # "prevent computer from sleeping automatically when the display is off"
# sudo pmset -c sleep 0

# echo "  › Set screen timeout"
# sudo pmset -b displaysleep 10
# sudo pmset -c displaysleep 15

# echo "  › Put hard disks to sleep when possible"
# sudo pmset -a disksleep 10

# echo "  › Wake for network access"
# sudo pmset -a womp 1

# echo "  › Enable Power Nap on AC"
# sudo pmset -b powernap 0
# sudo pmset -c powernap 1

# echo "  › Dim display while on battery"
# sudo pmset -b lessbright 1

# echo "  › Enter standby after 3 hours / 24 hours (< vs > 30% battery)"
# sudo pmset -a standbydelayhigh 86400
# sudo pmset -a standbydelaylow 10800
# sudo pmset -a highstandbythreshold 30

# echo "  › When on UPS, shutdown at 10%"
# sudo pmset -u haltlevel 10

# ###############################################################################
# echo ""
# echo "› Display:"
# ###############################################################################

# echo "  › Require password immediately after sleep or screen saver begins"
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0

# echo "  › Enable font smoothing (subpixel antialiasing)"
# defaults write -g AppleFontSmoothing -int 1

# echo "  › Increase the window resize speed for Cocoa applications"
# defaults write -g NSWindowResizeTime -float 0.001


###############################################################################
echo ""
echo "› Finder:"
###############################################################################

echo "  › Set default Finder location"
defaults write com.apple.finder NewWindowTarget -string "PfDo"
defaults write com.apple.finder NewWindowTargetPath -string "file:///${HOME}/Documents/"

echo "  › Always open everything in Finder's list view"
defaults write com.apple.Finder FXPreferredGroupBy -string "None"
defaults write com.apple.Finder FXPreferredViewStyle -string "Nlsv"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`

echo "  › Show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo "  › Show path bar"
defaults write com.apple.finder ShowPathbar -bool true

# echo "  › Display full POSIX path as Finder window title"
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "  › Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "  › Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "  › Show external/removable drives on desktop"
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

echo "  › Sort folders first"
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstDesktop -bool true

echo "  › Show the ~/Library folder"
sudo chflags nohidden ~/Library

echo "  › Show the /Volumes folder"
sudo chflags nohidden /Volumes

echo "  › Avoid the creation of .DS_Store files on network or USB volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo "  › Expand save panel by default"
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true

echo "  › Save to disk by default, instead of iCloud"
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false

echo "  › Removing duplicates in the 'Open With' menu"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
    -kill -r -domain local -domain system -domain user

echo "  › Expand select File Info panes"
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

###############################################################################
echo ""
echo "› Photos:"
###############################################################################

echo "  › Disable Photos from starting when a device is plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# ###############################################################################
# echo ""
# echo "› Safari & Browsers:"
# ###############################################################################

# echo "  › Set home page"
# defaults write com.apple.Safari HomePage -string "https://www.apple.com/startpage/"

# echo "  › Show the full URL and website icons"
# defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
# defaults write com.apple.Safari ShowIconsInTabs -bool true

# echo "  › Always show tab bar"
# defaults write com.apple.Safari AlwaysShowTabBar -bool true

# echo "  › Use backspace to go back"
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# echo "  › Hide bookmark bar"
# defaults write com.apple.Safari ShowFavoritesBar -bool false

# echo "  › Change search to Contains instead of Starts With"
# defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# echo "  › Show develop menu"
# defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
# defaults write com.apple.Safari IncludeDevelopMenu -bool true
# defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
# defaults write -g WebKitDeveloperExtras -bool true

# echo "  › Configure AutoFill"
# defaults write com.apple.Safari AutoFillFromAddressBook -bool true
# defaults write com.apple.Safari AutoFillPasswords -bool false
# defaults write com.apple.Safari AutoFillCreditCardData -bool false
# defaults write com.apple.Safari AutoFillMiscellaneousForms -bool true

# echo "  › Misc Safari Settings"
# defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
# defaults write com.apple.Safari SearchProviderIdentifier -string "com.duckduckgo"

# echo "  › Disable the annoying backswipe in Chrome"
# defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

# echo "  › Use system print dialog in Chrome"
# defaults write com.google.Chrome DisablePrintPreview -bool true

# echo "  › Expand Chrome print dialog by default"
# defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true

###############################################################################
echo ""
echo "› Time Machine:"
###############################################################################

echo "  › Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

###############################################################################
echo ""
echo "› iTunes & Media:"
###############################################################################

if [ -z "$KEEP_ITUNES" ]; then
    echo "  › Disable iTunes helper"
    disable_agent /Applications/iTunes.app/Contents/MacOS/iTunesHelper.app
    echo "  › Prevent play button from launching iTunes"
    unload_agent /System/Library/LaunchAgents/com.apple.rcd.plist
fi

echo "  › Disable Spotify web helper"
disable_agent ~/Applications/Spotify.app/Contents/MacOS/SpotifyWebHelper


###############################################################################
echo ""
echo "› Kill related apps"
for app in "Activity Monitor" \
    "cfprefsd" \
    "Dock" \
    "Finder" \
    "Google Chrome" \
    "Safari" \
    "SystemUIServer" \
    "Photos"; do
    killall "$app" >/dev/null 2>&1
done

set -e
