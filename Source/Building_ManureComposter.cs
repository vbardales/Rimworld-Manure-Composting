using System.Collections.Generic;
using DubsBadHygiene;
using Verse;

namespace ManureComposting
{
    /// <summary>Corrects inherited text without replacing DBH's composting or save logic.</summary>
    public class Building_ManureComposter : Building_Composter
    {
        public override string GetInspectString()
        {
            string text = base.GetInspectString();
            if (!Fermented)
            {
                int count = MaxCapacity - SpaceLeftForCompostingMaterial;
                // DBH's base string names sewage even when its configured input is manure.
                text = text.Replace("ContainsFecalSludge".Translate(count, MaxCapacity).ToString(),
                    "MC_ContainsManure".Translate(count, MaxCapacity).ToString());
            }
            return text;
        }

        public override IEnumerable<Gizmo> GetGizmos()
        {
            foreach (Gizmo gizmo in base.GetGizmos())
            {
                // Translate only this upstream development control, retaining its action.
                if (gizmo is Command command && command.defaultLabel == "Debug: Set progress to 1")
                    command.defaultLabel = "MC_DebugFinishComposting".Translate();
                yield return gizmo;
            }
        }
    }
}
