param ($iterations = 3)

$guids = @()
$defaultColor = "DarkMagenta"
$goodColor = "green"
$badColor = "red"
$sleepyTime = 5

function Execute($guid) {
    WriteInColor $defaultColor "===================================================================="
    WriteInColor $defaultColor "|Building and producing a binary log, including the analyzer report|"
    WriteInColor $defaultColor "===================================================================="

    $binlog_filename = "build-$guid.binlog"
    dotnet.exe build /p:reportanalyzer=true /bl:$binlog_filename --no-incremental 

    WriteInColor $goodColor "Done! Find your binlog at: $binlog_filename"
}

function Annihilate {
    try {
        WriteInColor $defaultColor "Trying to kill the hanging .NET processes..."
        Get-Process "dotnet" | Stop-Process
        WriteInColor $goodColor "The hanging .NET processes have been killed."
    }
    catch {
        WriteInColor $badColor "No .NET processes have been found."
    }
}


function WriteInColor($ForegroundColor, $message) {
    # save the current color
    $fc = $host.UI.RawUI.ForegroundColor

    # set the new color
    $host.UI.RawUI.ForegroundColor = $ForegroundColor

    # output
    Write-Output $message

    # restore the original color
    $host.UI.RawUI.ForegroundColor = $fc 

}

# Entrypoint
WriteInColor $defaultColor "Total iterations: $iterations"

for ($i = 0; $i -lt $iterations; $i++) {
    WriteInColor $defaultColor "Iteration: $i"

    $unique = [guid]::NewGuid()
    $guids += $unique

    Execute $unique
    Start-Sleep $sleepyTime
    Annihilate;
    Start-Sleep $sleepyTime
}

WriteInColor $defaultColor "Generated binlog IDs:"
$guids.foreach({$_})
