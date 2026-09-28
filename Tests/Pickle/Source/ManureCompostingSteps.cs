using System;
using System.Linq;
using System.Threading.Tasks;
using DubsBadHygiene;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace ManureComposting.PickleSteps
{
    /// <summary>
    /// Steps that read and drive Dubs Bad Hygiene's composter through its own public surface.
    /// They only observe what a running game can show: pawns finding the second composter, the inspect
    /// text, the development control and the architect dropdown. Every text carries the mod's name, since
    /// Pickle puts the steps of all installed suites in one namespace.
    /// </summary>
    [PickleSteps]
    public sealed class ManureCompostingSteps
    {
        private const string ComposterDef = "Nelim_ManureComposter";
        private const string DropdownDef = "Nelim_Composters";

        private static Map CurrentMap(PickleContext ctx)
        {
            var map = Find.CurrentMap;
            ctx.Require(map != null, "there is no current map: load a save first");
            return map;
        }

        private static Building_Composter ComposterAt(PickleContext ctx, int x, int y)
        {
            var map = CurrentMap(ctx);
            var cell = new IntVec3(x, 0, y);
            ctx.Require(cell.InBounds(map), "cell (" + x + ", " + y + ") is outside the map");
            var composter = cell.GetThingList(map).OfType<Building_Composter>().FirstOrDefault(b => b.def.defName == ComposterDef);
            ctx.Require(composter != null, "no " + ComposterDef + " at (" + x + ", " + y + "); things there: "
                + string.Join(", ", cell.GetThingList(map).Select(t => t.def.defName).ToArray()));
            return composter;
        }

        private static int Held(Building_Composter composter)
        {
            // DBH exposes the free space, not the count, and reports no space once composted.
            return composter.Fermented ? -1 : Building_Composter.MaxCapacity - composter.SpaceLeftForCompostingMaterial;
        }

        private static string Describe(Building_Composter composter)
        {
            return "fermented=" + composter.Fermented + ", space left=" + composter.SpaceLeftForCompostingMaterial
                + ", progress=" + composter.Progress.ToString("0.###");
        }

        [Given("Manure Composting: {int} manure lies at \\({int}, {int}\\)")]
        public void ManureLiesAt(PickleContext ctx, int count, int x, int y)
        {
            var map = CurrentMap(ctx);
            var def = DefDatabase<ThingDef>.GetNamedSilentFail("Manure");
            ctx.Require(def != null, "the def Manure is not loaded: Burok's Manure is a hard dependency");
            ctx.Require(count > 0 && count <= def.stackLimit, "a stack of Manure holds 1 to " + def.stackLimit + ", not " + count);
            var cell = new IntVec3(x, 0, y);
            ctx.Require(cell.InBounds(map) && cell.Walkable(map), "cell (" + x + ", " + y + ") cannot hold manure");
            var manure = ThingMaker.MakeThing(def);
            manure.stackCount = count;
            GenSpawn.Spawn(manure, cell, map);
        }

        [Then("Manure Composting: the composter at \\({int}, {int}\\) holds {int} manure", TimeoutSeconds = 45f)]
        public async Task ComposterHolds(PickleContext ctx, int x, int y, int expected)
        {
            // A pawn walks, hauls and works before the composter fills: give the game time, in real seconds.
            await ctx.AssertEventually(
                () => Held(ComposterAt(ctx, x, y)) == expected,
                () => "composter at (" + x + ", " + y + ") does not hold " + expected + " manure: " + Describe(ComposterAt(ctx, x, y)),
                40f);
        }

        [Then("Manure Composting: the composter at \\({int}, {int}\\) is finished", TimeoutSeconds = 10f)]
        public async Task ComposterFinished(PickleContext ctx, int x, int y)
        {
            await ctx.AssertEventually(
                () => ComposterAt(ctx, x, y).Fermented,
                () => "composter at (" + x + ", " + y + ") is not composted: " + Describe(ComposterAt(ctx, x, y)),
                8f);
        }

        [Then("Manure Composting: the composter at \\({int}, {int}\\) is empty", TimeoutSeconds = 45f)]
        public async Task ComposterEmpty(PickleContext ctx, int x, int y)
        {
            await ctx.AssertEventually(
                () =>
                {
                    var c = ComposterAt(ctx, x, y);
                    return !c.Fermented && c.SpaceLeftForCompostingMaterial == Building_Composter.MaxCapacity;
                },
                () => "composter at (" + x + ", " + y + ") is not empty: " + Describe(ComposterAt(ctx, x, y)),
                40f);
        }

        [Then("Manure Composting: the map ends up holding {int} {string}", TimeoutSeconds = 45f)]
        public async Task MapHolds(PickleContext ctx, int expected, string defName)
        {
            var map = CurrentMap(ctx);
            var def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, "no ThingDef named " + defName);
            Func<int> total = () => map.listerThings.ThingsOfDef(def).Sum(t => t.stackCount);
            await ctx.AssertEventually(
                () => total() == expected,
                () => "the map holds " + total() + " " + defName + ", expected " + expected,
                40f);
        }

        [When("Manure Composting: the development control finishes the composter at \\({int}, {int}\\)")]
        public void FinishWithDevelopmentControl(PickleContext ctx, int x, int y)
        {
            var composter = ComposterAt(ctx, x, y);
            ctx.Require(Prefs.DevMode, "development mode is off: DBH offers its control only in development mode");
            var label = "MC_DebugFinishComposting".Translate().ToString();
            var gizmos = composter.GetGizmos().OfType<Command_Action>().ToList();
            var control = gizmos.FirstOrDefault(g => g.defaultLabel == label);
            ctx.Assert(control != null, "no development control labelled \"" + label + "\" on the composter; labels: "
                + string.Join(" | ", gizmos.Select(g => g.defaultLabel).ToArray()));
            ctx.Attach("development-control-label", label);
            control.action();
            ctx.Assert(composter.Fermented, "the development control ran but the composter is not composted: " + Describe(composter));
        }

        [Then("Manure Composting: the inspect text of the composter at \\({int}, {int}\\) names manure {int} of {int}")]
        public void InspectNamesManure(PickleContext ctx, int x, int y, int count, int capacity)
        {
            var text = ComposterAt(ctx, x, y).GetInspectString();
            var manureLine = "MC_ContainsManure".Translate(count, capacity).ToString();
            var sludgeLine = "ContainsFecalSludge".Translate(count, capacity).ToString();
            ctx.Attach("inspect-text", text);
            ctx.Assert(text.Contains(manureLine), "the inspect text does not contain \"" + manureLine + "\":\n" + text);
            ctx.Assert(!text.Contains(sludgeLine), "the inspect text still says \"" + sludgeLine + "\":\n" + text);
        }

        [When("Manure Composting: I select the composter at \\({int}, {int}\\) and look at it")]
        public async Task SelectAndLook(PickleContext ctx, int x, int y)
        {
            var composter = ComposterAt(ctx, x, y);
            Find.Selector.ClearSelection();
            Find.Selector.Select(composter, false, false);
            Find.CameraDriver.JumpToCurrentMapLoc(composter.Position);
            await ctx.WaitFrames(5);
        }

        [Then("Manure Composting: the Hygiene architect tab offers one dropdown holding both composters")]
        public void HygieneDropdownHoldsBoth(PickleContext ctx)
        {
            var category = DefDatabase<DesignationCategoryDef>.GetNamedSilentFail("Hygiene");
            ctx.Require(category != null, "the Hygiene designation category is not loaded: Dubs Bad Hygiene is a hard dependency");
            var dropdowns = category.AllResolvedDesignators.OfType<Designator_Dropdown>().ToList();
            var holders = dropdowns
                .Where(d => d.Elements.OfType<Designator_Build>().Any(b => b.PlacingDef != null && b.PlacingDef.defName == ComposterDef))
                .ToList();
            ctx.Assert(holders.Count == 1, holders.Count + " dropdowns of the Hygiene tab hold " + ComposterDef + ", expected 1; dropdowns: "
                + string.Join(" | ", dropdowns.Select(d => string.Join(",", d.Elements.OfType<Designator_Build>().Select(b => b.PlacingDef.defName).ToArray())).ToArray()));
            var members = holders[0].Elements.OfType<Designator_Build>().Select(b => b.PlacingDef.defName).ToList();
            ctx.Assert(members.Contains("BiosolidsComposter"), "the dropdown holding " + ComposterDef + " does not hold DBH's BiosolidsComposter: " + string.Join(", ", members.ToArray()));
            ctx.Assert(members.Count == 2, "the dropdown holds " + members.Count + " buildings, expected exactly the two composters: " + string.Join(", ", members.ToArray()));
            ctx.Assert(DefDatabase<DesignatorDropdownGroupDef>.GetNamedSilentFail(DropdownDef) != null, "the dropdown group def " + DropdownDef + " is not loaded");
        }
    }
}
