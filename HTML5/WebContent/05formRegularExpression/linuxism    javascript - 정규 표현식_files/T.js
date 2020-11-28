/*!
 * Tistory Javascript Framework, v0.1
 * Copyright (c) 2010 UCC FT Team, Front-end Technology Center, Daum Communications.
 * Licensed under Daum Common License : http://dna.daumcorp.com/forge/docs/daum-license-1.0.txt
 *
 * Includes jigu.js
 * Copyright (c) 2009 Front-end Technology Center, Daum Communications.
 * Project site: http://play.daumcorp.com/display/ftst/Jigu+Javascript+Framework
 * Licensed under Daum Common License : http://dna.daumcorp.com/forge/docs/daum-license-1.0.txt
 *
 * Date:
 */
(function(){
	if (!window.T) {
		/**
		 * @name T
		 * @namespace Tistory Javascript Framework의 namespace
		 */
		var T = window.T = {};

		T.domReady = function(fn){
			var ie = /*@cc_on!@*/ false;
			if (window.addEventListener) {
				//alert('DOMContentLoaded');
				document.addEventListener("DOMContentLoaded", fn, false);
			} else if (ie) { // IE
				document.attachEvent('onreadystatechange', function() {
					if (document.readyState == 'complete') {
						fn();
					}
				});
			}
		};

		T.cloneObject = function(obj) {
			if (obj && typeof(obj) == 'object') {
				var newObj = {};
				for (var p in obj) {
					newObj[p] = obj[p];
				}
				return newObj;
			}
		};

		T.m = {};
		T.admin = {};
		T.blog = {};
		T.ui = {};
		T.util = {};
		T.util.objectToQueryString = function(obj){
			var queryString = [];
			for (var key in obj) {
				queryString.push(key + '=' + encodeURIComponent(obj[key]));
			}
			return queryString.join('&');
		};
		T.util.$F = function(elem, form) {
			var result;
			if(!elem || (elem.tagName !== 'INPUT' && elem.tagName !== 'SELECT' && elem.tagName !== 'TEXTAREA')) {
				return '';
			}
			if (elem.type == 'checkbox') {
				if (elem.value && elem.checked) {
					result = elem.value;
				}
			} else if(elem.type=='radio') {
				var formElem = form[elem.name];
				for(var i = 0, elm = formElem, l = elm = length; i < l; i+=1) {
					if(elm[i].checked) {
						result = elm[i].value;
					}
				}
			} else if(elem.type =='select-multiple') {
				for(var i = 0, elm = daum.Element.getChildElements(elem), ret = [], l = elm.length; i < l; i+=1){
					if(elm[i].selected){ret.push(elm[i].value);}
				}
				result = ret;
			} else if(elem.value) {
				result = elem.value;
			}
			return result;
		};
		T.util.formSerializeNew = function(formId, isHash){
			var result = {};
			var form = daum.$(formId);
			if (form) {
				var elems = form.elements;
				for (var i = 0, elem; elem = elems[i]; i++) {
					if(!elem.disabled && elem.name) {
						var value = T.util.$F(elem, form);
						value = (daum.Object.isArray(value)) ? value.join(',') : value;
						result[elem.name] = value || '';
					}
				}
			}
			return (isHash !== true) ? T.util.objectToQueryString(result) : result;
		};
		T.util.formSerialize = function(formId, isHash){
			var result = {};
			var elem = daum.$(formId);
			if (elem) {
				var elems = elem.elements;
				for (var i = 0, elem; elem = elems[i]; i++) {
					if(!elem.disabled && elem.name) {
						var value = daum.$F(elem.name);
						value = (daum.Object.isArray(value)) ? value.join(',') : value;
						result[elem.name] = value || '';
					}
				}
			}
			return (isHash !== true) ? T.util.objectToQueryString(result) : result;
		};
		T.util.Cookie = {
			set: function(name, value, time, domain) {
				var expires = '', _domain = '';
				if (time) {
					var date = new Date();
					date.setTime(date.getTime() + time);
					expires = '; expires=' + date.toGMTString();
				}
				if (domain) {
					_domain = 'domain='+ domain;
				}
				document.cookie = name + "=" + value + expires + "; path=/;" + _domain;
			},

			get: function(name) {
				var cookies = document.cookie.split(";");
				for(var i = cookies.length; i--;) {
					if(cookies[i].indexOf("=") == -1) {
						if(name == cookies[i])
							return true;
					}
					else {
						var crumb = cookies[i].split("=");
						if(name == crumb[0].trim())
							return crumb[1].trim();
					}
				}
			},

			remove: function(name) {
				var date = new Date();
				date.setTime(date.getTime() - 1000);
				document.cookie = name + '=1; expires=' + date.toGMTString() + '; path=/; max-age=0';
			}
		};

		T.util.autoResizeHeight = function(fixedWidth, heightOffset) {
			var win = window.top;
			if (typeof fixedWidth == 'number') {
				// fixedWidth += $tx.gecko ? 16 : 0;
				var __STATUSBAR_SIZE = 50;
				var __SCROLLBAR_SIZE = 30;
				var __ASSUMPTION_MIN_HEIGHT = 300;
				if (!heightOffset)
					heightOffset = 0;

				var dl = self.document.documentElement;

				var diff = {}, pos = {
					x : 0,
					y : 0
				};
				var left = (win.screenLeft) ? win.screenLeft : win.screenX;
				var top = (win.screenTop) ? win.screenTop : win.screenY;

				win.resizeTo(fixedWidth, __ASSUMPTION_MIN_HEIGHT);

				var contentScreentHeight = (dl.clientHeight == dl.scrollHeight && dl.scrollHeight != dl.offsetHeight) ? dl.offsetHeight
						: dl.scrollHeight;
				var contentScreentWidth = (dl.clientWidth == dl.scrollWidth && dl.scrollWidth != dl.offsetWidth) ? dl.offsetWidth
						: dl.scrollWidth;
				if (contentScreentHeight > dl.clientHeight) {
					diff.height = contentScreentHeight - dl.clientHeight;
				} else { // for chrome -_-
					diff.width = 8;
					diff.height = dl.clientHeight - contentScreentHeight + 35;
				}
				pos.y = Math.min(screen.availHeight - contentScreentHeight - top
						- __STATUSBAR_SIZE, 0);
				pos.x = Math.min(screen.availWidth - contentScreentWidth - left
						- __SCROLLBAR_SIZE, 0);

				if (pos.x || pos.y) {
					if (!$tx.chrome) {
						win.moveBy(pos.x, pos.y);
					}
					win.resizeTo(fixedWidth, __ASSUMPTION_MIN_HEIGHT);
				}
				setTimeout(function() {
					win.resizeBy(0, diff.height + heightOffset);
				}, 20)
			} else {
				setTimeout(function() {
					var obj = fixedWidth;
					if (!obj)
						obj = document.getElementsByTagName('HTML')[0];
					var doc = document.getElementsByTagName('HTML')[0];
					var clientW = doc.clientWidth || doc.scrollWidth;
					var clientH = doc.clientHeight || doc.scrollHeight;
					var offsetW = obj.offsetWidth || obj.scrollWidth;
					var offsetH = obj.offsetHeight || obj.scrollHeight;
					// alert( clientW + " : " + clientH + " / " + offsetW + " : " +
					// offsetH )
					var gapWidth = offsetW - clientW;
					var gapHeight = offsetH - clientH;
					if (gapWidth || gapHeight) {
						win.resizeBy(gapWidth, gapHeight);
					}
				}, 100);
			}
		};

		T.util.getDate = function(format, gap) {
			var d = new Date();
			if (gap) {
				d = new Date(d.getTime() + 86400000 * gap);
			}
			var fullYear = d.getFullYear(), month = d.getMonth() + 1, date = d.getDate();

			switch (format) {
				case 'fullDate' :
					return fullYear + (month < 10 ? "0" + month : month) + date;
				case 'fullYear' :
					return fullYear;
				case 'month' :
					return month;
				case 'date' :
					return date;
			}
		};

		T.util.setTimeoutForT = function(fnc, time, scorp) {
			return window.setTimeout(jQuery.proxy(fnc, scorp), time);
		};

		T.util.setIntervalForT = function(fnc, time, scorp) {
			return window.setInterval(jQuery.proxy(fnc, scorp), time);
		};
	};
})();