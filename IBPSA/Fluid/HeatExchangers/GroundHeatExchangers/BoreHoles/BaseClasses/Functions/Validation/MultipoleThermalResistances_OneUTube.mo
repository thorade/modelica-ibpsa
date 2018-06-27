within IBPSA.Fluid.HeatExchangers.GroundHeatExchangers.Boreholes.BaseClasses.Functions.Validation;
model MultipoleThermalResistances_OneUTube
  "Validation of the thermal resitances for a single U-tube borehole"
  extends Modelica.Icons.Example;

  parameter Integer nPip=2 "Number of pipes";
  parameter Integer J=3 "Number of multipoles";
  parameter Modelica.SIunits.Position[nPip] xPip={0.03, -0.03}
    "x-Coordinates of pipes";
  parameter Modelica.SIunits.Position[nPip] yPip={0.00, 0.02}
    "y-Coordinates of pipes";
  parameter Modelica.SIunits.Radius rBor=0.07 "Borehole radius";
  parameter Modelica.SIunits.Radius[nPip] rPip=fill(0.02, nPip)
    "Outter radius of pipes";
  parameter Modelica.SIunits.ThermalConductivity kGro=1.5
    "Thermal conductivity of grouting material";
  parameter Modelica.SIunits.ThermalConductivity kSoi=2.5
    "Thermal conductivity of soil material";
  parameter Modelica.SIunits.ThermalInsulance[nPip] RFluPip=
    fill(1.2/(2*Modelica.Constants.pi*kGro), nPip)
    "Fluid to pipe wall thermal resistances";
  parameter Modelica.SIunits.Temperature TBor=0
    "Average borehole wall temperature";

  parameter Modelica.SIunits.ThermalInsulance[nPip,nPip] RDelta_Ref=
    {{1/3.680, 1/0.242},{1/0.242, 1/3.724}}
    "Reference delta-circuit thermal resistances";
  parameter Modelica.SIunits.ThermalInsulance[nPip,nPip] R_Ref=
    {{0.25592, 0.01561},{0.01561, 0.25311}}
    "Reference internal thermal resistances";

  Modelica.SIunits.ThermalInsulance[nPip,nPip] RDelta
    "Delta-circuit thermal resistances";
  Modelica.SIunits.ThermalInsulance[nPip,nPip] R
    "Internal thermal resistances";

equation
  (RDelta, R) = IBPSA.Fluid.HeatExchangers.GroundHeatExchangers.Boreholes.BaseClasses.Functions.multipoleThermalResistances(
    nPip, J, xPip, yPip, rBor, rPip, kGro, kSoi, RFluPip, TBor);

  annotation (
    __Dymola_Commands(file=
          "modelica://IBPSA/Resources/Scripts/Dymola/Fluid/HeatExchangers/GroundHeatExchangers/Boreholes/BaseClasses/Functions/Validation/MultipoleThermalResistances_OneUTube.mos"
        "Simulate and plot"),
    experiment(Tolerance=1e-6, StopTime=1.0),
    Documentation(info="<html>
<p>
This example validates the implementation of
<a href=\"modelica://IBPSA.Fluid.HeatExchangers.GroundHeatExchangers.Boreholes.BaseClasses.Functions.multipoleThermalResistances\">
IBPSA.Fluid.HeatExchangers.GroundHeatExchangers.Boreholes.BaseClasses.Functions.multipoleThermalResistances</a>
for the evaluation of the borehole thermal resistances.
</p>
<p>
The multipole method is used to evaluate thermal resistances for a single U-tube
borehole with asymmetrically positionned pipes. Results are compared to
reference values given in Claesson and Hellstr&ouml;m (2011).
</p>
<h4>References</h4>
<p>
Claesson, J., &amp; Hellstr&ouml;m, G. (2011). Multipole method to calculate
borehole thermal resistances in a borehole heat exchanger. <i>HVAC&amp;R
Research, 17</i>(6), 895-911.
</p>
</html>", revisions="<html>
<ul>
<li>
June 21, 2018, by Massimo Cimmino:<br/>
First implementation.
</li>
</ul>
</html>"));
end MultipoleThermalResistances_OneUTube;