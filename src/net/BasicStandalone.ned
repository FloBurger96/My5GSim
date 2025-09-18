package net;

import inet.node.inet.StandardHost;
import inet.common.scenario.ScenarioManager;

import simu5g.common.binder.Binder;          // globales Register
import simu5g.nodes.NR.gNodeB;               // 5G gNB
import simu5g.nodes.NR.NRUe;                 // 5G UE
import simu5g.nodes.Upf;                     // 5GC User Plane Function

network BasicStandalone
{
    parameters:
        @display("bgb=900,500");
    submodules:
        binder: Binder {
            @display("p=60,60;i=block/table2");
        }
        upf: Upf {
            @display("p=760,250");
        }
        gnb: gNodeB {
            parameters:
                // SA: gNB direkt an UPF
                upfModule = default("^.upf");   // seit 1.3 via NED-Param referenzierbar
            @display("p=400,250");
        }
        ue: NRUe {
            @display("p=220,380");
        }
        host: StandardHost {
            @display("p=880,380");
        }
        scenario: ScenarioManager {
            @display("p=80,440");
        }
    connections allowunconnected:
        // IP-Kopplung: gNB <-> UPF <-> Host (IP)
        gnb.pppg++ <--> upf.ethg++;
        upf.ethg++ <--> host.ethg++;
        // UE funkt drahtlos über gNB; keine Draht-Verbindung nötig
}
