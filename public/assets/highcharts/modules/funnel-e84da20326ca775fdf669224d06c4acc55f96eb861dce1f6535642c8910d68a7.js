!function(t){"use strict";var e=t.getOptions(),n=e.plotOptions,i=t.seriesTypes,r=t.merge,o=function(){},a=t.each,s=t.pick;n.funnel=r(n.pie,{animation:!1,center:["50%","50%"],width:"90%",neckWidth:"30%",height:"100%",neckHeight:"25%",reversed:!1,dataLabels:{connectorWidth:1,connectorColor:"#606060"},size:!0,states:{select:{color:"#C0C0C0",borderColor:"#000000",shadow:!1}}}),i.funnel=t.extendClass(i.pie,{type:"funnel",animate:o,translate:function(){var t,e,n,i,r,s,l,p,h,c,d,u=function(t,e){return/%$/.test(t)?e*parseInt(t,10)/100:parseInt(t,10)},f=0,g=this,b=g.chart,y=g.options,v=y.reversed,k=y.ignoreHiddenPoint,C=b.plotWidth,m=b.plotHeight,W=0,w=y.center,L=u(w[0],C),H=u(w[1],m),Y=u(y.width,C),A=u(y.height,m),O=u(y.neckWidth,C),P=u(y.neckHeight,m),T=A-P,X=g.data,x="left"===y.dataLabels.position?1:0;g.getWidthAt=e=function(t){return t>A-P||A===P?O:O+(Y-O)*((A-P-t)/(A-P))},g.getX=function(t,n){return L+(n?-1:1)*(e(v?m-t:t)/2+y.dataLabels.distance)},g.center=[L,H,A],g.centerX=L,a(X,function(t){k&&t.visible===!1||(f+=t.y)}),a(X,function(a){d=null,i=f?a.y/f:0,s=H-A/2+W*A,h=s+i*A,t=e(s),r=L-t/2,l=r+t,t=e(h),p=L-t/2,c=p+t,s>T?(r=p=L-O/2,l=c=L+O/2):h>T&&(d=h,t=e(T),p=L-t/2,c=p+t,h=T),v&&(s=A-s,h=A-h,d=d?A-d:null),n=["M",r,s,"L",l,s,c,h],d&&n.push(c,d,p,d),n.push(p,h,"Z"),a.shapeType="path",a.shapeArgs={d:n},a.percentage=100*i,a.plotX=L,a.plotY=(s+(d||h))/2,a.tooltipPos=[L,a.plotY],a.slice=o,a.half=x,k&&a.visible===!1||(W+=i)})},drawPoints:function(){var t=this,e=t.options,n=t.chart,i=n.renderer;a(t.data,function(n){var r=n.options,o=n.graphic,a=n.shapeArgs;o?o.animate(a):n.graphic=i.path(a).attr({fill:n.color,stroke:s(r.borderColor,e.borderColor),"stroke-width":s(r.borderWidth,e.borderWidth)}).add(t.group)})},sortByAngle:function(t){t.sort(function(t,e){return t.plotY-e.plotY})},drawDataLabels:function(){var t,e,n,r,o,a=this.data,s=this.options.dataLabels.distance,l=a.length;for(this.center[2]-=2*s;l--;)n=a[l],t=n.half,e=t?1:-1,o=n.plotY,r=this.getX(o,t),n.labelPos=[0,o,r+(s-5)*e,o,r+s*e,o,t?"right":"left",0];i.pie.prototype.drawDataLabels.call(this)}}),e.plotOptions.pyramid=t.merge(e.plotOptions.funnel,{neckWidth:"0%",neckHeight:"0%",reversed:!0}),t.seriesTypes.pyramid=t.extendClass(t.seriesTypes.funnel,{type:"pyramid"})}(Highcharts);