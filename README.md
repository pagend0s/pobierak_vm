
# Pobierak

**Pobierak** is a Bash-based terminal wrapper for **yt-dlp** designed to simplify downloading music, videos, playlists, channels, and media lists from YouTube.

The script provides a menu-driven interface with predefined download options, automatic checks, language support, and helper functions for managing downloads more easily from the terminal.

## Features

- Download single YouTube links
- Download songs from links stored in a file
- Download full playlists
- Download full YouTube channels
- Download videos
- Download videos or music videos from a list
- Download both video and MP3 audio track
- Install or update yt-dlp
- Check yt-dlp version
- Check Pobierak version from GitHub
- Display update information and changelog
- Detect external USB drive as download target
- Fallback to the user home directory if USB is not available
- Optional yt-dlp error reporting mode
- Multi-language support
- Terminal dialog-based prompts

## Supported Languages

Pobierak supports external language files.

Currently planned/supported language files:

- `pl.sh` — Polish
- `en.sh` — English
- `de.sh` — German
- `tr.sh` — Turkish

The default language is stored in:

```text
resources/lang/default_lang
``
