## PowerShell module for ISE
### Gets all the shortcut keys in ISE (Integrated Scripting Environment)

[Shay Levy](http://blogs.microsoft.co.il/blogs/scriptfanatic/), PowerShell MVP, posted some script here http://goo.gl/FpdVr that extracts all the shortcuts from the PowerShell script editor and displays both their name and the shortcut it is connected to.

### Download the module
This module uses Shay's implementation and does two things.

* Provides a function Get-ISEKeys that can return all the keys. Or you can search by name or shortcut

```powershell
PS C:\> Get-ISEKeys scroll 

Name                                            Value    
----                                            -----    
EditorScrollDownAndMoveCaretIfNecessaryShortcut Ctrl+Down
EditorScrollUpAndMoveCaretIfNecessaryShortcut   Ctrl+Up  

```
