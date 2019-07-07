Import-Module downloader
Import-Module unzip
Import-Module command
Import-Module cleanup

Function install($VERSION="8.1.1640"){
  $url="https://github.com/vim/vim-win32-installer/releases/download/v${VERSION}/gvim_${VERSION}_x86.exe"
  $name="vim"
  $filename="gvim_${VERSION}_x86.exe"
  $unzipDesc="vim"

  if($(_command vim)){
    $VERSION_X=(vim --version).split(" ")[4].split('.')[0]
    $VERSION_Y=(vim --version).split(" ")[4].split('.')[1]
    $VERSION_Z=(vim --version).split(" ")[18].split("-")[1]

    if(${VERSION_Z}.length -eq 1){
      $VERSION_Z="000${VERSION_Z}"
    }elseif(${VERSION_Z}.length -eq 2){
      $VERSION_Z="00${VERSION_Z}"
    }elseif(${VERSION_Z}.length -eq 3){
      $VERSION_Z="0${VERSION_Z}"
    }

    $CURRENT_VERSION=(vim --version).split(" ")[4] + '.' + $VERSION_Z

    if ($CURRENT_VERSION -eq $VERSION){
        echo "==> $name $VERSION already install"
        return
    }
  }

  # 下载原始 zip 文件，若存在则不再进行下载
  _downloader `
    $url `
    $filename `
    $name `
    $VERSION

  # 验证原始 zip 文件 Fix me

  # 解压 zip 文件 Fix me
  # _cleanup ""
  # _unzip $filename $unzipDesc

  # 安装 Fix me
  # Copy-item -r -force "" ""
  Start-Process -FilePath $filename -wait
  # _cleanup ""

  # [environment]::SetEnvironmentvariable("", "", "User")

  echo "==> Checking ${name} ${VERSION} install ..."
  # 验证 Fix me
  vim --version
}

Function uninstall(){
  $VERSION_X=(vim --version).split(" ")[4].split('.')[0]
  $VERSION_Y=(vim --version).split(" ")[4].split('.')[1]
  start-process -wait `
    -path ${env:ProgramFiles(x86)}\Vim\vim${VERSION_X}${VERSION_Y}\uninstall-gui.exe
}
