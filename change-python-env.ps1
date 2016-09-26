powershell script
# Program : 
#     I have python2.7 installed in D:\Python27 and python4.5 installed in D:\Python45
#     This program add Python to environment variable and can changed between python2.7 and python4.5
# Author :
#    muto 
# History :
#     2016/09/26  version 1.0 release


## clear python in path
## this is nasty!
$a = New-Object System.Collections.ArrayList
$b = New-Object System.Collections.ArrayList
$oldpath=[System.Environment]::GetEnvironmentVariable('Path','User')
$oldpath.Split(";",[System.StringSplitOptions]::RemoveEmptyEntries)|foreach-object {$a.add("$_")} | Out-Null
$a | ForEach-Object {if ($_.Contains("Python")) {$b.add("$_")}}    | Out-Null
$b | ForEach-Object {$a.remove($_)}
$list=[String[]]$a
$path=[String]::Join(';',$list)

## menu
$title = "Change Python Version"
$message = "Original Path is 
$oldpath"
$python2 = New-Object System.Management.Automation.Host.ChoiceDescription "&A2.7","change to python2"
$python3 = New-Object System.Management.Automation.Host.ChoiceDescription "&B4.5","change to python3"
    $clear = New-Object System.Management.Automation.Host.ChoiceDescription "&Clear","Clear"
$options = [System.Management.Automation.Host.ChoiceDescription[]]($python2, $python3,$clear)

    $result = $host.ui.PromptForChoice($title, $message, $options, 0) 
switch ($result)
{
    0 {
## add python2 to path
        $python2="D:\Python27;D:\Python27\Scripts;"
            $path=$python2+$path
            [System.Environment]::SetEnvironmentVariable('Path', $path, 'User')
    }
    1 {
## add python3 to path
        $python3="D:\Python35;D:\Python35\Scripts;"
            $path=$python3+$path
            [System.Environment]::SetEnvironmentVariable('Path', $path, 'User')
    }
    2 {
        [System.Environment]::SetEnvironmentVariable('Path', $path, 'User')
    }
}

$path=[System.Environment]::GetEnvironmentVariable('Path','User')
echo "Now is
$path"


# a simple but not good implementation
# $oldpath=[System.Environment]::GetEnvironmentVariable('Path','User')
# $path=$oldpath.replace("D:\Python27\Scripts","").replace("D:\Python27","").trimend(';')
# [System.Environment]::SetEnvironmentVariable('Path', $path, 'User')


## Note
# environment variable is in user not machine
# see this:
# [System.Environment]::SetEnvironmentVariable('Path', $path, 'User')
