within Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.GroundHX.Examples;
model correctedBoreFieldWallTemperature
  "Test for the function correctedBoreFieldWallTemperature"
  extends Modelica.Icons.Example;

  parameter Modelica.SIunits.Temperature[:] TResSho={283.1499938964844, 284.28900146484375, 284.8553161621094, 285.1809387207031,
  285.410400390625, 285.5829772949219, 285.7174987792969, 285.8280029296875,
  285.9212951660156, 286.001953125, 286.0731506347656, 286.1373291015625,
  286.1958923339844, 286.25006103515625, 286.3002624511719, 286.3471374511719,
  286.390869140625, 286.4317626953125, 286.4700012207031, 286.5059814453125,
  286.5399169921875, 286.5720520019531, 286.6026916503906, 286.632080078125,
  286.66033935546875, 286.6869201660156, 286.71221923828125, 286.7364196777344,
  286.7595520019531, 286.78179931640625, 286.80328369140625, 286.8240661621094,
  286.84442138671875, 286.8649597167969, 286.88494873046875, 286.90435791015625,
   286.9232482910156, 286.94158935546875, 286.9593505859375, 286.9765930175781,
  286.9934387207031, 287.0100402832031, 287.0261535644531, 287.04180908203125,
  287.0570068359375, 287.0717468261719, 287.0860595703125, 287.0999450683594,
  287.11376953125, 287.1276550292969, 287.1412353515625, 287.1545715332031,
  287.1676025390625, 287.1803894042969, 287.19287109375, 287.2051086425781,
  287.2170715332031, 287.228759765625, 287.2402038574219, 287.2513427734375,
  287.2622375488281, 287.2728271484375, 287.2831726074219, 287.29339599609375,
  287.3037109375, 287.31396484375, 287.32403564453125, 287.3338928222656,
  287.3435363769531, 287.35302734375, 287.3623046875, 287.37139892578125,
  287.3802795410156, 287.38897705078125, 287.3974914550781, 287.4057922363281,
  287.4139099121094, 287.4218444824219, 287.4295654296875, 287.4374084472656,
  287.44537353515625, 287.4532165527344, 287.4609375, 287.4685363769531,
  287.4760437011719, 287.4833679199219, 287.4906005859375, 287.4977111816406,
  287.5047302246094, 287.5115966796875, 287.5183410644531, 287.52496337890625,
  287.5314636230469, 287.5378723144531, 287.5441589355469, 287.5505065917969,
  287.556884765625, 287.56317138671875, 287.5693664550781, 287.5754699707031,
  287.58148193359375, 287.5874328613281, 287.5932922363281, 287.5990295410156,
  287.604736328125, 287.6103210449219, 287.6158447265625, 287.6213073730469,
  287.62664794921875, 287.63189697265625, 287.6371154785156, 287.6423034667969,
  287.6474304199219, 287.6524963378906, 287.65753173828125, 287.6624755859375,
  287.6673583984375, 287.67218017578125, 287.67694091796875, 287.681640625,
  287.68634033203125, 287.69091796875, 287.6954650878906, 287.6999816894531,
  287.70440673828125, 287.70880126953125, 287.713134765625, 287.7174377441406,
  287.7216491699219, 287.725830078125, 287.72998046875, 287.7340393066406,
  287.73809814453125, 287.7420959472656, 287.74603271484375, 287.74993896484375,
   287.7538146972656, 287.75762939453125, 287.76141357421875, 287.7651672363281,
   287.7688903808594, 287.7725524902344, 287.77618408203125, 287.77978515625,
  287.7833251953125, 287.786865234375, 287.7903747558594, 287.7938537597656,
  287.79730224609375, 287.8006896972656, 287.8040771484375}
    "Temperatures from the short-term model up to the discrete time tBre";

  Modelica.SIunits.Temperature TWallCor
    "Temperature of the boreholes wall, corrected by the short-term model";
  Modelica.SIunits.Temperature TWallCorSteSta=CorrectedBoreFieldWallTemperature(
      t_d=integer(36000*24*365*30/gen.tStep),
      gen=gen,
      soi=soi,
      TResSho=TResSho)
    "Steady state temperature of the boreholes wall, corrected by the short-term model";

    Integer t_d;
protected
  Integer timeSca "time step size for simulation";
  Integer timeSca_old;
  Integer i "dummy variable for adaptive time step";
  Integer i_old "dummy variable for adaptive time step";

  Integer t_old(start=0) "dummy variable for adaptive time step";
  Integer t_new(start=0) "dummy variable for adaptive time step";

public
  Data.SoilData.SandStone soi "Soil parameters"
    annotation (Placement(transformation(extent={{-90,-92},{-70,-72}})));
  Data.FillingData.Bentonite fil "Filing parameters"
    annotation (Placement(transformation(extent={{-58,-92},{-38,-72}})));
  //Data.GeneralData.c8x1_h110_b5_d3600_T283
  Data.GeneralData.c1x1_h110_b5_d3600_T283 gen
    annotation (Placement(transformation(extent={{-28,-92},{-8,-72}})));
algorithm
  t_old := t_new;
  t_new := max(t_old, integer(integer(time/timeSca)*timeSca/gen.tStep));

algorithm
  when initial() then
    i := integer(2);
    i_old := i;
    timeSca := integer(gen.tStep);
    timeSca_old := timeSca;
  elsewhen sample(gen.tStep*10^1, gen.tStep*10^i/5) then
    i_old := i;
    i := i_old + 1;
    timeSca := integer(timeSca_old*2);
    timeSca_old := timeSca;
  end when;

equation
  t_d = max(t_old, integer(integer(time/timeSca)*timeSca/gen.tStep));
  TWallCor =CorrectedBoreFieldWallTemperature(
    t_d=max(t_old, integer(integer(time/timeSca)*timeSca/gen.tStep)),
    gen=gen,
    soi=soi,
    TResSho=TResSho);

  annotation (experiment(StopTime=7.2e+006, __Dymola_NumberOfIntervals=100),
      __Dymola_experimentSetupOutput, Documentation(info="<html>
        <p>Test implementation of boreFieldWallTemperature function.</p>
</html>", revisions="<html>
<ul>
<li>
July 2014, by Damien Picard:<br>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/BaseClasses/GroundHX/Examples/correctedBoreFieldWallTemperature.mos"
        "simulate and plot"));
end correctedBoreFieldWallTemperature;
