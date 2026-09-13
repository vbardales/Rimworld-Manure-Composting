const fs = require('fs');
const path = require('path');
const http = require('http');
const { chromium } = require('playwright');
const sharp = require('sharp');
const root=path.resolve(__dirname,'..');
(async()=>{
fs.mkdirSync(path.join(root,'.build/audit'),{recursive:true});
const server=http.createServer((req,res)=>{
  const name=decodeURIComponent(req.url.split('?')[0]).replace(/^\//,'');
  if(!['preview.html','preview-palette.json','Preview.png'].includes(name)){res.writeHead(404);res.end();return;}
  res.setHeader('Content-Type',name.endsWith('.html')?'text/html; charset=utf-8':name.endsWith('.json')?'application/json':'image/png');
  res.end(fs.readFileSync(path.join(__dirname,name)));
});
await new Promise(r=>server.listen(0,'127.0.0.1',r));
let browser;
try{
 browser=await chromium.launch({executablePath:process.env.CHROME_PATH||'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true});
 const page=await browser.newPage({viewport:{width:896,height:504},deviceScaleFactor:1});
 await page.goto('http://127.0.0.1:'+server.address().port+'/preview.html');
 await page.evaluate(()=>window.ready);
 await page.locator('.scene').evaluate(async el=>{const i=new Image();i.src='Preview.png';await i.decode();});
 const qa=await page.evaluate(()=>({font:document.fonts.check('600 46px "Segoe UI"'),boxes:['h1','p','.version'].map(s=>{let r=document.querySelector(s).getBoundingClientRect();return {selector:s,x:r.x,y:r.y,width:r.width,height:r.height}})}));
 const out=path.join(root,'Mod/About/Preview.png');
 await page.screenshot({path:out});
 await page.locator('.copy').evaluate(el=>el.style.visibility='hidden');
 await page.screenshot({path:path.join(root,'.build/audit/preview-background.png')});
 const p=JSON.parse(fs.readFileSync(path.join(__dirname,'preview-palette.json'),'utf8').replace(/^\uFEFF/,''));
 const {data,info}=await sharp(path.join(root,'.build/audit/preview-background.png')).removeAlpha().raw().toBuffer({resolveWithObject:true});
 const lum=c=>c.map(v=>v/255).map(v=>v<=.04045?v/12.92:((v+.055)/1.055)**2.4).reduce((s,v,i)=>s+v*[.2126,.7152,.0722][i],0);
 const ink=lum(p.inkPrimary.match(/[0-9a-f]{2}/gi).map(h=>parseInt(h,16)));
 qa.contrast=qa.boxes.slice(0,2).map(b=>{let min=Infinity;for(let y=Math.floor(b.y);y<Math.ceil(b.y+b.height);y++)for(let x=Math.floor(b.x);x<Math.ceil(b.x+b.width);x++){const i=(y*info.width+x)*info.channels;const l=lum([...data.subarray(i,i+3)]);min=Math.min(min,(Math.max(ink,l)+.05)/(Math.min(ink,l)+.05));}return {selector:b.selector,min};});
 const badge=lum(p.badgeInk.match(/[0-9a-f]{2}/gi).map(h=>parseInt(h,16)));
 const accent=lum(p.accent.match(/[0-9a-f]{2}/gi).map(h=>parseInt(h,16)));
 qa.badgeContrast=(Math.max(badge,accent)+.05)/(Math.min(badge,accent)+.05);
 if(!qa.font||qa.contrast.some(x=>x.min<4.5)||qa.badgeContrast<4.5)throw Error(JSON.stringify(qa));
 await sharp(out).resize(268).png().toFile(path.join(root,'.build/audit/preview-268.png'));
 await sharp(path.join(__dirname,'ModIcon-original.png')).resize(128,128).png().toFile(path.join(root,'Mod/About/ModIcon.png'));
 await sharp(path.join(root,'Mod/About/ModIcon.png')).resize(32,32).png().toFile(path.join(root,'.build/audit/icon-32.png'));
 fs.writeFileSync(path.join(root,'.build/audit/art-qa.json'),JSON.stringify(qa,null,2));
 console.log(JSON.stringify(qa,null,2));
}finally{if(browser)await browser.close();server.close();}
})().catch(e=>{console.error(e);process.exitCode=1});
