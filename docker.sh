#!/bin/sh
​
#VARIABLES
cpu=$(uname -m)
docker_ARM_now_version=$( curl -fs "https://desktop.docker.com/mac/main/arm64/appcast.xml" | xpath -q -e '(//rss/channel/item/enclosure/@sparkle:shortVersionString)[last()]' | cut -d '"' -f2 )
docker_INTEL_now_version=$( curl -fs "https://desktop.docker.com/mac/main/amd64/appcast.xml" | xpath -q -e '(//rss/channel/item/enclosure/@sparkle:shortVersionString)[last()]' | cut -d '"' -f2 )
Dockerersion=$(/usr/libexec/PlistBuddy -c 'print ":CFBundleShortVersionString"' /Applications/Docker.app/Contents/Info.plist)
​
​
#DATA
echo "LAST VERSION FOR ARM:$docker_ARM_now_version"
echo "LAST VERSION FOR INTEL:$docker_INTEL_now_version"
echo "THE CPU IS:$cpu"
echo "VERSION ON THIS MAC:$current_docker_version"
​
##LOGIC
​
#IF THE CPU IS ARM AND DOCKER VERSION MISSMATCH
if [ $cpu == "arm64" ] && [ "$current_docker_version" != "$docker_ARM_now_version" ];
then
	/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -title "Ledn InfoSec Team" -button1 "Update" -icon "/Library/Application Support/Ledn/ledn.png" -windowType utility -defaultButton 1 -description "Time to update your Docker Desktop. Please quit and click Update" -heading "Docker Security Update"
	open "jamfselfservice://content?entity=policy&id=157&action=view" #OPEN UPDATE POLICY
	
#IF THE CPU IS ARM AND DOCKER VERSION MISSMATCH
elif [ $cpu == "amd64" ] && [ "$current_docker_version" != "$docker_ARM_now_version" ];
then
	/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -title "Ledn InfoSec Team" -button1 "Update" -icon "/Library/Application Support/Ledn/ledn.png" -windowType utility -defaultButton 1 -description "Time to update your Docker Desktop. Please quit and click Update" -heading "Docker Security Update"
	open "jamfselfservice://content?entity=policy&id=157&action=view" #OPEN UPDATE POLICY
	
fi
