# Pinephone-x86-Wine
Scripts and instructions to install x86 windows apps on the Pinephone.

#### DO NOT RUN THIS SCRIPT IF YOU HAVE USED ANY OF MY OTHER SCRIPTS THAT ARE NOT CLEARLY STATED TO BE COMPATIBILE!!! 

#### (Warning: Currently not working)

I am currently working on integrating box64, which would provide a much better and far less complicated user experience. Until then, i would not recommend using any of these scripts.

## Supported Platforms
Currently, only the Pinephone is supported. You must be running a fresh install of one of the following operating systems for this script:
* Mobian (Nightly)
* Manjaro Phosh (Dev) _(Other desktop environments may also work but are untested.)_


## Installation Instructions
1. Download and extract the latest script on the releases page to your Downloads folder.
2. Run the script with this command: `cd Downloads/Pinephone-x86-Wine; sudo bash Downloads/pinephone-wine-*.sh | tee log.txt`
3. This will guide you through the process of installing wine.

## Usage Instructions

This is very similar to using wine on the desktop. Just use the `wine` command as you would normally, no need to chroot or worry about any of that stuff. 
