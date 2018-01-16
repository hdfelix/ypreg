!function(t,e){function i(e,i){var s,r,o,a=e.nodeName.toLowerCase();return"area"===a?(r=(s=e.parentNode).name,!(!e.href||!r||"map"!==s.nodeName.toLowerCase())&&(!!(o=t("img[usemap=#"+r+"]")[0])&&n(o))):(/input|select|textarea|button|object/.test(a)?!e.disabled:"a"===a?e.href||i:i)&&n(e)}function n(e){return t.expr.filters.visible(e)&&!t(e).parents().addBack().filter(function(){return"hidden"===t.css(this,"visibility")}).length}var s,r,o=0,a=/^ui-id-\d+$/;t.ui=t.ui||{},t.extend(t.ui,{version:"1.10.4",keyCode:{BACKSPACE:8,COMMA:188,DELETE:46,DOWN:40,END:35,ENTER:13,ESCAPE:27,HOME:36,LEFT:37,NUMPAD_ADD:107,NUMPAD_DECIMAL:110,NUMPAD_DIVIDE:111,NUMPAD_ENTER:108,NUMPAD_MULTIPLY:106,NUMPAD_SUBTRACT:109,PAGE_DOWN:34,PAGE_UP:33,PERIOD:190,RIGHT:39,SPACE:32,TAB:9,UP:38}}),t.fn.extend({focus:(s=t.fn.focus,function(e,i){return"number"==typeof e?this.each(function(){var n=this;setTimeout(function(){t(n).focus(),i&&i.call(n)},e)}):s.apply(this,arguments)}),scrollParent:function(){var e;return e=t.ui.ie&&/(static|relative)/.test(this.css("position"))||/absolute/.test(this.css("position"))?this.parents().filter(function(){return/(relative|absolute|fixed)/.test(t.css(this,"position"))&&/(auto|scroll)/.test(t.css(this,"overflow")+t.css(this,"overflow-y")+t.css(this,"overflow-x"))}).eq(0):this.parents().filter(function(){return/(auto|scroll)/.test(t.css(this,"overflow")+t.css(this,"overflow-y")+t.css(this,"overflow-x"))}).eq(0),/fixed/.test(this.css("position"))||!e.length?t(document):e},zIndex:function(i){if(i!==e)return this.css("zIndex",i);if(this.length)for(var n,s,r=t(this[0]);r.length&&r[0]!==document;){if(("absolute"===(n=r.css("position"))||"relative"===n||"fixed"===n)&&(s=parseInt(r.css("zIndex"),10),!isNaN(s)&&0!==s))return s;r=r.parent()}return 0},uniqueId:function(){return this.each(function(){this.id||(this.id="ui-id-"+ ++o)})},removeUniqueId:function(){return this.each(function(){a.test(this.id)&&t(this).removeAttr("id")})}}),t.extend(t.expr[":"],{data:t.expr.createPseudo?t.expr.createPseudo(function(e){return function(i){return!!t.data(i,e)}}):function(e,i,n){return!!t.data(e,n[3])},focusable:function(e){return i(e,!isNaN(t.attr(e,"tabindex")))},tabbable:function(e){var n=t.attr(e,"tabindex"),s=isNaN(n);return(s||n>=0)&&i(e,!s)}}),t("<a>").outerWidth(1).jquery||t.each(["Width","Height"],function(i,n){function s(e,i,n,s){return t.each(r,function(){i-=parseFloat(t.css(e,"padding"+this))||0,n&&(i-=parseFloat(t.css(e,"border"+this+"Width"))||0),s&&(i-=parseFloat(t.css(e,"margin"+this))||0)}),i}var r="Width"===n?["Left","Right"]:["Top","Bottom"],o=n.toLowerCase(),a={innerWidth:t.fn.innerWidth,innerHeight:t.fn.innerHeight,outerWidth:t.fn.outerWidth,outerHeight:t.fn.outerHeight};t.fn["inner"+n]=function(i){return i===e?a["inner"+n].call(this):this.each(function(){t(this).css(o,s(this,i)+"px")})},t.fn["outer"+n]=function(e,i){return"number"!=typeof e?a["outer"+n].call(this,e):this.each(function(){t(this).css(o,s(this,e,!0,i)+"px")})}}),t.fn.addBack||(t.fn.addBack=function(t){return this.add(null==t?this.prevObject:this.prevObject.filter(t))}),t("<a>").data("a-b","a").removeData("a-b").data("a-b")&&(t.fn.removeData=(r=t.fn.removeData,function(e){return arguments.length?r.call(this,t.camelCase(e)):r.call(this)})),t.ui.ie=!!/msie [\w.]+/.exec(navigator.userAgent.toLowerCase()),t.support.selectstart="onselectstart"in document.createElement("div"),t.fn.extend({disableSelection:function(){return this.bind((t.support.selectstart?"selectstart":"mousedown")+".ui-disableSelection",function(t){t.preventDefault()})},enableSelection:function(){return this.unbind(".ui-disableSelection")}}),t.extend(t.ui,{plugin:{add:function(e,i,n){var s,r=t.ui[e].prototype;for(s in n)r.plugins[s]=r.plugins[s]||[],r.plugins[s].push([i,n[s]])},call:function(t,e,i){var n,s=t.plugins[e];if(s&&t.element[0].parentNode&&11!==t.element[0].parentNode.nodeType)for(n=0;n<s.length;n++)t.options[s[n][0]]&&s[n][1].apply(t.element,i)}},hasScroll:function(e,i){if("hidden"===t(e).css("overflow"))return!1;var n=i&&"left"===i?"scrollLeft":"scrollTop",s=!1;return e[n]>0||(e[n]=1,s=e[n]>0,e[n]=0,s)}})}(jQuery),function(t,e){var i=0,n=Array.prototype.slice,s=t.cleanData;t.cleanData=function(e){for(var i,n=0;null!=(i=e[n]);n++)try{t(i).triggerHandler("remove")}catch(r){}s(e)},t.widget=function(e,i,n){var s,r,o,a,u={},l=e.split(".")[0];e=e.split(".")[1],s=l+"-"+e,n||(n=i,i=t.Widget),t.expr[":"][s.toLowerCase()]=function(e){return!!t.data(e,s)},t[l]=t[l]||{},r=t[l][e],o=t[l][e]=function(t,e){if(!this._createWidget)return new o(t,e);arguments.length&&this._createWidget(t,e)},t.extend(o,r,{version:n.version,_proto:t.extend({},n),_childConstructors:[]}),(a=new i).options=t.widget.extend({},a.options),t.each(n,function(e,n){var s,r;t.isFunction(n)?u[e]=(s=function(){return i.prototype[e].apply(this,arguments)},r=function(t){return i.prototype[e].apply(this,t)},function(){var t,e=this._super,i=this._superApply;return this._super=s,this._superApply=r,t=n.apply(this,arguments),this._super=e,this._superApply=i,t}):u[e]=n}),o.prototype=t.widget.extend(a,{widgetEventPrefix:r?a.widgetEventPrefix||e:e},u,{constructor:o,namespace:l,widgetName:e,widgetFullName:s}),r?(t.each(r._childConstructors,function(e,i){var n=i.prototype;t.widget(n.namespace+"."+n.widgetName,o,i._proto)}),delete r._childConstructors):i._childConstructors.push(o),t.widget.bridge(e,o)},t.widget.extend=function(i){for(var s,r,o=n.call(arguments,1),a=0,u=o.length;a<u;a++)for(s in o[a])r=o[a][s],o[a].hasOwnProperty(s)&&r!==e&&(t.isPlainObject(r)?i[s]=t.isPlainObject(i[s])?t.widget.extend({},i[s],r):t.widget.extend({},r):i[s]=r);return i},t.widget.bridge=function(i,s){var r=s.prototype.widgetFullName||i;t.fn[i]=function(o){var a="string"==typeof o,u=n.call(arguments,1),l=this;return o=!a&&u.length?t.widget.extend.apply(null,[o].concat(u)):o,a?this.each(function(){var n,s=t.data(this,r);return s?t.isFunction(s[o])&&"_"!==o.charAt(0)?(n=s[o].apply(s,u))!==s&&n!==e?(l=n&&n.jquery?l.pushStack(n.get()):n,!1):void 0:t.error("no such method '"+o+"' for "+i+" widget instance"):t.error("cannot call methods on "+i+" prior to initialization; attempted to call method '"+o+"'")}):this.each(function(){var e=t.data(this,r);e?e.option(o||{})._init():t.data(this,r,new s(o,this))}),l}},t.Widget=function(){},t.Widget._childConstructors=[],t.Widget.prototype={widgetName:"widget",widgetEventPrefix:"",defaultElement:"<div>",options:{disabled:!1,create:null},_createWidget:function(e,n){n=t(n||this.defaultElement||this)[0],this.element=t(n),this.uuid=i++,this.eventNamespace="."+this.widgetName+this.uuid,this.options=t.widget.extend({},this.options,this._getCreateOptions(),e),this.bindings=t(),this.hoverable=t(),this.focusable=t(),n!==this&&(t.data(n,this.widgetFullName,this),this._on(!0,this.element,{remove:function(t){t.target===n&&this.destroy()}}),this.document=t(n.style?n.ownerDocument:n.document||n),this.window=t(this.document[0].defaultView||this.document[0].parentWindow)),this._create(),this._trigger("create",null,this._getCreateEventData()),this._init()},_getCreateOptions:t.noop,_getCreateEventData:t.noop,_create:t.noop,_init:t.noop,destroy:function(){this._destroy(),this.element.unbind(this.eventNamespace).removeData(this.widgetName).removeData(this.widgetFullName).removeData(t.camelCase(this.widgetFullName)),this.widget().unbind(this.eventNamespace).removeAttr("aria-disabled").removeClass(this.widgetFullName+"-disabled ui-state-disabled"),this.bindings.unbind(this.eventNamespace),this.hoverable.removeClass("ui-state-hover"),this.focusable.removeClass("ui-state-focus")},_destroy:t.noop,widget:function(){return this.element},option:function(i,n){var s,r,o,a=i;if(0===arguments.length)return t.widget.extend({},this.options);if("string"==typeof i)if(a={},i=(s=i.split(".")).shift(),s.length){for(r=a[i]=t.widget.extend({},this.options[i]),o=0;o<s.length-1;o++)r[s[o]]=r[s[o]]||{},r=r[s[o]];if(i=s.pop(),1===arguments.length)return r[i]===e?null:r[i];r[i]=n}else{if(1===arguments.length)return this.options[i]===e?null:this.options[i];a[i]=n}return this._setOptions(a),this},_setOptions:function(t){var e;for(e in t)this._setOption(e,t[e]);return this},_setOption:function(t,e){return this.options[t]=e,"disabled"===t&&(this.widget().toggleClass(this.widgetFullName+"-disabled ui-state-disabled",!!e).attr("aria-disabled",e),this.hoverable.removeClass("ui-state-hover"),this.focusable.removeClass("ui-state-focus")),this},enable:function(){return this._setOption("disabled",!1)},disable:function(){return this._setOption("disabled",!0)},_on:function(e,i,n){var s,r=this;"boolean"!=typeof e&&(n=i,i=e,e=!1),n?(i=s=t(i),this.bindings=this.bindings.add(i)):(n=i,i=this.element,s=this.widget()),t.each(n,function(n,o){function a(){if(e||!0!==r.options.disabled&&!t(this).hasClass("ui-state-disabled"))return("string"==typeof o?r[o]:o).apply(r,arguments)}"string"!=typeof o&&(a.guid=o.guid=o.guid||a.guid||t.guid++);var u=n.match(/^(\w+)\s*(.*)$/),l=u[1]+r.eventNamespace,h=u[2];h?s.delegate(h,l,a):i.bind(l,a)})},_off:function(t,e){e=(e||"").split(" ").join(this.eventNamespace+" ")+this.eventNamespace,t.unbind(e).undelegate(e)},_delay:function(t,e){function i(){return("string"==typeof t?n[t]:t).apply(n,arguments)}var n=this;return setTimeout(i,e||0)},_hoverable:function(e){this.hoverable=this.hoverable.add(e),this._on(e,{mouseenter:function(e){t(e.currentTarget).addClass("ui-state-hover")},mouseleave:function(e){t(e.currentTarget).removeClass("ui-state-hover")}})},_focusable:function(e){this.focusable=this.focusable.add(e),this._on(e,{focusin:function(e){t(e.currentTarget).addClass("ui-state-focus")},focusout:function(e){t(e.currentTarget).removeClass("ui-state-focus")}})},_trigger:function(e,i,n){var s,r,o=this.options[e];if(n=n||{},(i=t.Event(i)).type=(e===this.widgetEventPrefix?e:this.widgetEventPrefix+e).toLowerCase(),i.target=this.element[0],r=i.originalEvent)for(s in r)s in i||(i[s]=r[s]);return this.element.trigger(i,n),!(t.isFunction(o)&&!1===o.apply(this.element[0],[i].concat(n))||i.isDefaultPrevented())}},t.each({show:"fadeIn",hide:"fadeOut"},function(e,i){t.Widget.prototype["_"+e]=function(n,s,r){"string"==typeof s&&(s={effect:s});var o,a=s?!0===s||"number"==typeof s?i:s.effect||i:e;"number"==typeof(s=s||{})&&(s={duration:s}),o=!t.isEmptyObject(s),s.complete=r,s.delay&&n.delay(s.delay),o&&t.effects&&t.effects.effect[a]?n[e](s):a!==e&&n[a]?n[a](s.duration,s.easing,r):n.queue(function(i){t(this)[e](),r&&r.call(n[0]),i()})}})}(jQuery),function(t,e){t.widget("ui.progressbar",{version:"1.10.4",options:{max:100,value:0,change:null,complete:null},min:0,_create:function(){this.oldValue=this.options.value=this._constrainedValue(),this.element.addClass("ui-progressbar ui-widget ui-widget-content ui-corner-all").attr({role:"progressbar","aria-valuemin":this.min}),this.valueDiv=t("<div class='ui-progressbar-value ui-widget-header ui-corner-left'></div>").appendTo(this.element),this._refreshValue()},_destroy:function(){this.element.removeClass("ui-progressbar ui-widget ui-widget-content ui-corner-all").removeAttr("role").removeAttr("aria-valuemin").removeAttr("aria-valuemax").removeAttr("aria-valuenow"),this.valueDiv.remove()},value:function(t){if(t===e)return this.options.value;this.options.value=this._constrainedValue(t),this._refreshValue()},_constrainedValue:function(t){return t===e&&(t=this.options.value),this.indeterminate=!1===t,"number"!=typeof t&&(t=0),!this.indeterminate&&Math.min(this.options.max,Math.max(this.min,t))},_setOptions:function(t){var e=t.value;delete t.value,this._super(t),this.options.value=this._constrainedValue(e),this._refreshValue()},_setOption:function(t,e){"max"===t&&(e=Math.max(this.min,e)),this._super(t,e)},_percentage:function(){return this.indeterminate?100:100*(this.options.value-this.min)/(this.options.max-this.min)},_refreshValue:function(){var e=this.options.value,i=this._percentage();this.valueDiv.toggle(this.indeterminate||e>this.min).toggleClass("ui-corner-right",e===this.options.max).width(i.toFixed(0)+"%"),this.element.toggleClass("ui-progressbar-indeterminate",this.indeterminate),this.indeterminate?(this.element.removeAttr("aria-valuenow"),this.overlayDiv||(this.overlayDiv=t("<div class='ui-progressbar-overlay'></div>").appendTo(this.valueDiv))):(this.element.attr({"aria-valuemax":this.options.max,"aria-valuenow":e}),this.overlayDiv&&(this.overlayDiv.remove(),this.overlayDiv=null)),this.oldValue!==e&&(this.oldValue=e,this._trigger("change")),e===this.options.max&&this._trigger("complete")}})}(jQuery);