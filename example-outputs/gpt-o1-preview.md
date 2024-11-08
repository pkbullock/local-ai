# Example 1

## Prompt

Prompt: Sure, below is the PowerShell script that connects to SharePoint using PnP PowerShell, creates a document library, and sets versioning to keep 1000 major versions.

## Result

```powershell
# Import the PnP.PowerShell module
Import-Module PnP.PowerShell

# Set variables
$SiteUrl = "https://yourtenant.sharepoint.com/sites/yoursite"  # Replace with your site URL
$DocumentLibraryName = "MyDocumentLibrary"  # Replace with your desired library name
$VersionLimit = 1000  # Number of versions to keep

# Connect to SharePoint Online interactively (prompts for authentication)
Connect-PnPOnline -Url $SiteUrl -Interactive

# Create the document library
New-PnPList -Title $DocumentLibraryName -Template DocumentLibrary

# Set versioning settings on the document library
Set-PnPList -Identity $DocumentLibraryName -EnableVersioning $true -EnableMinorVersions $false -MajorVersions $VersionLimit

Write-Host "Document library '$DocumentLibraryName' created with versioning set to keep $VersionLimit major versions."
```

**Explanation:**

1. **Import the PnP.PowerShell Module**: Ensures that the PnP cmdlets are available for use in the script.

   ```powershell
   Import-Module PnP.PowerShell
   ```

2. **Set Variables**: Customize these variables to match your environment.

   ```powershell
   $SiteUrl = "https://yourtenant.sharepoint.com/sites/yoursite"  # Your SharePoint site URL
   $DocumentLibraryName = "MyDocumentLibrary"  # Name of the new document library
   $VersionLimit = 1000  # The number of major versions to retain
   ```

3. **Connect to SharePoint Online**: Uses interactive authentication to connect to your SharePoint site.

   ```powershell
   Connect-PnPOnline -Url $SiteUrl -Interactive
   ```

4. **Create the Document Library**: Creates a new document library with the specified name.

   ```powershell
   New-PnPList -Title $DocumentLibraryName -Template DocumentLibrary
   ```

5. **Set Versioning Settings**: Configures the document library to enable versioning and set the maximum number of major versions to keep.

   ```powershell
   Set-PnPList -Identity $DocumentLibraryName -EnableVersioning $true -EnableMinorVersions $false -MajorVersions $VersionLimit
   ```

   - `-EnableVersioning $true`: Turns on versioning.
   - `-EnableMinorVersions $false`: Disables minor (draft) versions.
   - `-MajorVersions $VersionLimit`: Sets the limit for major versions to retain.

6. **Confirmation Message**: Outputs a message to confirm that the library has been created and configured.

   ```powershell
   Write-Host "Document library '$DocumentLibraryName' created with versioning set to keep $VersionLimit major versions."
   ```

**Note**: Before running the script, ensure that:

- **PnP.PowerShell Module**: The PnP.PowerShell module is installed. If not, you can install it using:

  ```powershell
  Install-Module -Name PnP.PowerShell
  ```

- **Permissions**: You have the necessary permissions to create lists and configure settings in the SharePoint site.

- **Authentication**: The `-Interactive` parameter will prompt you to authenticate. Make sure to use credentials that have sufficient rights.

**Customization**: You can further customize the script by:

- Changing `$DocumentLibraryName` to create multiple libraries or to parameterize the script.

- Adjusting versioning settings, such as enabling minor versions (`-EnableMinorVersions $true`) if needed.

**Running the Script**:

1. Open **PowerShell** or **PowerShell ISE**.

2. Copy and paste the script into the editor.

3. Modify the variables to match your SharePoint environment.

4. Run the script.

After execution, the script will create a new document library with the specified name and configure it to keep up to 1000 major versions of documents.