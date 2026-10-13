# Changelog

## v1.3.1
- **Los Santos Customs works.** Driving in no longer leaves you stuck inside with no menu: the shop waited for a texture the game files don't include. A few labels in the shop may be blank.
- **Interact shows in vehicles too** when the game asks for it ("Press D-pad right to ...").
- **The app version shows** under the title on the start screen, in Settings and in the log. Please mention it when you report a problem.

## v1.3
- **No more freezes when a TV comes on.** The game waited forever for TV and cutscene videos the game files don't include (Franklin's aunt's house, Michael's house, the Complications intro). Those videos are now skipped.
- **The minimap shows the map** (it was blank in every earlier version, and in the browser version).
- **New start screen** with new artwork, a new app icon, and a matching Settings look.
- **Game files screen:**
  - The app finds your game anywhere in its folder, however deep, or in any folder you choose (even On My iPhone itself).
  - **Every game file is checked.** If something is missing or damaged, it names the file and the likely cause (usually unpacking stopped early for lack of storage). **Play anyway** if only a few files are off.
  - **Unpack in the app:** paste a direct link to your zip or rar, or pick the archive in Files. It unpacks as it downloads, so you need about 21 GB free, not double. Dropped connections resume.
  - **Download pages** ("tap Download to start") open in a built-in browser with ad and pop-up blocking; the app takes the download over by itself.
  - Downloads keep going while you look around the start screen, Settings or the controls layout.
- **Sandbox map choice:** GTA V, or the GTA VI test map that comes with the game files.
- **Controls:**
  - New buttons that show only when they apply: special ability (with its charge), detonate (sticky bombs placed), interact (when the game asks), zoom while aiming, and weapons inside a weapon wheel slot.
  - Radio: tap for the next station, hold and point at a station on the wheel. Controllers pick with the right stick.
  - Cars: tilt in the air with up/down on the stick.
  - Aircraft: throttle and rudder buttons instead of the hidden throttle lever.
  - Quick taps are no longer missed.
  - All new buttons can be moved in the controls layout editor, which has an Aircraft tab now.
- **Keyboard and mouse** (PC controls) when connected; touch controls hide when both are connected.
- **Apple Game Mode** turns on while you play.
- Changing graphics in the game's own pause menu can no longer stop the game from starting.
- Crash logs survive reopening the app several times before sending.

## v1.2.2
- New app icon.
- **Edit controls layout** (start screen or Settings): move, resize or hide every touch button, on foot and in vehicles.
- **Accept / Back buttons** on screens like Mission Failed, so you can retry without a controller.
- **Switch character** button in Story mode (hold, drag toward a character, release).
- The **phone stays up** when you get into a vehicle; Back closes it.
- Touch controls **hide while a game controller is connected** (setting, on by default).
- **Frame rate 30, 60 or Unlocked** (up to 120 Hz on ProMotion iPhones).
- Default camera look speed doubled.
- **Send log to the developer** in one tap; the log records memory and file-loading health every 10 seconds.
- README: "Get the most performance" guide (SideStore + GetMoreRam).

## v1.2.1
- Move your game folder into **Files › On My iPhone › GTA V Port** and the app finds it by itself.
- Picking the wrong folder now explains what to pick instead.
- Any folder above the game folder can be picked; folder picks are logged.

## v1.2
- **Build from your iPhone** with [5★ Port Builder](https://fivestarport.vercel.app), no computer needed.
- **Play from a folder on your iPhone**: no server, nothing streams while playing.
- New **Max** preset, every preset selectable, separate resolution setting that changes while playing.
- After a launch that runs out of memory, the next start explains it and lowers the settings.
- **Share log** in Settings.

## v1.1
- **Native Metal renderer**: about 2.2 to 2.6× the frame rate of v1.0 and about 700 MB less memory.
- **Story mode or Sandbox**.
- **Download all game files** to the phone (streaming route).

## v1.0
- First release: build the iPhone app from your own game files with GitHub Actions or a Mac, streaming the files from your computer over Tailscale.
