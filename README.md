# Example Installers
> [!NOTE]
> This is a repository which showscases and stores installers for Windows, macOS, and Linux for students/users currently going through the Installers exercise of the Installers &amp; Self-Deployment Module of the Software Engineering Lab. 


----
#### If you are here to learn how these example installers were made, here is the guide:

$$ Windows $$
1. In the installers folder, run the `generate_executable.sh` script to create an executable, this will be automatically placed in the windows directory.
2. Create an `.iss` script through Inno Setup and compile it.
3. This will output the installer.
$$ MacOS $$
1. In the installers folder, run the `generate_executable.sh` script to create an executable, this will be automatically placed in the macos directory.
2. Make sure both the executable and license is in the correct directory, then just run the `generate_installer.sh` script to create the installer.
$$ Linux $$
1. In the installers folder, run the `generate_executable.sh` script to create an executable, this will be automatically placed in the linux directory.
2. Make sure both the executable and license is in the correct directory, then just run the `generate_installer.sh` script to create the installer.
