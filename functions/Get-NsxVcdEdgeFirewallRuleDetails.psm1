Function Get-NsxVcdEdgeFirewallRuleDetails {
    <#
    .DESCRIPTION
        Returnes Details of a Firewall Rule of the Edge Gatway.

        Note:
        Only User Rules can be displayed

    .NOTES
        File Name  : Get-NsxVcdEdgeFirewallRuleDetails.ps1
        Author     : Markus Kraus
        Version    : 1.0
        State      : Ready

    .LINK
        https://mycloudrevolution.com/

    .EXAMPLE
       Get-NsxVcdEdgeFirewallRuleDetails -Id EdgeId  -RuleId FirewallRuleId

    .EXAMPLE
        Get-NsxVcdEdge | Get-NsxVcdEdgeFirewallRuleDetails -RuleId FirewallRuleId

    .PARAMETER Id
        Id of the Edge Gateway

        Note:
        You can list all Ids of your edges by: 'Get-NsxVcdEdge | select Name, datacenterName, Id'

    .PARAMETER RuleId
        RuleId of the Firewall Rule

    #>
        Param (
            [Parameter(Mandatory=$True, ValueFromPipelineByPropertyName=$True, ValueFromPipeline=$True, HelpMessage="Id of the Edge Gateway")]
            [ValidateNotNullorEmpty()]
                [String] $Id,
            [Parameter(Mandatory=$True, ValueFromPipeline=$False, HelpMessage="RuleId of the Firewall Rule")]
            [ValidateNotNullorEmpty()]
                [Long] $RuleId
        )
        Process {

            [XML]$Rule = Invoke-NsxVcdApiCall -Uri "/network/edges/$Id/firewall/config/rules/$RuleId" -Method "Get"

            "Summary:"
            "--------"
            $Rule.firewallRule | Select-Object id, ruleTag, name, ruleType, enabled, loggingEnabled, action |  Format-List

            "Source:"
            "-------"
            $Rule.firewallRule.source | Format-List

            "Destination:"
            "------------"
            $Rule.firewallRule.destination | Format-List

            "Application-Service:"
            "--------------------"
            $Rule.firewallRule.application.service | Format-List
        }
    }
