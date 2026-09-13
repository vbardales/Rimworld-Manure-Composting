"""Packaging/localization checks. Uses installed dependency resources, never modifies them."""
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
def resources(folder):
    result={}
    for f in folder.rglob("*.xml"):
        for e in ET.parse(f).getroot():
            if not isinstance(e.tag,str):continue
            check(e.tag not in result, f"unique resource {e.tag}")
            check(bool(e.text and e.text.strip()), f"nonempty {e.tag}")
            result[e.tag]=e.text
    return result
for f in (ROOT/"Mod").rglob("*.xml"): ET.parse(f)
print("PASS all distributed XML parses")
fr=resources(ROOT/"Mod/Languages/French/DefInjected")
owned={}
for f in (ROOT/"Mod/Defs").rglob("*.xml"):
    for d in ET.parse(f).getroot():
        name=d.findtext("defName")
        for field in ("label","description","verb","gerund"):
            value=d.findtext(field)
            if value:owned[f"{name}.{field}"]=value
check(len(owned)==9,"nine owned Def fields inventoried")
for key,value in owned.items():
    check(key in fr, f"French covers {key}")
    check(fr[key].count(r"\n")==value.count(r"\n"),f"line breaks match {key}")
en=resources(ROOT/"Mod/Languages/English/Keyed")
fk=resources(ROOT/"Mod/Languages/French/Keyed")
check(set(en)==set(fk),"Keyed languages have identical coverage")
for key in en:
    check(re.findall(r"\{[^{}]+\}",en[key])==re.findall(r"\{[^{}]+\}",fk[key]),f"parameters match {key}")
for f in (ROOT/"Source").glob("*.cs"):
    for key in re.findall(r'"(MC_[^"]+)"\.Translate',f.read_text(encoding="utf-8-sig")):
        check(key in en and key in fk,f"source key resolves {key}")
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
    check(data[:8]==b"\x89PNG\r\n\x1a\n",f"{filename} PNG signature")
    check(struct.unpack(">II",data[16:24])==size,f"{filename} dimensions")
    check(len(data)<1000000,f"{filename} below 1 MB")
for name in ["LICENSE","ATTRIBUTION.md"]:
    check((ROOT/name).read_bytes()==(ROOT/"Mod"/name).read_bytes(),f"distributed {name} matches")
check([p.name for p in (ROOT/"Mod/Assemblies").glob("*.dll")]==["ManureComposting.dll"],"no dependency DLL redistribution")
print(f"{checks} packaging and localization checks passed; no in-game display claim.")

