$env:path += ";C:\msysgit\bin"


#This is a hacky implementation of touch. Will create files or Update Timestamps
function touch([string] $fileName)
{
   if(Test-Path $fileName)
   {
      Set-FileTime $fileName
      # echo "HHH"
      # $(Get-Item $fileName).CreationTime = Get-Date
      # $(Get-Item $fileName).LastAccessTime = Get-Date
      # $(Get-Item $fileName).LastWriteTime = Get-Date
   } else {
       New-Item -ItemType file -Name $fileName
   }
}

function Get-BatchFile([string] $file)
{
	$cmd = "`"$file`" & set"
	cmd /c $cmd | Foreach-Object {
		$p, $v = $_.split('=')
		Set-Item -path env:$p -value $v
	}
}

function VsVars32($version = "10.0")
{
	$key = "HKCU:SOFTWARE\Microsoft\VisualStudio\" + $version + "_Config"
	$VsKey = get-ItemProperty $key
	$VsInstallPath = [System.IO.Path]::GetDirectoryName($VsKey.InstallDir)
	$VsToolsDir    = [System.IO.Path]::GetDirectoryName($VsInstallPath);
	$VsToolsDir    = [System.IO.Path]::Combine($VsToolsDir, "Tools")
	$BatchFile       =[System.IO.Path]::Combine($VsToolsDir, "vsvars32.bat")
	Get-Batchfile $BatchFile
	[System.Console]::Title += " - VS " + $version
}

#=============================


function AmountRemaining()
{
	write-host Only "$"("{0:N0}" -f ((((get-date 12/6/10)-(get-date)).Days + 365) * (7500/365))) to go! -fore Yellow
}

AmountRemaining
VsVars32
AddAllFoldersIn "C:\Utilities\"