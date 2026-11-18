/* FilmForge preview pages: war backdrop, reveals, transitions. Self-made, no external libs. */
(function(){
"use strict";
var RM=window.matchMedia&&matchMedia('(prefers-reduced-motion: reduce)').matches;
var D=document,W=window;
/* ---------- page wipe in/out */
var wipe=D.getElementById('ffwipe');
W.addEventListener('pageshow',function(e){if(e.persisted&&wipe){wipe.className='';void wipe.offsetWidth;}});
D.addEventListener('click',function(e){
  var a=e.target.closest&&e.target.closest('a');if(!a)return;
  var h=a.getAttribute('href')||'';
  if(a.target==='_blank'||e.metaKey||e.ctrlKey||e.shiftKey||h.charAt(0)==='#'||/^(mailto|tel):/.test(h))return;
  if(a.origin!==location.origin)return;
  if(RM||!wipe)return;
  e.preventDefault();wipe.className='out';setTimeout(function(){location.href=a.href},480);
});
/* ---------- burger */
var bg=D.querySelector('.burger'),nav=D.querySelector('.ffh nav');
if(bg)bg.addEventListener('click',function(){nav.classList.toggle('open');bg.setAttribute('aria-expanded',nav.classList.contains('open'))});
/* ---------- reveals */
var els=D.querySelectorAll('.rv');
if('IntersectionObserver' in W&&!RM){
  var io=new IntersectionObserver(function(en){en.forEach(function(x){if(x.isIntersecting){x.target.classList.add('in');io.unobserve(x.target)}})},{rootMargin:'0px 0px -8% 0px',threshold:.08});
  els.forEach(function(e){io.observe(e)});
}else els.forEach(function(e){e.classList.add('in')});
/* autoplay videos when visible */
var vids=D.querySelectorAll('video[data-auto]');
if('IntersectionObserver' in W){var vo=new IntersectionObserver(function(en){en.forEach(function(x){var v=x.target;if(x.isIntersecting){v.preload='auto';var p=v.play();p&&p.catch&&p.catch(function(){})}else v.pause()})},{threshold:.35});vids.forEach(function(v){vo.observe(v)})}
/* ---------- card tilt */
if(!RM&&matchMedia('(hover:hover)').matches){
  D.querySelectorAll('.card').forEach(function(c){
    c.addEventListener('mousemove',function(e){var r=c.getBoundingClientRect(),x=(e.clientX-r.left)/r.width-.5,y=(e.clientY-r.top)/r.height-.5;c.style.transform='perspective(800px) rotateY('+(x*8)+'deg) rotateX('+(-y*8)+'deg) translateZ(6px)'});
    c.addEventListener('mouseleave',function(){c.style.transform=''});
  });
}
/* ---------- progress + glow + parallax */
var prog=D.getElementById('ffprog'),glow=D.getElementById('ffglow'),img=D.getElementById('ffwar-img'),hero=D.querySelector('.hero');
var mx=innerWidth/2,my=innerHeight*.4,gx=mx,gy=my,sy=0;
W.addEventListener('pointermove',function(e){mx=e.clientX;my=e.clientY},{passive:true});
W.addEventListener('scroll',function(){sy=scrollY},{passive:true});
/* ---------- war canvas */
var cv=D.getElementById('ffwar'),ctx=cv&&cv.getContext('2d');
var w=0,h=0,dpr=1;
function size(){dpr=Math.min(W.devicePixelRatio||1,innerWidth<700?1.25:1.5);w=innerWidth;h=innerHeight;if(cv){cv.width=w*dpr|0;cv.height=h*dpr|0}}
size();W.addEventListener('resize',size);
var R=Math.random,mob=innerWidth<700;
var embers=[],booms=[],puffs=[],tracers=[],flak=[],jets=[],flash=0,t0=performance.now(),last=t0;
for(var i=0;i<(mob?45:90);i++)embers.push(newEmber(true));
function newEmber(init){return{x:R()*w,y:init?R()*h:h+10,v:12+R()*40,s:.6+R()*1.8,ph:R()*6.28,b:R()<.28}}
function boom(){var x=R()*w,y=h*(.62+R()*.26),big=R()<.35;booms.push({x:x,y:y,r:0,m:(big?150:70)*(mob?.7:1)*(.6+R()*.6),life:0,dur:big?1.6:1.0});flash=Math.max(flash,big?.22:.1);
  for(var k=0;k<(big?7:4);k++)puffs.push({x:x+(R()-.5)*60,y:y-R()*30,r:20+R()*30,vx:(R()-.5)*12+6,vy:-10-R()*18,life:0,dur:6+R()*5,g:R()*30|0});}
function burst(){flak.push({x:w*(.05+R()*.9),y:h*(.06+R()*.4),life:0,dur:2.8+R()*1.5,r:3+R()*4})}
function volley(){var ox=R()*w,oy=h+10,ang=-Math.PI/2+(R()-.5)*.9,blue=R()<.4,n=5+(R()*6|0);for(var k=0;k<n;k++)tracers.push({x:ox,y:oy,a:ang+(R()-.5)*.05,sp:900+R()*500,d:-k*.07,len:40+R()*40,blue:blue,life:0})}
function jet(){var dir=R()<.5?1:-1;jets.push({x:dir>0?-80:w+80,y:h*(.1+R()*.22),v:(160+R()*140)*dir,s:.7+R()*.7,trail:[]})}
var nb=.4,nf=.2,nv=.8,nj=1.5,beamA=0;
function jetShape(j){ctx.save();ctx.translate(j.x,j.y);ctx.scale(j.s*(j.v>0?1:-1),j.s);ctx.fillStyle='rgba(4,8,18,.95)';ctx.beginPath();ctx.moveTo(22,0);ctx.lineTo(-14,-3);ctx.lineTo(-20,-11);ctx.lineTo(-24,-11);ctx.lineTo(-19,-2);ctx.lineTo(-24,0);ctx.lineTo(-19,2);ctx.lineTo(-24,11);ctx.lineTo(-20,11);ctx.lineTo(-14,3);ctx.closePath();ctx.fill();
  if((performance.now()/250|0)%2){ctx.fillStyle='#00A3FF';ctx.shadowColor='#00A3FF';ctx.shadowBlur=10;ctx.beginPath();ctx.arc(-6,0,1.8,0,7);ctx.fill()}
  ctx.restore()}
function frame(now){
  var dt=Math.min(.05,(now-last)/1000);last=now;var t=(now-t0)/1000;
  gx+=(mx-gx)*.08;gy+=(my-gy)*.08;
  if(glow)glow.style.transform='translate3d('+gx+'px,'+gy+'px,0)';
  if(prog){var m=D.documentElement.scrollHeight-innerHeight;prog.style.transform='scaleX('+(m>0?sy/m:0)+')'}
  if(img)img.style.translate=((gx/w-.5)*-14)+'px '+((gy/h-.5)*-10-sy*.04)+'px';
  if(hero){hero.style.transform='translate3d(0,'+(sy*.25)+'px,0)';hero.style.opacity=Math.max(0,1-sy/(innerHeight*.75))}
  if(!ctx||D.hidden){requestAnimationFrame(frame);return}
  ctx.setTransform(dpr,0,0,dpr,0,0);ctx.clearRect(0,0,w,h);
  if(!RM){nb-=dt;nf-=dt;nv-=dt;nj-=dt;
    if(nb<0){boom();nb=.7+R()*2.2}if(nf<0){burst();nf=.25+R()*.9}if(nv<0){volley();nv=.5+R()*1.6}if(nj<0){jet();nj=4+R()*6}}
  /* burning horizon */
  var fl=.75+.25*Math.sin(t*3.1)*Math.sin(t*1.7+1);
  var g=ctx.createLinearGradient(0,h,0,h*.45);g.addColorStop(0,'rgba(255,96,24,'+(.42*fl)+')');g.addColorStop(.35,'rgba(255,60,20,'+(.16*fl)+')');g.addColorStop(1,'rgba(0,0,0,0)');ctx.fillStyle=g;ctx.fillRect(0,h*.45,w,h*.55);
  /* blue searchlights */
  ctx.globalCompositeOperation='lighter';beamA=t*.35;
  for(var s=0;s<2;s++){var bx=w*(s?.78:.2),ang=-Math.PI/2+Math.sin(beamA+s*2.1)*.55,L=h*1.3;
    var bgd=ctx.createLinearGradient(bx,h,bx+Math.cos(ang)*L,h+Math.sin(ang)*L);bgd.addColorStop(0,'rgba(0,163,255,.30)');bgd.addColorStop(1,'rgba(0,163,255,0)');ctx.fillStyle=bgd;
    ctx.beginPath();ctx.moveTo(bx-6,h);ctx.lineTo(bx+Math.cos(ang-.05)*L,h+Math.sin(ang-.05)*L);ctx.lineTo(bx+Math.cos(ang+.05)*L,h+Math.sin(ang+.05)*L);ctx.lineTo(bx+6,h);ctx.fill()}
  /* tracers */
  for(i=tracers.length-1;i>=0;i--){var r=tracers[i];r.d+=dt;if(r.d<0)continue;r.life+=dt;var dx=Math.cos(r.a)*r.sp*r.life,dy=Math.sin(r.a)*r.sp*r.life+120*r.life*r.life;var x=r.x+dx,y=r.y+dy;
    if(y<-60||r.life>2.2){tracers.splice(i,1);continue}
    var tx=x-Math.cos(r.a)*r.len,ty=y-Math.sin(r.a)*r.len;var lg=ctx.createLinearGradient(tx,ty,x,y);var col=r.blue?'0,170,255':'255,190,90';lg.addColorStop(0,'rgba('+col+',0)');lg.addColorStop(1,'rgba('+col+',.95)');
    ctx.strokeStyle=lg;ctx.lineWidth=r.blue?2.2:1.8;ctx.beginPath();ctx.moveTo(tx,ty);ctx.lineTo(x,y);ctx.stroke()}
  /* flak */
  for(i=flak.length-1;i>=0;i--){var f=flak[i];f.life+=dt;var p=f.life/f.dur;if(p>1){flak.splice(i,1);continue}
    if(p<.08){var q=p/.08;ctx.fillStyle='rgba(255,230,180,'+(1-q)+')';ctx.beginPath();ctx.arc(f.x,f.y,f.r*(1+q*4),0,7);ctx.fill();ctx.fillStyle='rgba(0,163,255,'+(.4*(1-q))+')';ctx.beginPath();ctx.arc(f.x,f.y,f.r*9*q,0,7);ctx.fill()}}
  /* explosions */
  for(i=booms.length-1;i>=0;i--){var b=booms[i];b.life+=dt;p=b.life/b.dur;if(p>1){booms.splice(i,1);continue}
    var rr=b.m*(.3+Math.pow(p,.4)*.9);var eg=ctx.createRadialGradient(b.x,b.y,0,b.x,b.y,rr);var a=1-p;
    eg.addColorStop(0,'rgba(255,245,220,'+a+')');eg.addColorStop(.25,'rgba(255,170,60,'+(a*.9)+')');eg.addColorStop(.6,'rgba(255,70,20,'+(a*.45)+')');eg.addColorStop(1,'rgba(255,40,0,0)');
    ctx.fillStyle=eg;ctx.beginPath();ctx.arc(b.x,b.y,rr,0,7);ctx.fill()}
  ctx.globalCompositeOperation='source-over';
  /* smoke from flak + booms */
  for(i=flak.length-1;i>=0;i--){f=flak[i];p=f.life/f.dur;if(p>.05){ctx.fillStyle='rgba(18,20,28,'+(.55*(1-p))+')';ctx.beginPath();ctx.arc(f.x+p*10,f.y-p*6,f.r*3+p*14,0,7);ctx.fill()}}
  for(i=puffs.length-1;i>=0;i--){var u=puffs[i];u.life+=dt;p=u.life/u.dur;if(p>1){puffs.splice(i,1);continue}
    u.x+=u.vx*dt;u.y+=u.vy*dt;var pr=u.r*(1+p*3.5);var sg=ctx.createRadialGradient(u.x,u.y,0,u.x,u.y,pr);var al=.5*Math.sin(Math.PI*p);
    sg.addColorStop(0,'rgba('+(30+u.g)+','+(28+u.g)+','+(34+u.g)+','+al+')');sg.addColorStop(1,'rgba(20,20,26,0)');ctx.fillStyle=sg;ctx.beginPath();ctx.arc(u.x,u.y,pr,0,7);ctx.fill()}
  /* jets + contrails */
  for(i=jets.length-1;i>=0;i--){var j=jets[i];j.x+=j.v*dt;j.trail.push([j.x,j.y]);if(j.trail.length>70)j.trail.shift();
    if(j.x<-200||j.x>w+200){jets.splice(i,1);continue}
    ctx.strokeStyle='rgba(200,225,255,.22)';ctx.lineWidth=2*j.s;ctx.beginPath();j.trail.forEach(function(pt,k){k?ctx.lineTo(pt[0],pt[1]):ctx.moveTo(pt[0],pt[1])});ctx.stroke();jetShape(j)}
  /* embers */
  ctx.globalCompositeOperation='lighter';
  for(i=0;i<embers.length;i++){var e=embers[i];e.y-=e.v*dt;e.x+=Math.sin(t*1.3+e.ph)*14*dt+8*dt;if(e.y<-10)embers[i]=e=newEmber(false);
    var tw=.55+.45*Math.sin(t*6+e.ph);ctx.fillStyle=e.b?'rgba(0,163,255,'+(.8*tw)+')':'rgba(255,150,60,'+(.85*tw)+')';ctx.beginPath();ctx.arc(e.x,e.y,e.s,0,7);ctx.fill()}
  ctx.globalCompositeOperation='source-over';
  if(flash>0){ctx.fillStyle='rgba(255,180,120,'+flash*.5+')';ctx.fillRect(0,0,w,h);flash=Math.max(0,flash-dt*.9)}
  requestAnimationFrame(frame);
}
requestAnimationFrame(frame);
})();
