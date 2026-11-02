"""Exact values and fixtures of this mod that no shared check holds. Generic parts (XML parse, duplicate defNames,
French coverage, line breaks, parameter tokens, source keys, PNG validity, licence copies) are run by
scripts/Check-ModBasics.ps1 and scripts/Check-Translations.ps1. Uses installed dependency resources, never modifies them."""
from pathlib import Path
import re, struct, tarfile, xml.etree.ElementTree as ET
ROOT=Path(__file__).resolve().parents[1]
WORKSHOP=Path("C:/Program Files (x86)/Steam/steamapps/workshop/content/294100")
GAME=Path("C:/Program Files (x86)/Steam/steamapps/common/RimWorld/Data/Core")
checks=0
def check(ok,message):
    global checks
    assert ok,message
    checks+=1
    print("PASS",message)
fr={}
for f in (ROOT/"Mod/Languages/French/DefInjected").rglob("*.xml"):
    for e in ET.parse(f).getroot():
        if isinstance(e.tag,str):fr[e.tag]=e.text
owned=0
for f in (ROOT/"Mod/Defs").rglob("*.xml"):
    for d in ET.parse(f).getroot():
        owned+=sum(1 for field in ("label","description","verb","gerund") if d.findtext(field))
check(owned==9,"nine owned Def fields inventoried")
# Explicitly traced dependency keys used by the inherited building and WorkGivers.
keys=["ContainsCompost","ContainsFecalSludge","Composted","CompostingProgress","ComposterOutOfIdealTemperature","IdealCompostingTemperature","NoCompostingMaterial"]
dep={}
for lang in ("English","French"):
    dep[lang]={}
    for f in (WORKSHOP/f"836308268/1.6/Languages/{lang}/Keyed").rglob("*.xml"):
        for e in ET.parse(f).getroot():dep[lang][e.tag]=e.text or ""
for key in keys:
    check(bool(dep["English"].get(key)) and bool(dep["French"].get(key)),f"inherited key EN/FR {key}")
    check(re.findall(r"\{[^{}]+\}",dep["English"][key])==re.findall(r"\{[^{}]+\}",dep["French"][key]),f"inherited parameters {key}")
vanilla_en={}
for f in (GAME/"Languages/English/Keyed").rglob("*.xml"):
    for e in ET.parse(f).getroot():vanilla_en[e.tag]=e.text or ""
vanilla_fr={}
with tarfile.open(next((GAME/"Languages").glob("French*.tar"))) as tar:
    for member in tar:
        if "/Keyed/" in "/"+member.name and member.name.endswith(".xml"):
            for e in ET.fromstring(tar.extractfile(member).read()):vanilla_fr[e.tag]=e.text or ""
for key in ["Temperature","BadTemperature","RuinedByTemperature","Overheating","Freezing"]:
    check(bool(vanilla_en.get(key)) and bool(vanilla_fr.get(key)),f"inherited vanilla key EN/FR {key}")
for name in ["LoadComposter","UnloadComposter"]:
    source=None
    for f in (WORKSHOP/"836308268/1.6/Defs").rglob("*.xml"):
        for d in ET.parse(f).getroot():
            if d.tag=="JobDef" and d.findtext("defName")==name:source=d.findtext("reportString")
    check(bool(source),f"DBH English job exists {name}")
    check(re.findall(r"Target[A-Z]",source)==re.findall(r"Target[A-Z]",fr[name+".reportString"]),f"job target token {name}")
about=ET.parse(ROOT/"Mod/About/About.xml").getroot()
url="https://github.com/vbardales/Rimworld-Manure-Composting"
check(about.findtext("description").rstrip().endswith(f"[url={url}]Source code on GitHub[/url]"),"description ends with exact repository link")
check(about.findtext("url")==url,"About URL matches description")
for filename,size in [("ModIcon.png",(128,128)),("Preview.png",(896,504))]:
    data=(ROOT/"Mod/About"/filename).read_bytes()
    check(struct.unpack(">II",data[16:24])==size,f"{filename} dimensions")
check([p.name for p in (ROOT/"Mod/Assemblies").glob("*.dll")]==["ManureComposting.dll"],"no dependency DLL redistribution")
# settings_audit: not_applicable. The mod exposes no settings page and no main-bar shortcut, so neither an empty
# page nor a greyed or visible shortcut can exist. Source and definitions are scanned, not assumed.
distributed_xml="\n".join(f.read_text(encoding="utf-8") for f in (ROOT/"Mod").rglob("*.xml"))
check("MainButtonDef" not in distributed_xml,"no MainButtonDef in the distributed XML")
source_text="\n".join(f.read_text(encoding="utf-8") for f in (ROOT/"Source").glob("*.cs"))
check(not re.search(r"\bModSettings\b|:\s*Mod\b|DoSettingsWindowContents|SettingsCategory",source_text),"no settings class or settings window in the source")
check(about.find("incompatibleWith") is None,"no incompatibility is declared, so no incompatibility pass is owed")
print(f"{checks} exact-value checks passed; no in-game display claim.")
