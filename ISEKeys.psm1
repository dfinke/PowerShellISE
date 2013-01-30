function Get-ISEKeys {
    param(
        $Name,
        $KeyName
    )
 
    $gps = $psISE.GetType().Assembly
    $rm = New-Object System.Resources.ResourceManager GuiStrings,$gps
    $rs = $rm.GetResourceSet((Get-Culture),$true,$true)
    
    $shortCuts = $rs | where Name -match 'Shortcut\d?$|^F\d+Keyboard'
    
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