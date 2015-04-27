
############################################################################################################################################################
# This script clears up an error that stops you from updating SharePoint.          
# Source: 
#    http://blogs.technet.com/b/balasm/archive/2012/05/18/configuration-wizard-failed-an-update-conflict-has-occurred-and-you-must-re-try-this-action.aspx
# Error: 
#    Clears issue with the following error message An exception of type Microsoft.SharePoint.Administration.SPUpdatedConcurrencyException was thrown. 
#    Additional exception information: An update conflict has occurred, and you must re-try this action. The object SPUpgradeSession Name=Upgrade-########-######-###
#    was updated by XXXX\svcSP_Farm, in the PSCONFIG (5168) process, on machine APP01. View the tracing log for more information about the conflict.
###########################################################################################################################################################

stsadm -o setproperty -pn command-line-upgrade-running -pv No