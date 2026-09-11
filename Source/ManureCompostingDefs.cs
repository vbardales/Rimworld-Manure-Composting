using Verse;

namespace ManureComposting
{
    /// <summary>
    /// Resolves the composter ThingDef on first use and caches it.
    /// </summary>
    /// <remarks>
    /// Deliberately not a <c>[DefOf]</c> class. The ThingDef carries
    /// <c>MayRequire="Dubwise.DubsBadHygiene,Burok.Manure"</c>, so it is absent unless both mods
    /// are active, and the C# attribute cannot express that: <c>DefOfHelper.BindDefsFor</c> passes
    /// <c>MayRequireAttribute.modId</c> whole to <c>ModsConfig.IsActive</c> without splitting on
    /// commas, so <c>[MayRequire("A,B")]</c> asks for a mod literally named "A,B" and is never
    /// satisfied. Only the XML attribute takes a list. A DefOf field would therefore be either
    /// permanently unbound or a startup error, depending on which attribute was used.
    ///
    /// The lookup is safe because the WorkGiverDefs carry the same XML MayRequire: when the
    /// ThingDef is absent the WorkGiverDefs are absent too, and these WorkGivers are never built.
    /// </remarks>
    internal static class ManureCompostingDefs
    {
        private static ThingDef manureComposter;
        private static bool resolved;

        internal static ThingDef ManureComposter
        {
            get
            {
                if (!resolved)
                {
                    manureComposter = DefDatabase<ThingDef>.GetNamedSilentFail("Nelim_ManureComposter");
                    resolved = true;
                }

                return manureComposter;
            }
        }
    }
}
