#Requires -Modules Pester

#region variables
$ModuleFolderName = 'PSSouthPark'
$ModulePath = Join-Path $env:BUILD_SOURCESDIRECTORY $ModuleFolderName
#$ModulePath = Join-Path $PSScriptRoot $ModuleFolderName
#endregion
Write-output "Module Path: '$ModulePath'"

Describe "PowerShell Module Import Test" {

  It 'Module Path should exist' {
    Test-Path $ModulePath -ErrorAction SilentlyContinue | should Be $true
  }

  It 'Should be imported successfully' {
    Import-Module -Name $ModulePath -ErrorVariable ImportError
    $ImportError | Should Be $Null
  }
}