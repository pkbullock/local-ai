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


## Output Phi-3 Model

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


## Output GPT-4o Model

----

The provided script is a PowerShell script that utilizes the PnP PowerShell module (a community-driven set of cmdlets for working with Microsoft 365 environments) to export flows (Power Automate workflows) from a specific environment within Microsoft’s Power Platform.  
   
Here's a breakdown of what the script does:  
   
1. **Set Environment Name**:  
    ```powershell  
    $environmentName = "Personal Productivity"  
    ```  
   This variable stores the name of the environment that contains the flows you want to export.  
   
2. **Retrieve Environment Information**:  
    ```powershell  
    $FlowEnv = Get-PnPFlowEnvironment | Where-Object { $_.Properties.DisplayName -eq $environmentName }  
    ```  
   This retrieves all flow environments and filters them to get the details for `"Personal Productivity"`.  
   
3. **Get All Flows in Specified Environment**:  
    ```powershell  
    Write-Host "Getting All Flows in $environmentName Environment"  
      
    $flows = Get-PnPFlow -Environment $FlowEnv -AsAdmin  
     # Remove `-AsAdmin` Parameter if you only want to target flows you have permission to access.  
       
     Write-Host "Found $($flows.Count) Flows to export..."  
     ```  
   This fetches and lists all flows within the specified environment. The `-AsAdmin` parameter allows retrieving all flows in an admin context, even those that may not explicitly belong directly to your account.  
   
4. **Loop Through Each Flow and Export as ZIP & JSON**:  
   ```powershell  
   foreach ($flow in $flows) {  
       Write-Host "Exporting as ZIP & JSON... $($flow.Properties.DisplayName)"  
         
       # Cleaning up filenames by removing spaces and invalid chars, adding timestamp format   
       # like `yyyymmddhhmmss`.  
       ...  
         
        Export-PnPFlow -Environment ...    
        ...  
          
        Out-File "$exportPath.json"  
          
}  
```  
Within this loop:  
* The display name of each flow is used (spaces are removed).  
* A timestamp (`yyyymmddhhmmss`) creates unique filenames.  
* Invalid characters in file names are replaced with underscores.  
* Two exports occur for each flow: one into a zip package (`*.zip`) containing all necessary components or artifacts of the flow, and another into a JSON file (`*.json`) which captures its definition or configuration details.  
   
### Prerequisites  
   
1. **PnP PowerShell Module Installation**: Ensure PnP.PowerShell is installed on your machine.  
```powershell  
Install-Module -Name PnP.PowerShell -Force -AllowClobber   
```  
   
2. **Auth Credentials & Permissions**: Before running this script, authenticate against your Microsoft 365 tenant using proper credentials which have requisite permissions over these Flow environments.  
```powershell  
Connect-PnPOnline –Url [URL] –Credentials $(Get-Credential)  
# Or other connect mechanisms based setup (e.g., interactive/mfa enabled etc.)  
```  
   
### Potential Use Cases  
   
1. **Backup Existing Workflows**  
2. Efficient Migration Between Environments or Tenants   
3 Adjustment/Review Compliance Export   
  
Make sure to customize and adapt paths/environment variables according but also manage secrets safely where applicable not storing inline trains prod/dev silos ensuring security principles remain upheld respect governing policies operationally implementing similar automation scripts successfully use across enterprise clients small standalone projects alike aiding efficiency productivity gains tailored solutions address precise needs presented automating tedious manual task simplifying effectively devop operations aligned broader strategy goals end achieved time resources better outcomes everyone involved ultimately!!

------


# Output GPT-3.5 Model

------

This script is a PowerShell script that exports all Power Automate (previously known as Microsoft Flow) flows that belong to a specified environment into ZIP and JSON files.   
  
It stores the name of the target environment in the `$environmentName` variable, locates this environment using `Get-PnPFlowEnvironment`, gets all flows assigned to this `FlowEnv` with `Get-PnPFlow`, then loops through each flow and exports it into a ZIP package using Export-PnPFlow command and saves it in a file with name following `{flow displayName}_{timestamp}.zip`. It also exports flows as JSON files separately without packaging by removing `-AsZipPackage`.


------