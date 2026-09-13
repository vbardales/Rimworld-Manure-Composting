using System;
using System.Collections.Generic;
using System.IO;
using System.Xml;
namespace Verse {
 public class Gizmo {}
 public class Command : Gizmo { public string defaultLabel; public Action action; }
 public static class TestTranslations {
  public static Dictionary<string,string> Values = new Dictionary<string,string>();
  public static string Translate(this string key, params object[] args) {
   return string.Format(Values[key], args);
  }
 }
}
namespace DubsBadHygiene {
 public class Building_Composter {
  public const int MaxCapacity=250;
  public bool Fermented;
  public int SpaceLeftForCompostingMaterial;
  public string TestInspect;
  public List<Verse.Gizmo> TestGizmos=new List<Verse.Gizmo>();
  public virtual string GetInspectString(){return TestInspect;}
  public virtual IEnumerable<Verse.Gizmo> GetGizmos(){return TestGizmos;}
 }
}
public static class TextAdapterTests {
 static int checks;
 static void Check(bool condition,string name){if(!condition)throw new Exception(name);checks++;Console.WriteLine("PASS "+name);}
 public static void Run(string root,string workshop){
  foreach(string language in new[]{"English","French"}){
   Verse.TestTranslations.Values.Clear();
   foreach(string file in new[]{
    Path.Combine(workshop,"836308268/1.6/Languages",language,"Keyed/DubsHygiene.xml"),
    Path.Combine(root,"Mod/Languages",language,"Keyed/ManureComposting.xml")}){
    var doc=new XmlDocument();doc.Load(file);
    foreach(XmlNode n in doc.DocumentElement.ChildNodes)if(n.NodeType==XmlNodeType.Element)Verse.TestTranslations.Values[n.Name]=n.InnerText;
   }
   var building=new ManureComposting.Building_ManureComposter();
   foreach(int count in new[]{0,1,249,250}){
    building.Fermented=false;building.SpaceLeftForCompostingMaterial=250-count;
    string original=string.Format(Verse.TestTranslations.Values["ContainsFecalSludge"],count,250);
    building.TestInspect="before\n"+original+"\nafter";
    Check(building.GetInspectString()=="before\n"+string.Format(Verse.TestTranslations.Values["MC_ContainsManure"],count,250)+"\nafter",language+" manure quantity "+count+" and unrelated lines preserved");
   }
   building.Fermented=true;building.TestInspect="finished";
   Check(building.GetInspectString()=="finished",language+" finished content unchanged");
   building.Fermented=false;building.TestInspect="minified";
   Check(building.GetInspectString()=="minified",language+" no invented line on minified/empty base text");
   bool called=false;
   var debug=new Verse.Command{defaultLabel="Debug: Set progress to 1",action=()=>called=true};
   var other=new Verse.Command{defaultLabel="other"};
   building.TestGizmos.Add(debug);building.TestGizmos.Add(other);
   var output=new List<Verse.Gizmo>(building.GetGizmos());
   Check(output.Count==2 && Object.ReferenceEquals(output[0],debug) && Object.ReferenceEquals(output[1],other),language+" gizmos and order preserved");
   Check(debug.defaultLabel==Verse.TestTranslations.Values["MC_DebugFinishComposting"],language+" development label translated");
   Check(other.defaultLabel=="other",language+" unrelated command unchanged");
   debug.action();Check(called,language+" development action preserved");
  }
  Console.WriteLine(checks+" text-adapter checks passed against a DBH base test double; no game UI claim.");
 }
}
