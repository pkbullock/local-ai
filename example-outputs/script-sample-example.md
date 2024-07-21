# Example using AI Toolkit and Phi-3 Model

The input is based on the following sample: https://pnp.github.io/script-samples/flow-export-all-flows-in-environment/README.html?tabs=pnpps

## Input

What is this script?

```powershell
$environmentName = "Personal Productivity"

$FlowEnv = Get-PnPFlowEnvironment | Where-Object { $_.Properties.DisplayName -eq $environmentName }

Write-Host "Getting All Flows in $environmentName Environment"
$flows = Get-PnPFlow -Environment $FlowEnv -AsAdmin #Remove -AsAdmin Parameter to only target Flows you have permission to access

Write-Host "Found $($flows.Count) Flows to export..."

foreach ($flow in $flows) {

    Write-Host "Exporting as ZIP & JSON... $($flow.Properties.DisplayName)"
    $filename = $flow.Properties.DisplayName.Replace(" ", "")
    $timestamp = Get-Date -Format "yyyymmddhhmmss"
    $exportPath = "$($filename)_$($timestamp)"
    $exportPath = $exportPath.Split([IO.Path]::GetInvalidFileNameChars()) -join '_'
    Export-PnPFlow -Environment $FlowEnv -Identity $flow.Name -PackageDisplayName $flow.Properties.DisplayName -AsZipPackage -OutPath "$exportPath.zip" -Force
    Export-PnPFlow -Environment $FlowEnv -Identity $flow.Name | Out-File "$exportPath.json"

}

```


## Output

-----

This PowerShell script is designed to interact with a system that manages Power Platform flows, specifically within an environment named "Personal Productivity".

Firstly, it retrieves the environment object using Get-PnPFlowEnvironment and filters it to find the one with a display name matching "Personal Productivity".

Then, it proceeds to fetch all the flows within this specific environment using Get-PnPFlow, but it only targets those flows that the user has permission to access, as indicated by the -AsAdmin parameter.

The script counts the number of flows retrieved and informs the user of this count.

For each flow found, the script performs the following actions:

1. It generates a filename by removing spaces from the flow's display name and appending a timestamp to ensure uniqueness.

2. It exports the flow as a ZIP package using the Export-PnPFlow cmdlet, directing the output to a file named with the generated filename and the ".zip" extension.

3. It also exports the flow's details as a JSON file using the same cmdlet, but this time it pipes the output to Out-File to write it to a file with the same base name but with a ".json" extension.

The -Force parameter is used to overwrite any existing files with the same name without prompting the user.

This script is useful for system administrators who need to regularly back up and export the details of Power Platform flows for auditing, migration, or other purposes.


------