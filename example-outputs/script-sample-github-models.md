# Example using AI Toolkit and Phi-3 Model

The input is based on the following sample: https://pnp.github.io/script-samples/flow-export-all-flows-in-environment/README.html?tabs=pnpps

## Settings

### System Message

You are a assistant for describing what PowerShell scripts do. Do not suggest PowerShell modules. Include a short description of the script functionality and potential use cases.

### Configuration

- Max Tokens: 4096
- Temperature: 0.25
- Top P: 1

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


## Output Phi-3 Mini 128K Model

-----

This PowerShell script is designed to automate the process of exporting Microsoft Power Platform flows (also known as flow apps) from a specific environment within the Power Platform. The script performs the following steps:

1. It sets the name of the environment to be exported from, which in this case is "Personal Productivity".
2. It retrieves the environment object using the Get-PnPFlowEnvironment cmdlet and filters it to find the one with the display name matching the environment name.
3. It then retrieves all flows within the specified environment using the Get-PnPFlow cmdlet and outputs a message indicating the number of flows found.
4. The script enters a loop, iterating through each flow and performs the following actions:
 - It outputs a message indicating that the flow is being exported as a ZIP and JSON file.
 - It generates a filename based on the flow's display name and a timestamp to ensure uniqueness.
 - It creates a valid export path for the ZIP and JSON files, replacing any invalid characters in the filename.
 - It exports the flow as a ZIP package using the Export-PnPFlow cmdlet and saves it to the specified export path.
 - It also exports the flow as a JSON file using the Export-PnPFlow cmdlet with the -AsJson parameter and saves it to the same export path.

Potential use cases for this script include:

- Automating the export of specific flows from a Power Platform environment for backup, migration, or sharing purposes.
- Exporting flows with specific display names or other properties for further analysis or processing.
- Streamlining the process of exporting multiple flows by eliminating the need to manually export each flow individually.
- Integrating the script into a larger automation workflow, such as a scheduled task or a continuous integration/continuous deployment (CI/CD) pipeline, to ensure that flows are exported on a regular basis.


------

### Output using Mistral Small

------

This PowerShell script is designed for exporting all Microsoft Power Automate (formerly known as Microsoft Flow) flows from a specific environment, named "Personal Productivity" in this instance. It uses the SharePoint PnP PowerShell library for interacting with the Power Automate environment.

After identifying the "Personal Productivity" environment, the script fetches all flows within it using the Get-PnPFlow cmdlet. The -AsAdmin parameter is included to ensure all flows are retrieved, regardless of the user's access permissions.

The script then iterates over each flow and exports them in two formats: a ZIP package and a JSON file. The exported file names are based on the flow's display name, with invalid characters replaced by underscores, and a timestamp appended to avoid duplicate file names.

Potential use cases for this script include:

1. Backup and recovery: Regularly exporting flows to secure their configuration and enable recovery in case of data loss or errors.
2. Migration: Exporting flows for migration to a new environment, such as during a system upgrade or migration from one tenant to another.
3. Documentation: Exporting flows for documentation or auditing purposes, to maintain a record of workflows and their configurations.
4. Version control: Exporting flows to implement version control, allowing for tracking changes and revert to previous versions if necessary.

------

## Output using ChatGPT 4o Mini

This PowerShell script is designed to export all Microsoft Power Automate (formerly known as Microsoft Flow) flows from a specified environment, in this case, "Personal Productivity."

Functionality:

1. Environment Selection: It retrieves the specified environment using the Get-PnPFlowEnvironment cmdlet.
2. Flow Retrieval: It fetches all flows within that environment, optionally running with administrative privileges.
3. Exporting Flows: For each flow found, it exports the flow as both a ZIP package and a JSON file. The filenames are generated based on the flow's display name and include a timestamp to ensure uniqueness.

Use Cases:

- Backup: This script can be used to back up flows from a specific environment, ensuring that you have a copy in case of accidental deletion or modification.
- Migration: It can facilitate the migration of flows between environments by exporting them and then importing them into another environment.
- Documentation: The JSON export can serve as documentation for the flow's configuration, making it easier to understand or replicate the flow later.