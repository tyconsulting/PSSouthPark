Function Invoke-SouthParkSound
{
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory=$false)][Switch]$Loop,
    [Parameter(Mandatory=$false)][Switch]$Sync
  )
  $SoundFiles = Get-ChildItem -Path $PSScriptRoot -include @("*.wav") -Recurse
  $SoundFile = Get-Random -InputObject $SoundFiles
  $Sound = new-Object System.Media.SoundPlayer
  $Sound.SoundLocation = $SoundFile.FullName
  if ($Loop -eq $true)
  {
    Do {
      $SoundFile = Get-Random -InputObject $SoundFiles
      $Sound.SoundLocation = $SoundFile.FullName
      $Sound.PlaySync()
    } while ($true)
  } elseif ($Sync -eq $true) {
    $Sound.PlaySync()
  } else {
    $Sound.Play()
  }
}
New-Alias -Name SouthParkSound -Value Invoke-SouthParkSound
Export-ModuleMember -Alias * -Function *