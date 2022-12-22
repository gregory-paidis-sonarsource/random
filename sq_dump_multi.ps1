# Arguments
$server = "https://peach.sonarsource.com"
$token = "TOKEN"

$header_color = "Magenta"
$default_color = "Green"
$detail_color = "DarkYellow"

$csharp_rules = @(
    "S3262"
)

$vb_rules = @(
    "S3262"
)

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

# single-rule invocation
function DumpSingle($language, $rule) {
    WriteInColor $default_color "Dumping for rule: $rule"
    try {
        # if a file was already generated for a rule, use it as a base
        $base = (Get-ChildItem -Recurse -Exclude *Diff* -Filter *${language}.${rule}*)[0].Name 
        WriteInColor $detail_color "Found base at: $base"
        WriteInColor $detail_color "A diff will be generated."

        .\SqDump.exe $server $token ${language}:${rule} $base  
        # | Out-Null
    }
    catch {
        $base = ""
        # no file was previously generated for the rule, empty $base
        WriteInColor $detail_color "No base found."
        WriteInColor $detail_color "A diff will NOT be generated."

        .\SqDump.exe $server $token ${language}:${rule} 
        # | Out-Null
    }
}

# multiple-rule invocation
function DumpMultiple($language, $rules) {
    foreach ($rule in $rules) {
        DumpSingle $language $rule
    }
}

# "main"
WriteInColor $header_color "Dumping rules for csharp"
WriteInColor $header_color "========================"
DumpMultiple "csharpsquid" $csharp_rules

WriteInColor $header_color "Dumping rules for vb"
WriteInColor $header_color "===================="
DumpMultiple "vbnet" $vb_rules
