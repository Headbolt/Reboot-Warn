#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	Reboot-Warn.sh
#	https://github.com/Headbolt/Reboot-Warn
#
#   This Script is designed for use in JAMF
#
#   - This script will ...
#			Grab the current and last reboot time ( in Epoch Time ) convert it to a number of days since last reboot.
#			Then display this a daily warning message with a reccomendation to reboot.
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.0 - 01/10/2024
#
#	- 01/10/2024 - V1.0 - Created by Headbolt
#
###############################################################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
###############################################################################################################################################
#
BootTime=$(sysctl kern.boottime | awk -F'[= |,]' '{print $6}') # Grab Last boot time and pull out the "Epoch Time"
CurrentTime=$(date +%s) # Grab current time and pull out the "Epoch Time"
TimeSinceBoot=$(($CurrentTime - $BootTime)) # Subtract to get time since last boot
#
# Convert To Days and set.
#
Message="Your device has not been rebooted in $(($TimeSinceBoot / 216000)) day(s).

For optimal performance and stability, we recommend restarting your device soon.

Ideally, restart at least once a week."
#
ScriptName="MacOS | Reboot Reminder" # Set the name of the script for later logging
ExitCode=0 # Set Initial ExitCode
#
###############################################################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
###############################################################################################################################################
#
# Defining Functions
#
###############################################################################################################################################
#
# Section End Function
#
SectionEnd(){
#
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo  ----------------------------------------------- # Outputting a Dotted Line for Reporting Purposes
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
}
#
###############################################################################################################################################
#
# Script End Function
#
ScriptEnd(){
#
/bin/echo Ending Script '"'$ScriptName'"'
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo  ----------------------------------------------- # Outputting a Dotted Line for Reporting Purposes
/bin/echo # Outputting a Blank Line for Reporting Purposes
exit $ExitCode
#
}
#
###############################################################################################################################################
#
# End Of Function Definition
#
###############################################################################################################################################
#
# Beginning Processing
#
###############################################################################################################################################
#
/bin/echo # Outputting a Blank Line for Reporting Purposes
SectionEnd
#
/bin/echo 'Displaying Message .....'
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo '"'
/bin/echo "$Message"
/bin/echo '"'
#
/usr/local/bin/jamf displayMessage -message "$Message" # Display message.
#
SectionEnd
ScriptEnd
