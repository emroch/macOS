# Configuring Apps on Fresh Install

## Essentials

### 1Password

First things first, 1Password stores the credentials for all of the other
accounts and applications, making it a logical first install. The brewfile
handles installing the application, we just have to sign in.

Launch 1Password and select "1Password Account". It may find an account already
on the Mac (not really sure how, must be an iCloud metadata file) and
pre-populate the account email and key. Just enter the master password and 2FA
code (kept in Duo, or ask a family member) and we're off.

1Password settings are not synced anywhere, so just configure to taste. It's
pretty straighforward. Don't forget to "Enable Spotlight and 3rd party app
integrations" to use Alfred.

<!-- ### Backup and Sync from Google

Not all applications have a convenient way to include their preferences in
version control, either through plists or userdefaults. Some, including iStat
Menus, Alfred, and BTT sync their data via Google Drive. Thus, we should set up
Google Drive before moving on.

I don't grant any permission to the application, other than automation for
system events. No folders from the Mac are synced to Google, and only the 'Apps'
folder is necessary to sync from Google. -->

### Maestral

Maestral is a lightweight Dropbox client that handles syncing without all the
annoyances of the actual app. This is primarily for syncing app preferences,
but any useful files can be set to sync as well.

Launch Maestral and select a location for the Dropbox sync folder, ie
`~/Dropbox (Maestral)`. Select the files/folders to sync and let 'er rip.

That's it!

### iTerm2

iTerm can set preferences using the `defaults` command. A list of non-default
options is saved in a spreadsheet in Dropbox, but ideally these would be taken
care of during dotfile install.

Two features are not handled automatically though: profiles and keybindings.
These are exportable from iTerm and a version is stored in the
`~/Dropbox (Maestral)/Apps/iTerm2` folder. Simply open the preferences and
select the import option.

Install shell integrations by selecting "iTerm2 > Install Shell Integration"
and follow the prompts.

Make iTerm the default terminal by selecting "iTerm2 > Make iTerm2 Default Term".

### Alfred

Alfred's Power Pack license is kept in 1Password. The only configuration that
should be necessary is to set the sync folder to `~/Dropbox (Maestral)/Apps/Alfred` and
the rest should be automatic.

### Bartender

On launch, Bartender will ask for permissions. I grant both and restart the app.
The license key is stored in 1Password. Be sure to enable launch at login.

For consistency, and for maximum functionality in the case that bartender or
another app fails to load, I try to keep as many of the menu bar icons enabled
on the system as possible (ie don't hide the system clock, wifi, bluetooth,
etc) even if they are replaced by another element (ie iStat Menus clock).
I simply set the redundant elements to "Always Hide".

To set the keyboard hotkeys, we need to disable the spotlight `⌥ ⌘ Space`
shortcut in System Preferences > Keyboard > Shortcuts > Spotlight. I then
configure the following hot keys:

- Show Hidden items: `⌥ ⌘ Space`
- Show full width: `⌃ ⌥ ⌘ Space`
- Show all menu bar items: `⌥ ⌘ A`
- Search menu bar items: `⌃ ⌥ ⌘ F`

For the applications configured here, I set the following conditions (in order
of menu bar position, right to left):

- Bartender
- Spotlight: Always Hide
- Battery: Always Hide
- iStat Menus battery: Always Show
- iStat Menus time: Always Show
- iStat Menus combined: Always Show
- Airport - Wifi: Always Show
- Little Snitch Agent: Always Show
- Volume: Always Show
- Bluetooth: Always Show
- Location Menu: Always Show
- Airplay Displays: Show
- Unclutter: Always Hide
- AdGuard for Safari: Hide
- 1Password: Hide
- Rectangle: Hide

### Little Snitch

Little Snitch is only partially installed by Homebrew. To complete the
installation, launch the app and follow the prompts.

Next, go through the onboarding and select "Silent Mode" (otherwise the popups
become overwhelming) and make sure both MacOS and iCloud services are checked.

The license key is in 1Password. Settings are not synced anywhere so configure
to taste. My baseline config is as follows:

- General tab:
  - All default
- Alert tab:
  - Rule Lifetime: Until Quit
  - Domain or Host: Full Hostname
  - Confirm connection alert automatically: selected
    - Allow connection attempts
    - After: 45 seconds
  - Confirm with Return and Escape: unselected
- Monitor tab:
  - Show data rates as numerical values: selected
  - Data rate units: Bits/s
  - Automatically update my location in the map: selected
- Security tab:
  - Allow Global Rule Editing: selected
- Advanced tab:
  - Mark new rules as unapproved: selected
  - Approve rules automatically: unselected
  - Berkley Packet Filter Monitoring
    - optional: this comes with a slight performance hit, and negligible
      security/privacy improvement, so it may not be worth enabling.

I also like to mimic a basic Pihole installation by adding Steven Black's hosts
lists, converted to Little Snitch rules by [Naveed
Najam](https://github.com/naveednajam/Little-Snitch---Rule-Groups/):
- Create a new rule group subscription with the following URL:
  [https://raw.githubusercontent.com/naveednajam/Little-Snitch---Rule-Groups/master/unified_hosts_base/sb_unified_hosts_base.lsrules](https://raw.githubusercontent.com/naveednajam/Little-Snitch---Rule-Groups/master/unified_hosts_base/sb_unified_hosts_base.lsrules)
- Disable new allow rules, set the update frequency, and select "Active"

## Fix-Ups

### iTerm and `vim`

iTerm and vim seem to be picky about their install, and I haven't quite worked
out how to do everything automatically. iTerm likes to reset the fonts used,
probably because the necessary font is not installed on first launch, and vim
(neovim) likes to skip installing the plugins.

To fix iTerm, set the non-ascii font to Meslo LG Nerd Font. If it's not
installed, run `p10k configure` within iTerm.

To fix vim, run `dot_update`, which should trigger the
`$DOTFILES/vim/install.sh` script to install the plugins and configure neovim's
preferences. If not, run the `install.sh` manually.

### QLStephen

This QuickLook generator allows previews of files without extensions, but it may
have issues with macOS permissions on install. From the [project's README](https://github.com/whomwah/qlstephen#permissions-quarantine):

1. run xattr -cr ~/Library/QuickLook/QLStephen.qlgenerator (sudo if needed)
2. run qlmanage -r
3. run qlmanage -r cache
4. Restart Finder by...
   - Restarting your computer
   - or holding down the option key and right click on Finder’s dock icon, then select “Relaunch” from the menu

## Nice-to-Haves

### iStat Menus

After registering the application with the license key from 1Password, the
settings may be imported from Dropbox. Select "File > Import Settings" and
choose the configuration.

The menu bar will have to be rearranged manually, I haven't found a way to
automate that.

### Rectangle

After granting permission, select the standard shortcuts. A JSON preferences
file is saved in `~/Dropbox (Maestral)/Apps/Rectangle`. Open Rectangle settings
and import.

## Optional

### Logitech Options

If using a Logitech keyboard/mouse, Logitech Options makes it much easier to
configure. Simply launch and log in. Paired devices should be picked up
automatically. If the settings did not carry over, restore from a backup via the
settings.

### DaisyDisk

Useful for examining disk usage. Registration key stored in 1Password.

### Unclutter

Files and Notes are stored in `Google Drive/Apps/Unclutter`. Be sure to select
"Launch on Startup".

### AdGuard for Safari

Launch the app to prompt the extension install. Enable the extensions and
desired content blockers. Be sure to enable "Launch at login".
