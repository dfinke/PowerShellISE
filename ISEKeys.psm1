
function Format-Shortcut {

    Param(
        [Parameter(Mandatory=$true)]
        [validateNotNull()]
        [System.Windows.Input.KeyGesture]$Shortcut
    )

    $modifiers = ($Shortcut.Modifiers -replace ', ','+') -replace 'Control','Ctrl'
    $key = $Shortcut.Key
    
    if($modifiers -ne 'None')
    {
        "$modifiers+$key"
    }
    else
    {
        $key
    }
}

function Get-AddonMenuShortcuts ($menu) {

    While($menu.Count -gt 0)
    {
        $menu | foreach {       
            if($_.Shortcut -ne $null)
            {
                @{$_.DisplayName = (Format-Shortcut $_.Shortcut)}
            }
        }

        $menu = $menu.submenus
    }
}

function Get-ISEKeys {
    param(
        $Name,
        $KeyName
    )
 
    $gps = $psISE.GetType().Assembly
    $rm = New-Object System.Resources.ResourceManager GuiStrings,$gps
    $rs = $rm.GetResourceSet((Get-Culture),$true,$true)
    
    $shortCuts = $rs | where Name -match 'Shortcut\d?$|^F\d+Keyboard'
 
    $AddOnsMenu = $psise.CurrentPowerShellTab.AddOnsMenu

    $AddOnsShortCuts = Get-AddonMenuShortcuts $AddonsMenu.Submenus

    $shortCuts += $AddOnsShortCuts
    
    if(!$Name -And !$KeyName)  {
        return $shortCuts | sort Name | Out-GridView
    }

    if($Name) {
        $shortCuts | where name -match $Name
    }

    if($KeyName) {
        $shortCuts | where value -match $KeyName
    }    
}

function Add-ISEKeysMenu {

    Remove-ISEKeysMenu
    [void]$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add("ISE Keys", ([ScriptBlock]::Create((Get-Command Get-ISEKeys).Definition)), "CTRL+Shift+K")
}

function Get-ISEKeysMenu {

    $psISE.CurrentPowerShellTab.AddOnsMenu.Submenus |
        Where DisplayName -Match "ISE Key"
}

function Remove-ISEKeysMenu {

    $menu = Get-ISEKeysMenu
    if($menu) {
        [void]$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Remove($menu)
    }
}

Add-ISEKeysMenu