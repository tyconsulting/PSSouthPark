# Sample PowerShell Module PSSouthPark

## Description
This is a sample PowerShell module that plays random sound clip from South Park.

### Syntax

#### Play a random South Park sound clip asynchronously
```PowerShell
Invoke-SouthParkSound
```

#### Play a random South Park sound clip syncrhonously
```PowerShell
Invoke-SouthParkSound -Sync
```

#### Keep playing random South Park sound clips until manually terminated (Ctrl+C)
```PowerShell
Invoke-SouthParkSound -Loop
```