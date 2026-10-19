# fzf for Windows

A small PowerShell setup script that brings [fzf](https://github.com/junegunn/fzf) fuzzy finding to Windows Terminal. Use familiar shortcuts to search files, command history, and more without leaving the command line.

<img src="https://github.com/user-attachments/assets/6c4def79-be17-4668-b4f8-f27714cb67d8" alt="fzf searching for PowerToys in Windows Terminal">

## What the installer does

`Install-Fzf.ps1`:

- Installs `fzf` using WinGet if it is not already installed.
- Installs the `PSFzf` PowerShell module for the current user if needed.
- Adds fzf key bindings to the PowerShell 7 profile:
  - **Ctrl+T** — find files and insert the selected path at the prompt.
  - **Ctrl+R** — search command history.
  - **Tab** — fuzzy completion.
- Updates its marked profile section on subsequent runs rather than adding duplicate sections.

## Requirements

- Windows with [WinGet](https://learn.microsoft.com/windows/package-manager/winget/) available (provided by App Installer).
- PowerShell 7.
- An internet connection to download the packages and module.

## Install

Clone this repository, open PowerShell 7 in the repository folder, and run:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\Install-Fzf.ps1
```

The execution-policy change applies only to the current PowerShell process. The script installs `PSFzf` for your user and adds the integration to the PowerShell 7 profile under your Documents folder. It does not configure other PowerShell versions.

When installation completes, open a new PowerShell 7 session in Windows Terminal and try **Ctrl+T**, **Ctrl+R**, or **Tab**.

## Troubleshooting

- **WinGet is not installed:** Install or update **App Installer** from the Microsoft Store, then run the script again.
- **The shortcuts do not work:** Confirm that the Windows Terminal tab is running PowerShell 7, then open a new session so it loads the updated profile.
- **`fzf` is not found after installation:** Open a new PowerShell session to refresh the environment and rerun the installer if needed.

The script changes only the PowerShell 7 profile integration; it does not alter Windows Terminal settings.
