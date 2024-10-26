<# 
----------------------------------------------------------------------------

Created:      Paul Bullock
Date:         26/10/2024
Disclaimer:   

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

.Synopsis

    This script will generate a new script sample from an existing PowerShell script

.Example

    inputs/script.ps1 is the source script to process

.Notes

    This script depends on Ollama to run the models locally.
    Models used to give a variety of options for the descriptions.

    $localModels = "mistral-nemo","phi3.5","llama3.2:1b"

 ----------------------------------------------------------------------------
#>

[CmdletBinding()]
param (
    $Script = "inputs/script.ps1"
)
begin {

    $outputLocation = "$(Get-Location)\outputs"

    # ------------------------------------------------------------------------------
    # Introduction
    # ------------------------------------------------------------------------------

    Write-Host @"

    ██████  ██   ██ ██████  ██    ██ ██      ██       ██████   ██████ ██   ██     ██████  ██████  ███    ███ 
    ██   ██ ██  ██  ██   ██ ██    ██ ██      ██      ██    ██ ██      ██  ██     ██      ██    ██ ████  ████ 
    ██████  █████   ██████  ██    ██ ██      ██      ██    ██ ██      █████      ██      ██    ██ ██ ████ ██ 
    ██      ██  ██  ██   ██ ██    ██ ██      ██      ██    ██ ██      ██  ██     ██      ██    ██ ██  ██  ██ 
    ██      ██   ██ ██████   ██████  ███████ ███████  ██████   ██████ ██   ██ ██  ██████  ██████  ██      ██ 
                                                                                                             
"@

    Write-Host " Welcome to PnP Script Samples, this script will generate a new script sample from a PowerShell script" -ForegroundColor Green
    
    # ------------------------------------------------------------------------------

    $modelsystemPrompt = "You are a helpful analyser of PowerShell scripts that will be used to produce title and description of what the script intended function. Intended to give readers of the PowerShell script, a friendly message to describe what the script is about. The PowerShell scripts can be based on the Microsoft services such as Microsoft 365, SharePoint, Azure, Power Platform, Teams, Security and Compliance. The response should include a Title, Description, Assumptions, and Dependencies result in JSON format. Here is an example: {  ""Title"": ""Title of the Script"", ""Purpose"": ""Purpose of the Script"",    ""Dependencies"": [""Connect-PnPOnline"", ""Get-PnPListItem""],  ""Assumptions"": [{ ""SourceSitePartURLRequired"": true,      ""TenantFilterOptional"": false    }  ]}"

    $promptTemplate = "Produce a short descriptive paragraph around 75 words long, what the script is, anticipate its purpose. Here is the PowerShell script: {0}"

    $localModels = "phi3.5:3.8b-mini-instruct-q4_0" #, "codellama","mistral-nemo" #,"phi3.5","llama3.2:1b"
}
process {

    function Get-SampleDescription {
        param (
            [string]$Prompt,
            [string]$OllamaLocalAPI = "http://localhost:11434/api/generate",
            [string]$Model,
            [string]$SystemPrompt
        )

        if(-not $Prompt -or -not $Model -or -not $SystemPrompt) {
            Write-Host "Prompt, Model and SystemPrompt are required" -ForegroundColor Red
            return
        }
        
        $body = @{
            model = $Model
            prompt = $Prompt
            system = $SystemPrompt
            stream = $false
            options = @{
                temperature = 0.25
                top_p = 0.1
                max_tokens = 4096
            }
        }
        $json = $body | ConvertTo-Json
        $response = Invoke-RestMethod -Uri $OllamaLocalAPI -Method Post -Body $json -ContentType "application/json"
                        
        return $response.response
    }

    Write-Host "Processing $Script" -ForegroundColor Cyan
    Write-Host "Generating Description from Model for $Script" -ForegroundColor Cyan
    
    # Check if the script location exists
    if(-not (Test-Path $Script)) {
        Write-Host "Script not found" -ForegroundColor Red
        return
    }
    
    $scriptToProcess = Get-Content $Script -Raw

    # Use the Model to get a richer description
    $prompt = $promptTemplate -f $scriptToProcess

    #Write-Host " - Prompt: $prompt" -ForegroundColor Blue

    $localModelResults = @()

    $localModels | ForEach-Object {
        $localModel = $_
        
        

        Write-Host " - Processing Model: $localModel" -ForegroundColor Green
        Write-Host "   Note: this can take a while to process..." -ForegroundColor Yellow
        
        $executionTime = Measure-Command {
            $ModelDescription = Get-SampleDescription -Prompt $prompt -SystemPrompt $modelsystemPrompt -Model $localModel
        }
        Write-Host "$localModel Model Result Description: $ModelDescription" -ForegroundColor Cyan
        Write-Host "Execution time for $localModel - $($executionTime.TotalSeconds) seconds" -ForegroundColor Magenta

        $localModelResults += [PSCustomObject]@{
            Model = $localModel
            ModelResultDescription = $ModelDescription
            ModelResultObject = $ModelDescription | ConvertFrom-Json -Depth 10
            ExecutionTimeInSeconds = $executionTime.TotalSeconds
        }
    }

    $analysisResults = [PSCustomObject]@{
        Script = $Script
        Prompt = $prompt
        SystemPrompt = $modelsystemPrompt
        LocalModelResults = $localModelResults
    }

    # Output the results to a JSON file
    $analysisResults | ConvertTo-Json -Depth 10 | Out-File "$outputLocation\LocalModelResults.json"

}
end{

  Write-Host "Done! :)" -ForegroundColor Green
}