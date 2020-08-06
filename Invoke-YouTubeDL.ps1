[CmdletBinding()]
param(
    [Parameter(Position = 0, Mandatory)]
    [string]$Video,
    [Parameter(Position = 1)]
    [System.IO.DirectoryInfo]$OutputDirectory = ".\"
)

process {
    $YouTubeDlSplat = @{
        "FilePath"     = "youtube-dl";
        "ArgumentList" = @(
            "-f `"bestvideo+bestaudio`"",
            "--embed-subs",
            "--embed-thumbnail",
            "--add-metadata",
            "`"$($Video)`""
        );
        "Wait"         = $true;
        "NoNewWindow"  = $true;
    }

    Push-Location -Path $OutputDirectory.FullName -ErrorAction Stop

    Start-Process @YouTubeDlSplat

    Pop-Location -ErrorAction Stop
}