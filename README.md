# ⚡ fzf for Windows

Give your Windows Terminal a fuzzy-finding superpower! This quick setup brings [fzf](https://github.com/junegunn/fzf) to PowerShell 7, so you can jump to files, revisit commands, and complete paths without breaking your flow.

<img src="https://github.com/user-attachments/assets/6c4def79-be17-4668-b4f8-f27714cb67d8" alt="fzf searching for PowerToys in Windows Terminal">

## Your new shortcuts

Once installed, these shortcuts put fuzzy search right at your fingertips:

- **Ctrl+T** — find a file and drop its path straight into your command.
- **Ctrl+R** — search your command history and bring an old command back in seconds.
- **Tab** — fuzzy-complete paths and other suggestions.

## What the installer sets up

Run `Install-Fzf.ps1` to install `fzf` with WinGet and the `PSFzf` PowerShell module if they are not already present. It adds the shortcuts to your PowerShell 7 profile, and safely updates its marked section if you run it again.

## Before you start

- Windows with [WinGet](https://learn.microsoft.com/windows/package-manager/winget/) available (provided by App Installer).
- PowerShell 7.
- An internet connection to download the packages and module.

## Get started

Clone this repository, open PowerShell 7 in the repository folder, then run:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\Install-Fzf.ps1
```

The execution-policy change applies only to the current PowerShell process. The script installs `PSFzf` for your user and adds the integration to the PowerShell 7 profile under your Documents folder. It does not configure other PowerShell versions.

That’s it! When installation completes, open a fresh PowerShell 7 session in Windows Terminal and try **Ctrl+T**, **Ctrl+R**, or **Tab**.

## Quick fixes

- **WinGet is not installed:** Install or update **App Installer** from the Microsoft Store, then run the script again.
- **The shortcuts do not work:** Confirm that the Windows Terminal tab is running PowerShell 7, then open a new session so it loads the updated profile.
- **`fzf` is not found after installation:** Open a new PowerShell session to refresh the environment and rerun the installer if needed.

The script updates your PowerShell 7 profile integration—it does not change Windows Terminal settings. Happy searching!
