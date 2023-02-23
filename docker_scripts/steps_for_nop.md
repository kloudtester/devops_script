Install_steps_nop:
------------------

* First we need to take one ubuntu vm.
* next we need to download wget and unzip and also we need to create ok folder with name nop
* next we need download nop git file to nop folder
```
https://github.com/nopSolutions/nopCommerce/releases/download/release-4.50.3/nopCommerce_4.50.3_NoSource_linux_x64.zip
```
* next we need to unzip it
```
tar -xvzf nopCommerce_4.50.3_NoSource_linux_x64.zip
```
* To run this application we dotnet install in it
* to install dotnet we need to follow this commands
```
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-6.0
```
* this application run on 80

```
CMD ["dotnet","/Nop/Nop.Web.dll"]
```
* this command is used in docker file to run this application