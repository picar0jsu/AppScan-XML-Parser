# v 1.0
# Author: Jonah Tan
# .\AppScanXMLParser.ps1 <APPSCAN>.xml

[xml]$xmlFileContent = Get-Content $args[0]

$arrayName = New-Object -TypeName 'System.Collections.ArrayList';
$arrayRef = New-Object -TypeName 'System.Collections.ArrayList';
$arrayURL = New-Object -TypeName 'System.Collections.ArrayList';
$arrayID = New-Object -TypeName 'System.Collections.ArrayList';

foreach ($item in $xmlFileContent."xml-report"."issue-type-group".item) {
    $null = $arrayName.Add($item.name)
    $null = $arrayRef.Add($item.advisory.ref)
}

foreach ($item in $xmlFileContent."xml-report"."url-group".item) {
    $null = $arrayURL.Add($item.name)
    $null = $arrayID.Add($item.id)
}

$count = 0

foreach ($item in $xmlFileContent."xml-report"."issue-group".item) {
    $index = $arrayRef.IndexOf($item."issue-type".ref)
    $title = $arrayName[$index]

    $index = $arrayID.IndexOf($item.url.ref)
    $URL = $arrayURL[$index]

    $severity = $item.severity + " (" + $item."cvss-score" + ")"

    $order = [ordered]@{'Issue-Name'=$title;'URL'=$URL;'testHttpTraffic'=$item."variant-group".item."test-http-traffic";'testResponseChunk'=$item."variant-group".item."issue-information".testResponseChunk;'Reasoning'=$item."variant-group".item.reasoning.InnerText;"Severity"=$severity}
    New-Object psobject -Property $order | export-csv AppScan_XML.csv -append -notypeinformation
    $count += 1
}
