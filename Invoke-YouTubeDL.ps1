[CmdletBinding()]
param(
    [Parameter(Position = 0, Mandatory)]
    [string]$Video,
    [Parameter(Position = 1)]
    [System.IO.DirectoryInfo]$OutputDirectory = ".\",
    [Parameter(Position = 2)]
    [string]$ArchivePath
)

process {
    $ytdlOptions = [System.Collections.Generic.List[string]]::new()
    $ytdlOptions.Add("-f `"(bestvideo[ext=webm]+bestaudio[ext=webm]/bestvideo+bestaudio/best[ext=mp4]/best)`"")
    $ytdlOptions.Add("--recode-video `"mp4`"")
    $ytdlOptions.Add("-o `"%(title)s.%(ext)s`"")
    $ytdlOptions.Add("--embed-subs")
    $ytdlOptions.Add("--add-metadata")

    switch ($null -eq $ArchivePath)
    {
        $false {
            $ytdlOptions.Add("--download-archive `"$($ArchivePath)`"")
            break
        }

        Default {
            break
        }
    }

    $ytdlOptions.Add("`"$($Video)`"")

    $YouTubeDlSplat = @{
        "FilePath"     = "youtube-dl";
        "ArgumentList" = $ytdlOptions;
        "Wait"         = $true;
        "NoNewWindow"  = $true;
    }

    Push-Location -Path $OutputDirectory.FullName -ErrorAction Stop

    Start-Process @YouTubeDlSplat

    Pop-Location -ErrorAction Stop
}