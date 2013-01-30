## PowerShell module for ISE
### Gets all the shortcut keys in ISE (Integrated Scripting Environment)

[Shay Levy](http://blogs.microsoft.co.il/blogs/scriptfanatic/), PowerShell MVP, posted some script here http://goo.gl/FpdVr that extracts all the shortcuts from the PowerShell script editor and displays both their name and the shortcut it is connected to.

### Download the module
This module uses Shay's implementation and does two things.

* Adds a menu option connected to Ctrl+Shift+K that displays all the keys with Out-GridView
![Pic](/images/shortcutkeys.png)

* Second, it provides a function Get-ISEKeys that can return all the keys. Or you can search by name or shortcut.

#### Search by name

```powershell
PS C:\> Get-ISEKeys scroll 

Name                                            Value    
----                                            -----    
EditorScrollDownAndMoveCaretIfNecessaryShortcut Ctrl+Down
EditorScrollUpAndMoveCaretIfNecessaryShortcut   Ctrl+Up  
```

#### Search by shortcut
```powershell
PS C:\> Get-ISEKeys -KeyName backs

Name                                Value              
----                                -----              
EditorUndoShortcut2                 Alt+Backspace      
EditorRedoShortcut2                 Alt+Shift+Backspace
EditorDeleteWordToLeftShortcut      Ctrl+Backspace     
EditorDeleteCharacterToLeftShortcut Shift+Backspace    
```
