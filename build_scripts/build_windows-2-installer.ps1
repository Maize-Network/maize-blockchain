# $env:path should contain a path to editbin.exe and signtool.exe

$ErrorActionPreference = "Stop"

mkdir build_scripts\win_build

git status
git submodule

if (-not (Test-Path env:MAIZE_INSTALLER_VERSION)) {
  $env:MAIZE_INSTALLER_VERSION = '0.0.0'
  Write-Output "WARNING: No environment variable MAIZE_INSTALLER_VERSION set. Using 0.0.0"
}
Write-Output "Maize Version is: $env:MAIZE_INSTALLER_VERSION"
Write-Output "   ---"

Write-Output "   ---"
Write-Output "Use pyinstaller to create maize .exe's"
Write-Output "   ---"
$SPEC_FILE = (python -c 'import maize; print(maize.PYINSTALLER_SPEC_PATH)') -join "`n"
pyinstaller --log-level INFO $SPEC_FILE

Write-Output "   ---"
Write-Output "Copy maize executables to maize-blockchain-gui\"
Write-Output "   ---"
Copy-Item "dist\daemon" -Destination "..\maize-blockchain-gui\packages\gui\" -Recurse

Write-Output "   ---"
Write-Output "Setup npm packager"
Write-Output "   ---"
Set-Location -Path ".\npm_windows" -PassThru
npm ci
$Env:Path = $(npm bin) + ";" + $Env:Path

Set-Location -Path "..\..\maize-blockchain-gui" -PassThru
# We need the code sign cert in the gui subdirectory so we can actually sign the UI package
If ($env:HAS_SECRET) {
    Copy-Item "..\win_code_sign_cert.p12" -Destination "packages\gui\"
}

Write-Output "   ---"
Write-Output "Prepare Electron packager"
Write-Output "   ---"
$Env:NODE_OPTIONS = "--max-old-space-size=3000"

# Change to the GUI directory
Set-Location -Path "packages\gui" -PassThru

Write-Output "   ---"
Write-Output "Increase the stack for maize command for (maize plots create) chiapos limitations"
# editbin.exe needs to be in the path
editbin.exe /STACK:8000000 daemon\maize.exe
Write-Output "   ---"

$packageVersion = "$env:MAIZE_INSTALLER_VERSION"
$packageName = "Maize-$packageVersion"

Write-Output "packageName is $packageName"

Write-Output "   ---"
Write-Output "fix version in package.json"
choco install jq
cp package.json package.json.orig
jq --arg VER "$env:MAIZE_INSTALLER_VERSION" '.version=$VER' package.json > temp.json
rm package.json
mv temp.json package.json
Write-Output "   ---"

Write-Output "   ---"
Write-Output "electron-packager"
electron-packager . Maize --asar.unpack="**\daemon\**" `
--overwrite --icon=.\src\assets\img\maize.ico --app-version=$packageVersion `
--no-prune --no-deref-symlinks `
--ignore="/node_modules/(?!ws(/|$))(?!@electron(/|$))" --ignore="^/src$" --ignore="^/public$"
# Note: `node_modules/ws` and `node_modules/@electron/remote` are dynamic dependencies
# which GUI calls by `window.require('...')` at runtime.
# So `ws` and `@electron/remote` cannot be ignored at this time.
Get-ChildItem Maize-win32-x64\resources
Write-Output "   ---"

Write-Output "   ---"
Write-Output "node winstaller.js"
node winstaller.js
Write-Output "   ---"

If ($env:HAS_SECRET) {
   Write-Output "   ---"
   Write-Output "Add timestamp and verify signature"
   Write-Output "   ---"
   signtool.exe timestamp /v /t http://timestamp.comodoca.com/ .\release-builds\windows-installer\MaizeSetup-$packageVersion.exe
   signtool.exe verify /v /pa .\release-builds\windows-installer\MaizeSetup-$packageVersion.exe
   }   Else    {
   Write-Output "Skipping timestamp and verify signatures - no authorization to install certificates"
}

Write-Output "   ---"
Write-Output "Moving final installers to expected location"
Write-Output "   ---"
Copy-Item ".\Maize-win32-x64" -Destination "$env:GITHUB_WORKSPACE\maize-blockchain-gui\" -Recurse
Copy-Item ".\release-builds" -Destination "$env:GITHUB_WORKSPACE\maize-blockchain-gui\" -Recurse

Write-Output "   ---"
Write-Output "Windows Installer complete"
Write-Output "   ---"
