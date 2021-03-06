within IBPSA.Utilities.IO.Files.BaseClasses;
model FileWriter "Partial model for writing results to a .csv file"
  extends Modelica.Blocks.Icons.DiscreteBlock;

  parameter Integer nin "Number of inputs"
    annotation(Evaluate=true, Dialog(connectorSizing=true));
  parameter String fileName = getInstanceName() + ".csv" "File name, including extension";
  parameter Modelica.SIunits.Time samplePeriod "Sample period";
  parameter String delimiter = "\t" "Delimiter for csv file"
    annotation(Dialog(tab="Advanced"));

  parameter Boolean writeHeader = true
    "=true, to write header with variable names, otherwise no header will be written"
    annotation(Dialog(tab="Advanced"));
  parameter String[nin] headerNames = {"col"+String(i) for i in 1:nin}
    "Header names, indices by default"
    annotation(Dialog(tab="Advanced"));

  Modelica.Blocks.Interfaces.RealVectorInput[nin] u "Variables that are saved"
     annotation (Placement(transformation(extent={{-120,20},{-80,-20}})));

protected
  parameter Boolean isCombiTimeTable = false
    "=true, if CombiTimeTable header should be prepended upon destruction"
    annotation(Evaluate=true);
  parameter Modelica.SIunits.Time t0(fixed=false)
    "First sample time instant";
  parameter String insNam = getInstanceName() "Instance name";
  IBPSA.Utilities.IO.Files.BaseClasses.FileWriterObject filWri=
      IBPSA.Utilities.IO.Files.BaseClasses.FileWriterObject(
        insNam,
        fileName,
        nin+1,
        isCombiTimeTable)
    "File writer object";

  discrete String str "Intermediate variable for constructing a single line";
  output Boolean sampleTrigger "True, if sample time instant";

  function writeLine
    "Prepend a string to an existing text file"
    extends Modelica.Icons.Function;
    input IBPSA.Utilities.IO.Files.BaseClasses.FileWriterObject id "ID of the file writer";
    input String string "Written string";
    input Integer isMetaData "=1, if line should not be included for row count of combiTimeTable";
    external"C" writeLine(id, string, isMetaData)
      annotation (
        Include="#include \"fileWriterStructure.h\"",
        IncludeDirectory="modelica://IBPSA/Resources/C-Sources");
  end writeLine;

initial equation
  t0 = time;


equation
  sampleTrigger = sample(t0, samplePeriod);

algorithm
  when sampleTrigger then
    str :=String(time) + delimiter;
    for i in 1:nin-1 loop
      str :=str + String(u[i]) + delimiter;
    end for;
    str :=str + String(u[nin]) + "\n";
    writeLine(filWri, str, 0);
  end when;

  annotation (
  defaultComponentName="csvWri",
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-86,-54},{90,-96}},
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="%fileName"),                                        Text(
          extent={{-86,-54},{90,-96}},
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="%fileName"),                                        Text(
          extent={{-86,-16},{90,-58}},
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="%samplePeriod")}),                         Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
May 10, 2018 by Filip Jorissen:<br/>
First implementation.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/924\">#924</a>.
</li>
</ul>
</html>",
        info="<html>
<p>
Base class for a file writer.        
See extending classes.
</p>
</html>"));
end FileWriter;
