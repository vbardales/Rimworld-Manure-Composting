using DubsBadHygiene;
using Verse;

namespace ManureComposting
{
    /// <summary>
    /// Lets pawns load the manure composter, using Dubs Bad Hygiene's own filling behaviour.
    /// </summary>
    /// <remarks>
    /// The whole of the work is inherited. DBH's <see cref="WorkGiver_FillComposter"/> already
    /// finds the right input by asking the building itself -
    /// <c>ThingRequest.ForDef(barrel.ThingDefToCompost_PatchMe())</c> - checks the temperature
    /// band from the building's own CompProperties_TemperatureRuinable, refuses a burning or
    /// deconstruction-marked target, and issues DBH's LoadComposter job. None of that is
    /// def-specific.
    ///
    /// The single thing that is: <c>PotentialWorkThingRequest</c> returns
    /// <c>ThingRequest.ForDef(DubDef.BiosolidsComposter)</c>, which is what stops a pawn ever
    /// seeing a second composter. Overriding that one property is the entire mod.
    /// </remarks>
    public class WorkGiver_FillManureComposter : WorkGiver_FillComposter
    {
        public override ThingRequest PotentialWorkThingRequest =>
            ThingRequest.ForDef(ManureCompostingDefs.ManureComposter);
    }

    /// <summary>
    /// Lets pawns empty the manure composter, using Dubs Bad Hygiene's own emptying behaviour.
    /// </summary>
    /// <remarks>
    /// Same shape as <see cref="WorkGiver_FillManureComposter"/>: DBH's
    /// <see cref="WorkGiver_UnloadComposter"/> only ever asks whether the target is a finished
    /// <c>Building_Composter</c> that is reservable and not on fire, then issues the
    /// UnloadComposter job. The product comes from <c>ThingDefToProduce_PatchMe()</c>, so it is
    /// this mod's biosolids rather than DBH's by virtue of the def alone.
    /// </remarks>
    public class WorkGiver_UnloadManureComposter : WorkGiver_UnloadComposter
    {
        public override ThingRequest PotentialWorkThingRequest =>
            ThingRequest.ForDef(ManureCompostingDefs.ManureComposter);
    }
}
