#Requires -version 5.0

[CmdletBinding()]
Param
(
    [Parameter(Mandatory = $true)][String]$RepoBaseURI,

    [Parameter(Mandatory = $true)][String]$FeedName,

    [Parameter(Mandatory = $true)][String]$APIKey,

    [Parameter(Mandatory = $true)][String]
    $ModuleFolderName
)
If ($RepoBaseURI.Substring($RepoBaseURI.Length -1, 1) -ne '/')
{
    $RepoBaseURI = "$RepoBaseURI`/"
}

$SourceLocation = $RepoBaseURI + $FeedName + "/auth/$APIKey/api/v2"
$PublishLocation = $RepoBaseURI + $FeedName + "/api/v2/package"

$ExistingRepo = Get-PSRepository -Name $FeedName -ErrorAction SilentlyContinue
If (!$ExistingRepo)
{
    #register PS repo
    Write-Output "PS Repository '$FeedName' is not registered. registering now..."
    $Params = @{
        Name = $FeedName
        SourceLocation = $SourceLocation
        PublishLocation = $PublishLocation
        InstallationPolicy = 'Trusted'
    }
    Register-PSRepository @Params
} else {
    Write-Output "PS Repository '$FeedName' is already registered. making sure publish location is correctly configured."
    Set-PSRepository -Name $FeedName -PublishLocation $PublishLocation -InstallationPolicy 'Trusted'
}

Write-Output '', "Publishing module."
Publish-Module -path $(Join-Path $PSScriptRoot $ModuleFolderName) -NuGetApiKey $APIKey -Repository $FeedName -Force

If (!$ExistingRepo)
{
    Write-Output "Unregistering PS Repository"
    Unregister-PSRepository -Name $FeedName
}
Write-Output "Done!"