!function(t,i){function a(t,i,a){this.init.call(this,t,i,a)}var e=t.arrayMin,n=t.arrayMax,o=t.each,r=t.extend,s=t.merge,l=t.map,h=t.pick,p=t.pInt,c=t.getOptions().plotOptions,d=t.seriesTypes,u=t.extendClass,g=t.splat,m=t.wrap,f=t.Axis,y=t.Tick,b=t.Point,x=t.Pointer,P=t.CenteredSeriesMixin,A=t.TrackerMixin,w=t.Series,L=Math,M=L.round,v=L.floor,k=L.max,C=t.Color,S=function(){};r(a.prototype,{init:function(t,i,a){var e,n=this,r=n.defaultOptions;n.chart=i,n.options=t=s(r,i.angular?{background:{}}:void 0,t),e=t.background,e&&o([].concat(g(e)).reverse(),function(t){var i=t.backgroundColor,e=a.userOptions;t=s(n.defaultBackgroundOptions,t),i&&(t.backgroundColor=i),t.color=t.backgroundColor,a.options.plotBands.unshift(t),e.plotBands=e.plotBands||[],e.plotBands!==a.options.plotBands&&e.plotBands.unshift(t)})},defaultOptions:{center:["50%","50%"],size:"85%",startAngle:0},defaultBackgroundOptions:{shape:"circle",borderWidth:1,borderColor:"silver",backgroundColor:{linearGradient:{x1:0,y1:0,x2:0,y2:1},stops:[[0,"#FFF"],[1,"#DDD"]]},from:-Number.MAX_VALUE,innerRadius:0,to:Number.MAX_VALUE,outerRadius:"105%"}});var T=f.prototype,Y=y.prototype,X={getOffset:S,redraw:function(){this.isDirty=!1},render:function(){this.isDirty=!1},setScale:S,setCategories:S,setTitle:S},R={isRadial:!0,defaultRadialGaugeOptions:{labels:{align:"center",x:0,y:null},minorGridLineWidth:0,minorTickInterval:"auto",minorTickLength:10,minorTickPosition:"inside",minorTickWidth:1,tickLength:10,tickPosition:"inside",tickWidth:2,title:{rotation:0},zIndex:2},defaultRadialXOptions:{gridLineWidth:1,labels:{align:null,distance:15,x:0,y:null},maxPadding:0,minPadding:0,showLastLabel:!1,tickLength:0},defaultRadialYOptions:{gridLineInterpolation:"circle",labels:{align:"right",x:-3,y:-2},showLastLabel:!1,title:{x:4,text:null,rotation:90}},setOptions:function(t){var i=this.options=s(this.defaultOptions,this.defaultRadialOptions,t);i.plotBands||(i.plotBands=[])},getOffset:function(){T.getOffset.call(this),this.chart.axisOffset[this.side]=0,this.center=this.pane.center=P.getCenter.call(this.pane)},getLinePath:function(t,i){var a=this.center;return i=h(i,a[2]/2-this.offset),this.chart.renderer.symbols.arc(this.left+a[0],this.top+a[1],i,i,{start:this.startAngleRad,end:this.endAngleRad,open:!0,innerR:0})},setAxisTranslation:function(){T.setAxisTranslation.call(this),this.center&&(this.isCircular?this.transA=(this.endAngleRad-this.startAngleRad)/(this.max-this.min||1):this.transA=this.center[2]/2/(this.max-this.min||1),this.isXAxis?this.minPixelPadding=this.transA*this.minPointOffset:this.minPixelPadding=0)},beforeSetTickPositions:function(){this.autoConnect&&(this.max+=this.categories&&1||this.pointRange||this.closestPointRange||0)},setAxisSize:function(){T.setAxisSize.call(this),this.isRadial&&(this.center=this.pane.center=t.CenteredSeriesMixin.getCenter.call(this.pane),this.isCircular&&(this.sector=this.endAngleRad-this.startAngleRad),this.len=this.width=this.height=this.center[2]*h(this.sector,1)/2)},getPosition:function(t,i){return this.postTranslate(this.isCircular?this.translate(t):0,h(this.isCircular?i:this.translate(t),this.center[2]/2)-this.offset)},postTranslate:function(t,i){var a=this.chart,e=this.center;return t=this.startAngleRad+t,{x:a.plotLeft+e[0]+Math.cos(t)*i,y:a.plotTop+e[1]+Math.sin(t)*i}},getPlotBandPath:function(t,i,a){var e,n,o,r,s=this.center,c=this.startAngleRad,d=s[2]/2,u=[h(a.outerRadius,"100%"),a.innerRadius,h(a.thickness,10)],g=/%$/,m=this.isCircular;return"polygon"===this.options.gridLineInterpolation?r=this.getPlotLinePath(t).concat(this.getPlotLinePath(i,!0)):(t=Math.max(t,this.min),i=Math.min(i,this.max),m||(u[0]=this.translate(t),u[1]=this.translate(i)),u=l(u,function(t){return g.test(t)&&(t=p(t,10)*d/100),t}),"circle"!==a.shape&&m?(e=c+this.translate(t),n=c+this.translate(i)):(e=-Math.PI/2,n=1.5*Math.PI,o=!0),r=this.chart.renderer.symbols.arc(this.left+s[0],this.top+s[1],u[0],u[0],{start:Math.min(e,n),end:Math.max(e,n),innerR:h(u[1],u[0]-u[2]),open:o})),r},getPlotLinePath:function(t,i){var a,e,n,r,s=this,l=s.center,h=s.chart,p=s.getPosition(t);return s.isCircular?r=["M",l[0]+h.plotLeft,l[1]+h.plotTop,"L",p.x,p.y]:"circle"===s.options.gridLineInterpolation?(t=s.translate(t),t&&(r=s.getLinePath(0,t))):(o(h.xAxis,function(t){t.pane===s.pane&&(a=t)}),r=[],t=s.translate(t),n=a.tickPositions,a.autoConnect&&(n=n.concat([n[0]])),i&&(n=[].concat(n).reverse()),o(n,function(i,n){e=a.getPosition(i,t),r.push(n?"L":"M",e.x,e.y)})),r},getTitlePosition:function(){var t=this.center,i=this.chart,a=this.options.title;return{x:i.plotLeft+t[0]+(a.x||0),y:i.plotTop+t[1]-{high:.5,middle:.25,low:0}[a.align]*t[2]+(a.y||0)}}};m(T,"init",function(t,e,n){var o,l,p,c,d,u,m=this,f=e.angular,y=e.polar,b=n.isX,x=f&&b,P=e.options,A=n.pane||0;f?(r(this,x?X:R),o=!b,o&&(this.defaultRadialOptions=this.defaultRadialGaugeOptions)):y&&(r(this,R),o=b,this.defaultRadialOptions=b?this.defaultRadialXOptions:s(this.defaultYAxisOptions,this.defaultRadialYOptions)),t.call(this,e,n),x||!f&&!y||(c=this.options,e.panes||(e.panes=[]),this.pane=d=e.panes[A]=e.panes[A]||new a(g(P.pane)[A],e,m),u=d.options,e.inverted=!1,P.chart.zoomType=null,this.startAngleRad=l=(u.startAngle-90)*Math.PI/180,this.endAngleRad=p=(h(u.endAngle,u.startAngle+360)-90)*Math.PI/180,this.offset=c.offset||0,this.isCircular=o,o&&n.max===i&&p-l===2*Math.PI&&(this.autoConnect=!0))}),m(Y,"getPosition",function(t,i,a,e,n){var o=this.axis;return o.getPosition?o.getPosition(a):t.call(this,i,a,e,n)}),m(Y,"getLabelPosition",function(t,i,a,e,n,o,r,s,l){var p,c=this.axis,d=o.y,u=20,g=o.align,m=(c.translate(this.pos)+c.startAngleRad+Math.PI/2)/Math.PI*180%360;return c.isRadial?(p=c.getPosition(this.pos,c.center[2]/2+h(o.distance,-25)),"auto"===o.rotation?e.attr({rotation:m}):null===d&&(d=c.chart.renderer.fontMetrics(e.styles.fontSize).b-e.getBBox().height/2),null===g&&(c.isCircular?(this.label.getBBox().width>c.len*c.tickInterval/(c.max-c.min)&&(u=0),g=m>u&&180-u>m?"left":m>180+u&&360-u>m?"right":"center"):g="center",e.attr({align:g})),p.x+=o.x,p.y+=d):p=t.call(this,i,a,e,n,o,r,s,l),p}),m(Y,"getMarkPath",function(t,i,a,e,n,o,r){var s,l,h=this.axis;return h.isRadial?(s=h.getPosition(this.pos,h.center[2]/2+e),l=["M",i,a,"L",s.x,s.y]):l=t.call(this,i,a,e,n,o,r),l}),c.arearange=s(c.area,{lineWidth:1,marker:null,threshold:null,tooltip:{pointFormat:'<span style="color:{series.color}">\u25cf</span> {series.name}: <b>{point.low}</b> - <b>{point.high}</b><br/>'},trackByArea:!0,dataLabels:{align:null,verticalAlign:null,xLow:0,xHigh:0,yLow:0,yHigh:0},states:{hover:{halo:!1}}}),d.arearange=u(d.area,{type:"arearange",pointArrayMap:["low","high"],dataLabelCollections:["dataLabel","dataLabelUpper"],toYData:function(t){return[t.low,t.high]},pointValKey:"low",deferTranslatePolar:!0,highToXY:function(t){var i=this.chart,a=this.xAxis.postTranslate(t.rectPlotX,this.yAxis.len-t.plotHigh);t.plotHighX=a.x-i.plotLeft,t.plotHigh=a.y-i.plotTop},getSegments:function(){var t=this;o(t.points,function(i){t.options.connectNulls||null!==i.low&&null!==i.high?null===i.low&&null!==i.high&&(i.y=i.high):i.y=null}),w.prototype.getSegments.call(this)},translate:function(){var t=this,i=t.yAxis;d.area.prototype.translate.apply(t),o(t.points,function(t){var a=t.low,e=t.high,n=t.plotY;null===e&&null===a?t.y=null:null===a?(t.plotLow=t.plotY=null,t.plotHigh=i.translate(e,0,1,0,1)):null===e?(t.plotLow=n,t.plotHigh=null):(t.plotLow=n,t.plotHigh=i.translate(e,0,1,0,1))}),this.chart.polar&&o(this.points,function(i){t.highToXY(i)})},getSegmentPath:function(t){var i,a,e,n,o,r=[],s=t.length,l=w.prototype.getSegmentPath,h=this.options,p=h.step;for(i=HighchartsAdapter.grep(t,function(t){return null!==t.plotLow});s--;)a=t[s],null!==a.plotHigh&&r.push({plotX:a.plotHighX||a.plotX,plotY:a.plotHigh});return n=l.call(this,i),p&&(p===!0&&(p="left"),h.step={left:"right",center:"center",right:"left"}[p]),o=l.call(this,r),h.step=p,e=[].concat(n,o),this.chart.polar||(o[0]="L"),this.areaPath=this.areaPath.concat(n,o),e},drawDataLabels:function(){var t,i,a,e=this.data,n=e.length,o=[],r=w.prototype,s=this.options.dataLabels,l=s.align,h=s.inside,p=this.chart.inverted;if(s.enabled||this._hasPointLabels){for(t=n;t--;)i=e[t],i&&(a=h?i.plotHigh<i.plotLow:i.plotHigh>i.plotLow,i.y=i.high,i._plotY=i.plotY,i.plotY=i.plotHigh,o[t]=i.dataLabel,i.dataLabel=i.dataLabelUpper,i.below=a,p?(l||(s.align=a?"right":"left"),s.x=s.xHigh):s.y=s.yHigh);for(r.drawDataLabels&&r.drawDataLabels.apply(this,arguments),t=n;t--;)i=e[t],i&&(a=h?i.plotHigh<i.plotLow:i.plotHigh>i.plotLow,i.dataLabelUpper=i.dataLabel,i.dataLabel=o[t],i.y=i.low,i.plotY=i._plotY,i.below=!a,p?(l||(s.align=a?"left":"right"),s.x=s.xLow):s.y=s.yLow);r.drawDataLabels&&r.drawDataLabels.apply(this,arguments)}s.align=l},alignDataLabel:function(){d.column.prototype.alignDataLabel.apply(this,arguments)},setStackedPoints:S,getSymbol:S,drawPoints:S}),c.areasplinerange=s(c.arearange),d.areasplinerange=u(d.arearange,{type:"areasplinerange",getPointSpline:d.spline.prototype.getPointSpline}),function(){var t=d.column.prototype;c.columnrange=s(c.column,c.arearange,{lineWidth:1,pointRange:null}),d.columnrange=u(d.arearange,{type:"columnrange",translate:function(){var i,a=this,e=a.yAxis;t.translate.apply(a),o(a.points,function(t){var n,o,r,s=t.shapeArgs,l=a.options.minPointLength;t.tooltipPos=null,t.plotHigh=i=e.translate(t.high,0,1,0,1),t.plotLow=t.plotY,r=i,o=t.plotY-i,Math.abs(o)<l?(n=l-o,o+=n,r-=n/2):0>o&&(o*=-1,r-=o),s.height=o,s.y=r})},directTouch:!0,trackerGroups:["group","dataLabelsGroup"],drawGraph:S,crispCol:t.crispCol,pointAttrToOptions:t.pointAttrToOptions,drawPoints:t.drawPoints,drawTracker:t.drawTracker,animate:t.animate,getColumnMetrics:t.getColumnMetrics})}(),c.gauge=s(c.line,{dataLabels:{enabled:!0,defer:!1,y:15,borderWidth:1,borderColor:"silver",borderRadius:3,crop:!1,verticalAlign:"top",zIndex:2},dial:{},pivot:{},tooltip:{headerFormat:""},showInLegend:!1});var z=u(b,{setState:function(t){this.state=t}}),D={type:"gauge",pointClass:z,angular:!0,drawGraph:S,fixedBox:!0,forceDL:!0,trackerGroups:["group","dataLabelsGroup"],translate:function(){var t=this,i=t.yAxis,a=t.options,e=i.center;t.generatePoints(),o(t.points,function(t){var n=s(a.dial,t.dial),o=p(h(n.radius,80))*e[2]/200,r=p(h(n.baseLength,70))*o/100,l=p(h(n.rearLength,10))*o/100,c=n.baseWidth||3,d=n.topWidth||1,u=a.overshoot,g=i.startAngleRad+i.translate(t.y,null,null,null,!0);u&&"number"==typeof u?(u=u/180*Math.PI,g=Math.max(i.startAngleRad-u,Math.min(i.endAngleRad+u,g))):a.wrap===!1&&(g=Math.max(i.startAngleRad,Math.min(i.endAngleRad,g))),g=180*g/Math.PI,t.shapeType="path",t.shapeArgs={d:n.path||["M",-l,-c/2,"L",r,-c/2,o,-d/2,o,d/2,r,c/2,-l,c/2,"z"],translateX:e[0],translateY:e[1],rotation:g},t.plotX=e[0],t.plotY=e[1]})},drawPoints:function(){var t=this,i=t.yAxis.center,a=t.pivot,e=t.options,n=e.pivot,r=t.chart.renderer;o(t.points,function(i){var a=i.graphic,n=i.shapeArgs,o=n.d,l=s(e.dial,i.dial);a?(a.animate(n),n.d=o):i.graphic=r[i.shapeType](n).attr({stroke:l.borderColor||"none","stroke-width":l.borderWidth||0,fill:l.backgroundColor||"black",rotation:n.rotation}).add(t.group)}),a?a.animate({translateX:i[0],translateY:i[1]}):t.pivot=r.circle(0,0,h(n.radius,5)).attr({"stroke-width":n.borderWidth||0,stroke:n.borderColor||"silver",fill:n.backgroundColor||"black"}).translate(i[0],i[1]).add(t.group)},animate:function(t){var i=this;t||(o(i.points,function(t){var a=t.graphic;a&&(a.attr({rotation:180*i.yAxis.startAngleRad/Math.PI}),a.animate({rotation:t.shapeArgs.rotation},i.options.animation))}),i.animate=null)},render:function(){this.group=this.plotGroup("group","series",this.visible?"visible":"hidden",this.options.zIndex,this.chart.seriesGroup),w.prototype.render.call(this),this.group.clip(this.chart.clipRect)},setData:function(t,i){w.prototype.setData.call(this,t,!1),this.processData(),this.generatePoints(),h(i,!0)&&this.chart.redraw()},drawTracker:A&&A.drawTrackerPoint};d.gauge=u(d.line,D),c.boxplot=s(c.column,{fillColor:"#FFFFFF",lineWidth:1,medianWidth:2,states:{hover:{brightness:-.3}},threshold:null,tooltip:{pointFormat:'<span style="color:{point.color}">\u25cf</span> <b> {series.name}</b><br/>Maximum: {point.high}<br/>Upper quartile: {point.q3}<br/>Median: {point.median}<br/>Lower quartile: {point.q1}<br/>Minimum: {point.low}<br/>'},whiskerLength:"50%",whiskerWidth:2}),d.boxplot=u(d.column,{type:"boxplot",pointArrayMap:["low","q1","median","q3","high"],toYData:function(t){return[t.low,t.q1,t.median,t.q3,t.high]},pointValKey:"high",pointAttrToOptions:{fill:"fillColor",stroke:"color","stroke-width":"lineWidth"},drawDataLabels:S,translate:function(){var t=this,i=t.yAxis,a=t.pointArrayMap;d.column.prototype.translate.apply(t),o(t.points,function(t){o(a,function(a){null!==t[a]&&(t[a+"Plot"]=i.translate(t[a],0,1,0,1))})})},drawPoints:function(){var t,a,e,n,r,s,l,p,c,d,u,g,m,f,y,b,x,P,A,w,L,k,C,S=this,T=S.points,Y=S.options,X=S.chart,R=X.renderer,z=S.doQuartiles!==!1,D=S.options.whiskerLength;o(T,function(o){c=o.graphic,L=o.shapeArgs,u={},f={},b={},k=o.color||S.color,o.plotY!==i&&(t=o.pointAttr[o.selected?"selected":""],x=L.width,P=v(L.x),A=P+x,w=M(x/2),a=v(z?o.q1Plot:o.lowPlot),e=v(z?o.q3Plot:o.lowPlot),n=v(o.highPlot),r=v(o.lowPlot),u.stroke=o.stemColor||Y.stemColor||k,u["stroke-width"]=h(o.stemWidth,Y.stemWidth,Y.lineWidth),u.dashstyle=o.stemDashStyle||Y.stemDashStyle,f.stroke=o.whiskerColor||Y.whiskerColor||k,f["stroke-width"]=h(o.whiskerWidth,Y.whiskerWidth,Y.lineWidth),b.stroke=o.medianColor||Y.medianColor||k,b["stroke-width"]=h(o.medianWidth,Y.medianWidth,Y.lineWidth),l=u["stroke-width"]%2/2,p=P+w+l,d=["M",p,e,"L",p,n,"M",p,a,"L",p,r],z&&(l=t["stroke-width"]%2/2,p=v(p)+l,a=v(a)+l,e=v(e)+l,P+=l,A+=l,g=["M",P,e,"L",P,a,"L",A,a,"L",A,e,"L",P,e,"z"]),D&&(l=f["stroke-width"]%2/2,n+=l,r+=l,C=/%$/.test(D)?w*parseFloat(D)/100:D/2,m=["M",p-C,n,"L",p+C,n,"M",p-C,r,"L",p+C,r]),l=b["stroke-width"]%2/2,s=M(o.medianPlot)+l,y=["M",P,s,"L",A,s],c?(o.stem.animate({d:d}),D&&o.whiskers.animate({d:m}),z&&o.box.animate({d:g}),o.medianShape.animate({d:y})):(o.graphic=c=R.g().add(S.group),o.stem=R.path(d).attr(u).add(c),D&&(o.whiskers=R.path(m).attr(f).add(c)),z&&(o.box=R.path(g).attr(t).add(c)),o.medianShape=R.path(y).attr(b).add(c)))})},setStackedPoints:S}),c.errorbar=s(c.boxplot,{color:"#000000",grouping:!1,linkedTo:":previous",tooltip:{pointFormat:'<span style="color:{point.color}">\u25cf</span> {series.name}: <b>{point.low}</b> - <b>{point.high}</b><br/>'},whiskerWidth:null}),d.errorbar=u(d.boxplot,{type:"errorbar",pointArrayMap:["low","high"],toYData:function(t){return[t.low,t.high]},pointValKey:"high",doQuartiles:!1,drawDataLabels:d.arearange?d.arearange.prototype.drawDataLabels:S,getColumnMetrics:function(){return this.linkedParent&&this.linkedParent.columnMetrics||d.column.prototype.getColumnMetrics.call(this)}}),c.waterfall=s(c.column,{lineWidth:1,lineColor:"#333",dashStyle:"dot",borderColor:"#333",dataLabels:{inside:!0},states:{hover:{lineWidthPlus:0}}}),d.waterfall=u(d.column,{type:"waterfall",upColorProp:"fill",pointValKey:"y",translate:function(){var t,i,a,e,n,o,r,s,l,h,p,c,u=this,g=u.options,m=u.yAxis,f=g.threshold,y=g.stacking;for(d.column.prototype.translate.apply(this),l=h=f,a=u.points,i=0,t=a.length;t>i;i++)e=a[i],s=this.processedYData[i],n=e.shapeArgs,o=y&&m.stacks[(u.negStacks&&f>s?"-":"")+u.stackKey],p=o?o[e.x].points[u.index+","+i]:[0,s],e.isSum?e.y=s:e.isIntermediateSum&&(e.y=s-h),r=k(l,l+e.y)+p[0],n.y=m.translate(r,0,1),e.isSum?(n.y=m.translate(p[1],0,1),n.height=Math.min(m.translate(p[0],0,1),m.len)-n.y):e.isIntermediateSum?(n.y=m.translate(p[1],0,1),n.height=Math.min(m.translate(h,0,1),m.len)-n.y,h=p[1]):(0!==l&&(n.height=s>0?m.translate(l,0,1)-n.y:m.translate(l,0,1)-m.translate(l-s,0,1)),l+=s),n.height<0&&(n.y+=n.height,n.height*=-1),e.plotY=n.y=M(n.y)-u.borderWidth%2/2,n.height=k(M(n.height),.001),e.yBottom=n.y+n.height,c=e.plotY+(e.negative?n.height:0),u.chart.inverted?e.tooltipPos[0]=m.len-c:e.tooltipPos[1]=c},processData:function(t){var i,a,e,n,o,r,s,l=this,h=l.options,p=l.yData,c=l.options.data,d=p.length,u=h.threshold||0;for(e=a=n=o=u,s=0;d>s;s++)r=p[s],i=c&&c[s]?c[s]:{},"sum"===r||i.isSum?p[s]=e:"intermediateSum"===r||i.isIntermediateSum?p[s]=a:(e+=r,a+=r),n=Math.min(e,n),o=Math.max(e,o);w.prototype.processData.call(this,t),l.dataMin=n,l.dataMax=o},toYData:function(t){return t.isSum?0===t.x?null:"sum":t.isIntermediateSum?0===t.x?null:"intermediateSum":t.y},getAttribs:function(){d.column.prototype.getAttribs.apply(this,arguments);var i=this,a=i.options,e=a.states,n=a.upColor||i.color,r=t.Color(n).brighten(.1).get(),l=s(i.pointAttr),h=i.upColorProp;l[""][h]=n,l.hover[h]=e.hover.upColor||r,l.select[h]=e.select.upColor||n,o(i.points,function(t){t.options.color||(t.y>0?(t.pointAttr=l,t.color=n):t.pointAttr=i.pointAttr)})},getGraphPath:function(){var t,i,a,e,n=this.data,o=n.length,r=this.options.lineWidth+this.borderWidth,s=M(r)%2/2,l=[],h="M",p="L";for(a=1;o>a;a++)i=n[a].shapeArgs,t=n[a-1].shapeArgs,e=[h,t.x+t.width,t.y+s,p,i.x,t.y+s],n[a-1].y<0&&(e[2]+=t.height,e[5]+=t.height),l=l.concat(e);return l},getExtremes:S,drawGraph:w.prototype.drawGraph}),c.polygon=s(c.scatter,{marker:{enabled:!1}}),d.polygon=u(d.scatter,{type:"polygon",fillGraph:!0,getSegmentPath:function(t){return w.prototype.getSegmentPath.call(this,t).concat("z")},drawGraph:w.prototype.drawGraph,drawLegendSymbol:t.LegendSymbolMixin.drawRectangle}),c.bubble=s(c.scatter,{dataLabels:{formatter:function(){return this.point.z},inside:!0,verticalAlign:"middle"},marker:{lineColor:null,lineWidth:1},minSize:8,maxSize:"20%",softThreshold:!1,states:{hover:{halo:{size:5}}},tooltip:{pointFormat:"({point.x}, {point.y}), Size: {point.z}"},turboThreshold:0,zThreshold:0,zoneAxis:"z"});var W=u(b,{haloPath:function(){return b.prototype.haloPath.call(this,this.shapeArgs.r+this.series.options.states.hover.halo.size)},ttBelow:!1});d.bubble=u(d.scatter,{type:"bubble",pointClass:W,pointArrayMap:["y","z"],parallelArrays:["x","y","z"],trackerGroups:["group","dataLabelsGroup"],bubblePadding:!0,zoneAxis:"z",pointAttrToOptions:{stroke:"lineColor","stroke-width":"lineWidth",fill:"fillColor"},applyOpacity:function(t){var i=this.options.marker,a=h(i.fillOpacity,.5);return t=t||i.fillColor||this.color,1!==a&&(t=C(t).setOpacity(a).get("rgba")),t},convertAttribs:function(){var t=w.prototype.convertAttribs.apply(this,arguments);return t.fill=this.applyOpacity(t.fill),t},getRadii:function(t,i,a,e){var n,o,r,s,l,h=this.zData,p=[],c=this.options,d="width"!==c.sizeBy,u=c.zThreshold,g=i-t;for(o=0,n=h.length;n>o;o++)s=h[o],c.sizeByAbsoluteValue&&(s=Math.abs(s-u),i=Math.max(i-u,Math.abs(t-u)),t=0),null===s?l=null:t>s?l=a/2-1:(r=g>0?(s-t)/g:.5,d&&r>=0&&(r=Math.sqrt(r)),l=L.ceil(a+r*(e-a))/2),p.push(l);this.radii=p},animate:function(t){var i=this.options.animation;t||(o(this.points,function(t){var a=t.graphic,e=t.shapeArgs;a&&e&&(a.attr("r",1),a.animate({r:e.r},i))}),this.animate=null)},translate:function(){var t,a,e,n=this.data,o=this.radii;for(d.scatter.prototype.translate.call(this),t=n.length;t--;)a=n[t],e=o?o[t]:0,"number"==typeof e&&e>=this.minPxSize/2?(a.shapeType="circle",a.shapeArgs={x:a.plotX,y:a.plotY,r:e},a.dlBox={x:a.plotX-e,y:a.plotY-e,width:2*e,height:2*e}):a.shapeArgs=a.plotY=a.dlBox=i},drawLegendSymbol:function(t,i){var a=p(t.itemStyle.fontSize)/2;i.legendSymbol=this.chart.renderer.circle(a,t.baseline-a,a).attr({zIndex:3}).add(i.legendGroup),i.legendSymbol.isMarker=!0},drawPoints:d.column.prototype.drawPoints,alignDataLabel:d.column.prototype.alignDataLabel,buildKDTree:S,applyZones:S}),f.prototype.beforePadding=function(){var t=this,a=this.len,r=this.chart,s=0,l=a,c=this.isXAxis,d=c?"xData":"yData",u=this.min,g={},m=L.min(r.plotWidth,r.plotHeight),f=Number.MAX_VALUE,y=-Number.MAX_VALUE,b=this.max-u,x=a/b,P=[];o(this.series,function(i){var a,s=i.options;!i.bubblePadding||!i.visible&&r.options.chart.ignoreHiddenSeries||(t.allowZoomOutside=!0,P.push(i),c&&(o(["minSize","maxSize"],function(t){var i=s[t],a=/%$/.test(i);i=p(i),g[t]=a?m*i/100:i}),i.minPxSize=g.minSize,i.maxPxSize=g.maxSize,a=i.zData,a.length&&(f=h(s.zMin,L.min(f,L.max(e(a),s.displayNegative===!1?s.zThreshold:-Number.MAX_VALUE))),y=h(s.zMax,L.max(y,n(a))))))}),o(P,function(t){var i,a=t[d],e=a.length;if(c&&t.getRadii(f,y,t.minPxSize,t.maxPxSize),b>0)for(;e--;)"number"==typeof a[e]&&(i=t.radii[e],s=Math.min((a[e]-u)*x-i,s),l=Math.max((a[e]-u)*x+i,l))}),P.length&&b>0&&!this.isLog&&(l-=a,x*=(a+s-l)/a,o([["min","userMin",s],["max","userMax",l]],function(a){h(t.options[a[0]],t[a[1]])===i&&(t[a[0]]+=a[2]/x)}))},function(){function t(t,i,a){t.call(this,i,a),this.chart.polar&&(this.closeSegment=function(t){var i=this.xAxis.center;t.push("L",i[0],i[1])},this.closedStacks=!0)}function i(t,i){var a,e=this.chart,n=this.options.animation,o=this.group,r=this.markerGroup,s=this.xAxis.center,l=e.plotLeft,h=e.plotTop;e.polar?e.renderer.isSVG&&(n===!0&&(n={}),i?(a={translateX:s[0]+l,translateY:s[1]+h,scaleX:.001,scaleY:.001},o.attr(a),r&&r.attr(a)):(a={translateX:l,translateY:h,scaleX:1,scaleY:1},o.animate(a,n),r&&r.animate(a,n),this.animate=null)):t.call(this,i)}var a,e=w.prototype,n=x.prototype;e.searchPointByAngle=function(t){var i=this,a=i.chart,e=i.xAxis,n=e.pane.center,o=t.chartX-n[0]-a.plotLeft,r=t.chartY-n[1]-a.plotTop;return this.searchKDTree({clientX:180+Math.atan2(o,r)*(-180/Math.PI)})},m(e,"buildKDTree",function(t){this.chart.polar&&(this.kdByAngle?this.searchPoint=this.searchPointByAngle:this.kdDimensions=2),t.apply(this)}),e.toXY=function(t){var i,a,e=this.chart,n=t.plotX,o=t.plotY;t.rectPlotX=n,t.rectPlotY=o,i=this.xAxis.postTranslate(t.plotX,this.yAxis.len-o),t.plotX=t.polarPlotX=i.x-e.plotLeft,t.plotY=t.polarPlotY=i.y-e.plotTop,this.kdByAngle?(a=(n/Math.PI*180+this.xAxis.pane.options.startAngle)%360,0>a&&(a+=360),t.clientX=a):t.clientX=t.plotX},d.area&&m(d.area.prototype,"init",t),d.areaspline&&m(d.areaspline.prototype,"init",t),d.spline&&m(d.spline.prototype,"getPointSpline",function(t,i,a,e){var n,o,r,s,l,h,p,c,d,u,g,m,f,y,b,x,P,A,w=1.5,L=w+1;return this.chart.polar?(o=a.plotX,r=a.plotY,s=i[e-1],l=i[e+1],this.connectEnds&&(s||(s=i[i.length-2]),l||(l=i[1])),s&&l&&(h=s.plotX,p=s.plotY,c=l.plotX,d=l.plotY,u=(w*o+h)/L,g=(w*r+p)/L,m=(w*o+c)/L,f=(w*r+d)/L,y=Math.sqrt(Math.pow(u-o,2)+Math.pow(g-r,2)),b=Math.sqrt(Math.pow(m-o,2)+Math.pow(f-r,2)),x=Math.atan2(g-r,u-o),P=Math.atan2(f-r,m-o),A=Math.PI/2+(x+P)/2,Math.abs(x-A)>Math.PI/2&&(A-=Math.PI),u=o+Math.cos(A)*y,g=r+Math.sin(A)*y,m=o+Math.cos(Math.PI+A)*b,f=r+Math.sin(Math.PI+A)*b,a.rightContX=m,a.rightContY=f),e?(n=["C",s.rightContX||s.plotX,s.rightContY||s.plotY,u||o,g||r,o,r],s.rightContX=s.rightContY=null):n=["M",o,r]):n=t.call(this,i,a,e),n}),m(e,"translate",function(t){var i,a,e=this.chart;if(t.call(this),e.polar&&(this.kdByAngle=e.tooltip&&e.tooltip.shared,!this.preventPostTranslate))for(i=this.points,a=i.length;a--;)this.toXY(i[a])}),m(e,"getSegmentPath",function(t,i){var a=this.points;return this.chart.polar&&this.options.connectEnds!==!1&&i[i.length-1]===a[a.length-1]&&null!==a[0].y&&(this.connectEnds=!0,i=[].concat(i,[a[0]])),t.call(this,i)}),m(e,"animate",i),d.column&&(a=d.column.prototype,m(a,"animate",i),m(a,"translate",function(t){var i,a,e,n,o=this.xAxis,r=this.yAxis.len,s=o.center,l=o.startAngleRad,p=this.chart.renderer;if(this.preventPostTranslate=!0,t.call(this),o.isRadial)for(a=this.points,n=a.length;n--;)e=a[n],i=e.barX+l,e.shapeType="path",e.shapeArgs={d:p.symbols.arc(s[0],s[1],r-e.plotY,null,{start:i,end:i+e.pointWidth,innerR:r-h(e.yBottom,r)})},this.toXY(e),e.tooltipPos=[e.plotX,e.plotY],e.ttBelow=e.plotY>s[1]}),m(a,"alignDataLabel",function(t,i,a,n,o,r){if(this.chart.polar){var s,l,h=i.rectPlotX/Math.PI*180;null===n.align&&(s=h>20&&160>h?"left":h>200&&340>h?"right":"center",n.align=s),null===n.verticalAlign&&(l=45>h||h>315?"bottom":h>135&&225>h?"top":"middle",n.verticalAlign=l),e.alignDataLabel.call(this,i,a,n,o,r)}else t.call(this,i,a,n,o,r)})),m(n,"getCoordinates",function(t,i){var a=this.chart,e={xAxis:[],yAxis:[]};return a.polar?o(a.axes,function(t){var n=t.isXAxis,o=t.center,r=i.chartX-o[0]-a.plotLeft,s=i.chartY-o[1]-a.plotTop;e[n?"xAxis":"yAxis"].push({axis:t,value:t.translate(n?Math.PI-Math.atan2(r,s):Math.sqrt(Math.pow(r,2)+Math.pow(s,2)),!0)})}):e=t.call(this,i),e})}()}(Highcharts);