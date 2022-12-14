/* The MIT License

 Copyright (c) 2011 by Michael Zinsmaier and nergal.dev
 Copyright (c) 2012 by Thomas Ritou

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
!function(i){function n(i){function n(i,n){n.series.curvedLines.active&&i.hooks.processDatapoints.unshift(r)}function r(i,n,r){var t=r.points.length/r.pointsize,s=.5;if(1==n.curvedLines.apply&&void 0===n.originSeries&&t>1+s)if(n.lines.fill){var o=e(r,n.curvedLines,1),a=e(r,n.curvedLines,2);r.pointsize=3,r.points=[];for(var p=0,v=0,u=0,f=2;u<o.length||p<a.length;)o[u]==a[p]?(r.points[v]=o[u],r.points[v+1]=o[u+1],r.points[v+2]=a[p+1],p+=f,u+=f):o[u]<a[p]?(r.points[v]=o[u],r.points[v+1]=o[u+1],r.points[v+2]=v>0?r.points[v-1]:null,u+=f):(r.points[v]=a[p],r.points[v+1]=v>1?r.points[v-2]:null,r.points[v+2]=a[p+1],p+=f),v+=3}else n.lines.lineWidth>0&&(r.points=e(r,n.curvedLines,1),r.pointsize=2)}function e(i,n,r){var e=i.points,t=i.pointsize,s=n.curvePointFactor*(e.length/t),o=new Array,a=new Array,p=-1,v=-1,u=0;if(n.fit){var f;if("undefined"==typeof n.fitPointDist){var l=e[0],c=e[e.length-t];f=(c-l)/5e4}else f=n.fitPointDist;for(var h=0;h<e.length;h+=t){var d,y;p=h,v=h+r,d=e[p]-f,y=e[p]+f;for(var g=2;d==e[p]||y==e[p];)d=e[p]-f*g,y=e[p]+f*g,g++;o[u]=d,a[u]=e[v],u++,o[u]=e[p],a[u]=e[v],u++,o[u]=y,a[u]=e[v],u++}}else for(var h=0;h<e.length;h+=t)p=h,v=h+r,o[u]=e[p],a[u]=e[v],u++;var w=o.length,A=new Array,L=new Array;A[0]=0,A[w-1]=0,L[0]=0;for(var h=1;w-1>h;++h){var P=o[h+1]-o[h-1];if(0==P)return[];var z=(o[h]-o[h-1])/P,D=z*A[h-1]+2;A[h]=(z-1)/D,L[h]=(a[h+1]-a[h])/(o[h+1]-o[h])-(a[h]-a[h-1])/(o[h]-o[h-1]),L[h]=(6*L[h]/(o[h+1]-o[h-1])-z*L[h-1])/D}for(var u=w-2;u>=0;--u)A[u]=A[u]*A[u+1]+L[u];var k=(o[w-1]-o[0])/(s-1),F=new Array,j=new Array,m=new Array;for(F[0]=o[0],j[0]=a[0],m.push(F[0]),m.push(j[0]),u=1;s>u;++u){F[u]=F[0]+u*k;for(var M=w-1,O=0;M-O>1;){var Q=Math.round((M+O)/2);o[Q]>F[u]?M=Q:O=Q}var S=o[M]-o[O];if(0==S)return[];var W=(o[M]-F[u])/S,b=(F[u]-o[O])/S;j[u]=W*a[O]+b*a[M]+((W*W*W-W)*A[O]+(b*b*b-b)*A[M])*(S*S)/6,m.push(F[u]),m.push(j[u])}return m}i.hooks.processOptions.push(n)}var r={series:{curvedLines:{active:!1,apply:!1,fit:!1,curvePointFactor:20,fitPointDist:void 0}}};i.plot.plugins.push({init:n,options:r,name:"curvedLines",version:"0.5"})}(jQuery);