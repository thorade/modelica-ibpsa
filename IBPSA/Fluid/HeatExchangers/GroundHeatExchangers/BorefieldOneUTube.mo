within IBPSA.Fluid.HeatExchangers.GroundHeatExchangers;
model BorefieldOneUTube
  extends IBPSA.Fluid.HeatExchangers.GroundHeatExchangers.BaseClasses.partialBorefield;
  IBPSA.Fluid.HeatExchangers.GroundHeatExchangers.Boreholes.BoreholeOneUTube borHol(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal,
    borFieDat=borFieDat,
    allowFlowReversal=allowFlowReversal,
    m_flow_small=m_flow_small,
    show_T=show_T,
    computeFlowResistance=computeFlowResistance,
    from_dp=from_dp,
    linearizeFlowResistance=linearizeFlowResistance,
    deltaM=deltaM,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    p_start=p_start,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    C_nominal=C_nominal,
    mSenFac=mSenFac,
    dynFil=dynFil) "Borehole"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
equation
  connect(borHol.port_b, masFloMul.port_a)
    annotation (Line(points={{20,0},{40,0},{60,0}}, color={0,127,255}));
  connect(borHol.port_a, masFloDiv.port_a)
    annotation (Line(points={{-20,0},{-60,0}}, color={0,127,255}));
  connect(theCol.port_a, borHol.port_wall) annotation (Line(points={{-20,60},{-10,
          60},{0,60},{0,20}}, color={191,0,0}));
end BorefieldOneUTube;
