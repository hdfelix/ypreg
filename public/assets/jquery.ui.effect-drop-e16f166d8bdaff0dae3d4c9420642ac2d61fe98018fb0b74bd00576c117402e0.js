!function(t,e){var n="ui-effects-";t.effects={effect:{}},function(t,e){function n(t,e,n){var r=l[e.type]||{};return null==t?n||!e.def?null:e.def:(t=r.floor?~~t:parseFloat(t),isNaN(t)?e.def:r.mod?(t+r.mod)%r.mod:0>t?0:r.max<t?r.max:t)}function r(e){var n=f(),r=n._rgba=[];return e=e.toLowerCase(),h(c,function(t,o){var i,a=o.re.exec(e),s=a&&o.parse(a),c=o.space||"rgba";if(s)return i=n[c](s),n[u[c].cache]=i[u[c].cache],r=n._rgba=i._rgba,!1}),r.length?("0,0,0,0"===r.join()&&t.extend(r,i.transparent),n):i[e]}function o(t,e,n){return n=(n+1)%1,6*n<1?t+(e-t)*n*6:2*n<1?e:3*n<2?t+(e-t)*(2/3-n)*6:t}var i,a="backgroundColor borderBottomColor borderLeftColor borderRightColor borderTopColor color columnRuleColor outlineColor textDecorationColor textEmphasisColor",s=/^([\-+])=\s*(\d+\.?\d*)/,c=[{re:/rgba?\(\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})\s*(?:,\s*(\d?(?:\.\d+)?)\s*)?\)/,parse:function(t){return[t[1],t[2],t[3],t[4]]}},{re:/rgba?\(\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*(?:,\s*(\d?(?:\.\d+)?)\s*)?\)/,parse:function(t){return[2.55*t[1],2.55*t[2],2.55*t[3],t[4]]}},{re:/#([a-f0-9]{2})([a-f0-9]{2})([a-f0-9]{2})/,parse:function(t){return[parseInt(t[1],16),parseInt(t[2],16),parseInt(t[3],16)]}},{re:/#([a-f0-9])([a-f0-9])([a-f0-9])/,parse:function(t){return[parseInt(t[1]+t[1],16),parseInt(t[2]+t[2],16),parseInt(t[3]+t[3],16)]}},{re:/hsla?\(\s*(\d+(?:\.\d+)?)\s*,\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*(?:,\s*(\d?(?:\.\d+)?)\s*)?\)/,space:"hsla",parse:function(t){return[t[1],t[2]/100,t[3]/100,t[4]]}}],f=t.Color=function(e,n,r,o){return new t.Color.fn.parse(e,n,r,o)},u={rgba:{props:{red:{idx:0,type:"byte"},green:{idx:1,type:"byte"},blue:{idx:2,type:"byte"}}},hsla:{props:{hue:{idx:0,type:"degrees"},saturation:{idx:1,type:"percent"},lightness:{idx:2,type:"percent"}}}},l={"byte":{floor:!0,max:255},percent:{max:1},degrees:{mod:360,floor:!0}},p=f.support={},d=t("<p>")[0],h=t.each;d.style.cssText="background-color:rgba(1,1,1,.5)",p.rgba=d.style.backgroundColor.indexOf("rgba")>-1,h(u,function(t,e){e.cache="_"+t,e.props.alpha={idx:3,type:"percent",def:1}}),f.fn=t.extend(f.prototype,{parse:function(o,a,s,c){if(o===e)return this._rgba=[null,null,null,null],this;(o.jquery||o.nodeType)&&(o=t(o).css(a),a=e);var l=this,p=t.type(o),d=this._rgba=[];return a!==e&&(o=[o,a,s,c],p="array"),"string"===p?this.parse(r(o)||i._default):"array"===p?(h(u.rgba.props,function(t,e){d[e.idx]=n(o[e.idx],e)}),this):"object"===p?(o instanceof f?h(u,function(t,e){o[e.cache]&&(l[e.cache]=o[e.cache].slice())}):h(u,function(e,r){var i=r.cache;h(r.props,function(t,e){if(!l[i]&&r.to){if("alpha"===t||null==o[t])return;l[i]=r.to(l._rgba)}l[i][e.idx]=n(o[t],e,!0)}),l[i]&&t.inArray(null,l[i].slice(0,3))<0&&(l[i][3]=1,r.from&&(l._rgba=r.from(l[i])))}),this):void 0},is:function(t){var e=f(t),n=!0,r=this;return h(u,function(t,o){var i,a=e[o.cache];return a&&(i=r[o.cache]||o.to&&o.to(r._rgba)||[],h(o.props,function(t,e){if(null!=a[e.idx])return n=a[e.idx]===i[e.idx]})),n}),n},_space:function(){var t=[],e=this;return h(u,function(n,r){e[r.cache]&&t.push(n)}),t.pop()},transition:function(t,e){var r=f(t),o=r._space(),i=u[o],a=0===this.alpha()?f("transparent"):this,s=a[i.cache]||i.to(a._rgba),c=s.slice();return r=r[i.cache],h(i.props,function(t,o){var i=o.idx,a=s[i],f=r[i],u=l[o.type]||{};null!==f&&(null===a?c[i]=f:(u.mod&&(f-a>u.mod/2?a+=u.mod:a-f>u.mod/2&&(a-=u.mod)),c[i]=n((f-a)*e+a,o)))}),this[o](c)},blend:function(e){if(1===this._rgba[3])return this;var n=this._rgba.slice(),r=n.pop(),o=f(e)._rgba;return f(t.map(n,function(t,e){return(1-r)*o[e]+r*t}))},toRgbaString:function(){var e="rgba(",n=t.map(this._rgba,function(t,e){return null==t?e>2?1:0:t});return 1===n[3]&&(n.pop(),e="rgb("),e+n.join()+")"},toHslaString:function(){var e="hsla(",n=t.map(this.hsla(),function(t,e){return null==t&&(t=e>2?1:0),e&&e<3&&(t=Math.round(100*t)+"%"),t});return 1===n[3]&&(n.pop(),e="hsl("),e+n.join()+")"},toHexString:function(e){var n=this._rgba.slice(),r=n.pop();return e&&n.push(~~(255*r)),"#"+t.map(n,function(t){return t=(t||0).toString(16),1===t.length?"0"+t:t}).join("")},toString:function(){return 0===this._rgba[3]?"transparent":this.toRgbaString()}}),f.fn.parse.prototype=f.fn,u.hsla.to=function(t){if(null==t[0]||null==t[1]||null==t[2])return[null,null,null,t[3]];var e,n,r=t[0]/255,o=t[1]/255,i=t[2]/255,a=t[3],s=Math.max(r,o,i),c=Math.min(r,o,i),f=s-c,u=s+c,l=.5*u;return e=c===s?0:r===s?60*(o-i)/f+360:o===s?60*(i-r)/f+120:60*(r-o)/f+240,n=0===f?0:l<=.5?f/u:f/(2-u),[Math.round(e)%360,n,l,null==a?1:a]},u.hsla.from=function(t){if(null==t[0]||null==t[1]||null==t[2])return[null,null,null,t[3]];var e=t[0]/360,n=t[1],r=t[2],i=t[3],a=r<=.5?r*(1+n):r+n-r*n,s=2*r-a;return[Math.round(255*o(s,a,e+1/3)),Math.round(255*o(s,a,e)),Math.round(255*o(s,a,e-1/3)),i]},h(u,function(r,o){var i=o.props,a=o.cache,c=o.to,u=o.from;f.fn[r]=function(r){if(c&&!this[a]&&(this[a]=c(this._rgba)),r===e)return this[a].slice();var o,s=t.type(r),l="array"===s||"object"===s?r:arguments,p=this[a].slice();return h(i,function(t,e){var r=l["object"===s?t:e.idx];null==r&&(r=p[e.idx]),p[e.idx]=n(r,e)}),u?(o=f(u(p)),o[a]=p,o):f(p)},h(i,function(e,n){f.fn[e]||(f.fn[e]=function(o){var i,a=t.type(o),c="alpha"===e?this._hsla?"hsla":"rgba":r,f=this[c](),u=f[n.idx];return"undefined"===a?u:("function"===a&&(o=o.call(this,u),a=t.type(o)),null==o&&n.empty?this:("string"===a&&(i=s.exec(o),i&&(o=u+parseFloat(i[2])*("+"===i[1]?1:-1))),f[n.idx]=o,this[c](f)))})})}),f.hook=function(e){var n=e.split(" ");h(n,function(e,n){t.cssHooks[n]={set:function(e,o){var i,a,s="";if("transparent"!==o&&("string"!==t.type(o)||(i=r(o)))){if(o=f(i||o),!p.rgba&&1!==o._rgba[3]){for(a="backgroundColor"===n?e.parentNode:e;(""===s||"transparent"===s)&&a&&a.style;)try{s=t.css(a,"backgroundColor"),a=a.parentNode}catch(t){}o=o.blend(s&&"transparent"!==s?s:"_default")}o=o.toRgbaString()}try{e.style[n]=o}catch(t){}}},t.fx.step[n]=function(e){e.colorInit||(e.start=f(e.elem,n),e.end=f(e.end),e.colorInit=!0),t.cssHooks[n].set(e.elem,e.start.transition(e.end,e.pos))}})},f.hook(a),t.cssHooks.borderColor={expand:function(t){var e={};return h(["Top","Right","Bottom","Left"],function(n,r){e["border"+r+"Color"]=t}),e}},i=t.Color.names={aqua:"#00ffff",black:"#000000",blue:"#0000ff",fuchsia:"#ff00ff",gray:"#808080",green:"#008000",lime:"#00ff00",maroon:"#800000",navy:"#000080",olive:"#808000",purple:"#800080",red:"#ff0000",silver:"#c0c0c0",teal:"#008080",white:"#ffffff",yellow:"#ffff00",transparent:[null,null,null,0],_default:"#ffffff"}}(jQuery),function(){function n(e){var n,r,o=e.ownerDocument.defaultView?e.ownerDocument.defaultView.getComputedStyle(e,null):e.currentStyle,i={};if(o&&o.length&&o[0]&&o[o[0]])for(r=o.length;r--;)n=o[r],"string"==typeof o[n]&&(i[t.camelCase(n)]=o[n]);else for(n in o)"string"==typeof o[n]&&(i[n]=o[n]);return i}function r(e,n){var r,o,a={};for(r in n)o=n[r],e[r]!==o&&(i[r]||!t.fx.step[r]&&isNaN(parseFloat(o))||(a[r]=o));return a}var o=["add","remove","toggle"],i={border:1,borderBottom:1,borderColor:1,borderLeft:1,borderRight:1,borderTop:1,borderWidth:1,margin:1,padding:1};t.each(["borderLeftStyle","borderRightStyle","borderBottomStyle","borderTopStyle"],function(e,n){t.fx.step[n]=function(t){("none"!==t.end&&!t.setAttr||1===t.pos&&!t.setAttr)&&(jQuery.style(t.elem,n,t.end),t.setAttr=!0)}}),t.fn.addBack||(t.fn.addBack=function(t){return this.add(null==t?this.prevObject:this.prevObject.filter(t))}),t.effects.animateClass=function(e,i,a,s){var c=t.speed(i,a,s);return this.queue(function(){var i,a=t(this),s=a.attr("class")||"",f=c.children?a.find("*").addBack():a;f=f.map(function(){var e=t(this);return{el:e,start:n(this)}}),i=function(){t.each(o,function(t,n){e[n]&&a[n+"Class"](e[n])})},i(),f=f.map(function(){return this.end=n(this.el[0]),this.diff=r(this.start,this.end),this}),a.attr("class",s),f=f.map(function(){var e=this,n=t.Deferred(),r=t.extend({},c,{queue:!1,complete:function(){n.resolve(e)}});return this.el.animate(this.diff,r),n.promise()}),t.when.apply(t,f.get()).done(function(){i(),t.each(arguments,function(){var e=this.el;t.each(this.diff,function(t){e.css(t,"")})}),c.complete.call(a[0])})})},t.fn.extend({addClass:function(e){return function(n,r,o,i){return r?t.effects.animateClass.call(this,{add:n},r,o,i):e.apply(this,arguments)}}(t.fn.addClass),removeClass:function(e){return function(n,r,o,i){return arguments.length>1?t.effects.animateClass.call(this,{remove:n},r,o,i):e.apply(this,arguments)}}(t.fn.removeClass),toggleClass:function(n){return function(r,o,i,a,s){return"boolean"==typeof o||o===e?i?t.effects.animateClass.call(this,o?{add:r}:{remove:r},i,a,s):n.apply(this,arguments):t.effects.animateClass.call(this,{toggle:r},o,i,a)}}(t.fn.toggleClass),switchClass:function(e,n,r,o,i){return t.effects.animateClass.call(this,{add:n,remove:e},r,o,i)}})}(),function(){function r(e,n,r,o){return t.isPlainObject(e)&&(n=e,e=e.effect),e={effect:e},null==n&&(n={}),t.isFunction(n)&&(o=n,r=null,n={}),("number"==typeof n||t.fx.speeds[n])&&(o=r,r=n,n={}),t.isFunction(r)&&(o=r,r=null),n&&t.extend(e,n),r=r||n.duration,e.duration=t.fx.off?0:"number"==typeof r?r:r in t.fx.speeds?t.fx.speeds[r]:t.fx.speeds._default,e.complete=o||n.complete,e}function o(e){return!(e&&"number"!=typeof e&&!t.fx.speeds[e])||("string"==typeof e&&!t.effects.effect[e]||(!!t.isFunction(e)||"object"==typeof e&&!e.effect))}t.extend(t.effects,{version:"1.10.4",save:function(t,e){for(var r=0;r<e.length;r++)null!==e[r]&&t.data(n+e[r],t[0].style[e[r]])},restore:function(t,r){var o,i;for(i=0;i<r.length;i++)null!==r[i]&&(o=t.data(n+r[i]),o===e&&(o=""),t.css(r[i],o))},setMode:function(t,e){return"toggle"===e&&(e=t.is(":hidden")?"show":"hide"),e},getBaseline:function(t,e){var n,r;switch(t[0]){case"top":n=0;break;case"middle":n=.5;break;case"bottom":n=1;break;default:n=t[0]/e.height}switch(t[1]){case"left":r=0;break;case"center":r=.5;break;case"right":r=1;break;default:r=t[1]/e.width}return{x:r,y:n}},createWrapper:function(e){if(e.parent().is(".ui-effects-wrapper"))return e.parent();var n={width:e.outerWidth(!0),height:e.outerHeight(!0),"float":e.css("float")},r=t("<div></div>").addClass("ui-effects-wrapper").css({fontSize:"100%",background:"transparent",border:"none",margin:0,padding:0}),o={width:e.width(),height:e.height()},i=document.activeElement;try{i.id}catch(t){i=document.body}return e.wrap(r),(e[0]===i||t.contains(e[0],i))&&t(i).focus(),r=e.parent(),"static"===e.css("position")?(r.css({position:"relative"}),e.css({position:"relative"})):(t.extend(n,{position:e.css("position"),zIndex:e.css("z-index")}),t.each(["top","left","bottom","right"],function(t,r){n[r]=e.css(r),isNaN(parseInt(n[r],10))&&(n[r]="auto")}),e.css({position:"relative",top:0,left:0,right:"auto",bottom:"auto"})),e.css(o),r.css(n).show()},removeWrapper:function(e){var n=document.activeElement;return e.parent().is(".ui-effects-wrapper")&&(e.parent().replaceWith(e),(e[0]===n||t.contains(e[0],n))&&t(n).focus()),e},setTransition:function(e,n,r,o){return o=o||{},t.each(n,function(t,n){var i=e.cssUnit(n);i[0]>0&&(o[n]=i[0]*r+i[1])}),o}}),t.fn.extend({effect:function(){function e(e){function r(){t.isFunction(i)&&i.call(o[0]),t.isFunction(e)&&e()}var o=t(this),i=n.complete,s=n.mode;(o.is(":hidden")?"hide"===s:"show"===s)?(o[s](),r()):a.call(o[0],n,r)}var n=r.apply(this,arguments),o=n.mode,i=n.queue,a=t.effects.effect[n.effect];return t.fx.off||!a?o?this[o](n.duration,n.complete):this.each(function(){n.complete&&n.complete.call(this)}):i===!1?this.each(e):this.queue(i||"fx",e)},show:function(t){return function(e){if(o(e))return t.apply(this,arguments);var n=r.apply(this,arguments);return n.mode="show",this.effect.call(this,n)}}(t.fn.show),hide:function(t){return function(e){if(o(e))return t.apply(this,arguments);var n=r.apply(this,arguments);return n.mode="hide",this.effect.call(this,n)}}(t.fn.hide),toggle:function(t){return function(e){if(o(e)||"boolean"==typeof e)return t.apply(this,arguments);var n=r.apply(this,arguments);return n.mode="toggle",this.effect.call(this,n)}}(t.fn.toggle),cssUnit:function(e){var n=this.css(e),r=[];return t.each(["em","px","%","pt"],function(t,e){n.indexOf(e)>0&&(r=[parseFloat(n),e])}),r}})}(),function(){var e={};t.each(["Quad","Cubic","Quart","Quint","Expo"],function(t,n){e[n]=function(e){return Math.pow(e,t+2)}}),t.extend(e,{Sine:function(t){return 1-Math.cos(t*Math.PI/2)},Circ:function(t){return 1-Math.sqrt(1-t*t)},Elastic:function(t){return 0===t||1===t?t:-Math.pow(2,8*(t-1))*Math.sin((80*(t-1)-7.5)*Math.PI/15)},Back:function(t){return t*t*(3*t-2)},Bounce:function(t){for(var e,n=4;t<((e=Math.pow(2,--n))-1)/11;);return 1/Math.pow(4,3-n)-7.5625*Math.pow((3*e-2)/22-t,2)}}),t.each(e,function(e,n){t.easing["easeIn"+e]=n,t.easing["easeOut"+e]=function(t){return 1-n(1-t)},t.easing["easeInOut"+e]=function(t){return t<.5?n(2*t)/2:1-n(t*-2+2)/2}})}()}(jQuery),function(t){t.effects.effect.drop=function(e,n){var r,o=t(this),i=["position","top","bottom","left","right","opacity","height","width"],a=t.effects.setMode(o,e.mode||"hide"),s="show"===a,c=e.direction||"left",f="up"===c||"down"===c?"top":"left",u="up"===c||"left"===c?"pos":"neg",l={opacity:s?1:0};t.effects.save(o,i),o.show(),t.effects.createWrapper(o),r=e.distance||o["top"===f?"outerHeight":"outerWidth"](!0)/2,s&&o.css("opacity",0).css(f,"pos"===u?-r:r),l[f]=(s?"pos"===u?"+=":"-=":"pos"===u?"-=":"+=")+r,o.animate(l,{queue:!1,duration:e.duration,easing:e.easing,complete:function(){"hide"===a&&o.hide(),t.effects.restore(o,i),t.effects.removeWrapper(o),n()}})}}(jQuery);