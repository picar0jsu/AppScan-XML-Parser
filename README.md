# run.ps1
A simple XML parser to deal with AppScan's cancerous reporting format. The script is currently VERY beta, so please do not be surprised if there are issues.

# Usage
```
./run.ps1 <APPSCAN>.xml
```
- Download the following xmlParser.ps1.
- Export the scan as XML. Save the file to disk.
- Place both the script and the csv file in a folder of choice and run the script. The script will generate a csv file upon completion.
- Open the csv file. There will be 6 columns, namely:
  - Issue-Name: Name of finding i.e., Cross-site Request Forgery
  - URL: Affected URL
  - testHTTPTraffic: Test Case HTTP Request
  - testResponseChunk: Vulnerable HTTP Response snippet
  - Reasoning: Why AppScan identified the finding
  - Severity: CVSS score
