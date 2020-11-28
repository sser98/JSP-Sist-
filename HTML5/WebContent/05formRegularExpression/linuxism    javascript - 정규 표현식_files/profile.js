var tistoryProfile = {
	init : function(info, elem) {
		this.profileInfo = eval(info);
		this.isItem = this.profileInfo.items && this.profileInfo.items.length > 0  ? true : false;
		if (!this.profileWrap) {
			this.fragment = document.createDocumentFragment();
			var pw = this.profileWrap = document.createElement('div');
			var wt = document.createElement('div');
			var wm = this.profileContent = document.createElement('div');
			var wmbw = document.createElement('div');
			var wmiw = this.itemWrap = document.createElement('ul');
			var wb = this.profileMine = document.createElement('div');
			pw.id = 'tistoryProfileLayer';
			wt.className = 'wrapTop';
			wm.className = 'wrapMiddle';
			wmbw.className = 'profileButtonWrap';
			wmiw.className = 'itemWrap';
			wmbw.innerHTML = '<span class="profileClose" onclick="tistoryProfile.close(); return false;"><\/span><span class="div"><\/span><a class="profileHelp" href="http://notice.tistory.com/1542" target="_blank" title="도움말"><\/a>';
			wb.className = this.isItem ? 'wrapBottomM' : 'wrapBottom';
			wm.appendChild(wmbw);
			wm.appendChild(wmiw);
			pw.appendChild(wt);
			pw.appendChild(wm);
			pw.appendChild(wb);
			this.fragment.appendChild(pw);
			this.myProfile('add');
			document.body.appendChild(this.fragment);
		} else {
			this.profileMine.className =  this.isItem ? 'wrapBottomM' : 'wrapBottom';
			this.myProfile();
		}
	},

	escapeHTML : function(s){
		return s.replace(/&/g,'&amp;').replace(/</g,'&lt;')
			.replace(/>/g,'&gt;').replace(/"/g,'&quot;')
			.replace(/'/g,'&#39;');
	},

	getCoords : function(e, elem) {
		var coords = { "left" : 0, "top" : 0, "right" : 0, "bottom" : 0 },
		w = elem.offsetWidth,
		h = elem.offsetHeight;
		if (e.pageX || e.pageY) {
			coords.left = e.pageX;
			coords.top = e.pageY;
		} else if (e.clientX || e.clientY) {
			coords.left = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
			coords.top = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
		}
		coords.right = coords.left + w;
		coords.bottom = coords.top + h;
		return coords;
	},

	myProfile : function(type) {
		if (type == 'add') {
			var infoWrap = document.createElement('div');
			var imgWrap = this.imgWrap = document.createElement('div');
			var title = this.profileName = document.createElement('div');
			var nickname = this.profileTitle = document.createElement('div');
			infoWrap.className = 'profileInfoWrap';
			imgWrap.className = 'profileImageWrap';
			imgWrap.innerHTML = '<img width="35" height="35" src="' +  this.profileInfo.url + '\/plugin\/TistoryProfileLayer_getBlogLogo" alt="" \/>';
			title.className = 'profileTitle';
			nickname.className = 'profileNickname';
			title.innerHTML = '<span><a class="title" href="' + this.profileInfo.url + '" target="_blank" title="' + this.escapeHTML(this.profileInfo.title) + '">' + this.escapeHTML(this.profileInfo.title) + '<\/a><\/span><a target="_blank" href="' + this.profileInfo.url + '/toolbar/popup/link/" onclick="window.open(this.href, \'_blank\', \'width=600,height=500\');return false;" class="AddRss" title="추가"><\/a>';
			nickname.innerHTML = this.escapeHTML(this.profileInfo.nickname);
			infoWrap.appendChild(title);
			infoWrap.appendChild(nickname);
			this.profileMine.appendChild(imgWrap);
			this.profileMine.appendChild(infoWrap);
		} else {
			this.imgWrap.innerHTML = '<img width="35" height="35" src="' +  this.profileInfo.url + '\/plugin\/TistoryProfileLayer_getBlogLogo" alt="" \/>';
			this.profileName.innerHTML = '<span><a class="title" href="' + this.profileInfo.url + '" target="_blank" title="' + this.escapeHTML(this.profileInfo.title) + '">' + this.escapeHTML(this.profileInfo.title) + '<\/a><\/span><a target="_blank" href="' + this.profileInfo.url + '/toolbar/popup/link/" onclick="window.open(this.href, \'_blank\', \'width=600,height=500\');return false;" class="AddRss" title="추가"><\/a>';
			this.profileTitle.innerHTML = this.escapeHTML(this.profileInfo.nickname);
		}
	},

	setItems : function() {
		if (this.isItem) {
			var items = this.profileInfo.items;
			this.itemWrap.innerHTML = '';
			var yozmFirst = false;
			for(var i = 0, item; item = items[i]; i++) {
				if (item.title == 'yozm' && item.d == 1) { yozmFirst = true; continue;}
				var firstItem = i == 0 || (i == 1 && yozmFirst) ? ' first' : '';
				var itemsString = '';
				var faviconImg, infoExp, infoExpType, urlType;
				var itemElem = document.createElement('li');
				if (item.d == 1) {
					var serviceInfo = item.info.split(',');
					var serviceItemType = serviceInfo[0];
					var serviceItemId = serviceInfo[1];
					switch (serviceItemType) {
					case 'view' :
						infoExpType = '구독';
						urlType = 'MyViewFanCount';
						break;

					case 'twitter' :
						infoExpType = 'follower';
						urlType = 'TwitterFollowCount';
						break;

					default:
						infoExpType = '';
						urlType = '';
					}
					faviconImg = '<img class="favicon" src="http:\/\/i1.daumcdn.net\/cfs.tistory\/static\/profilelayer\/ico_' + serviceItemType + '.gif" alt="favicon" \/>';
					infoExp = ' <span class="info">(' + infoExpType + ')<\/span>';
					var tempTitle = item.title;
					tempTitle = serviceItemType == 'twitter' ? 'twitter' : '';
				} else {
					infoExp = '', infoExpType = '', urlType = '';
					var tempTitle = item.title;
					faviconImg = item.iconurl ? '<img class="favicon" width="14" height="14" src="' + item.iconurl + '" alt="" \/>' : '';
				}
				itemElem.className = 'item' + firstItem;
				itemsString += '<div class="innerItem" onmouseover="tistoryProfile.itemHover(this, \'over\'); return false;"';
				itemsString += 'onmouseout="tistoryProfile.itemHover(this, \'out\'); return false;">' + faviconImg + '<a class="itemTitleAnchor" href="' + item.url + '" target="_blank" title="' + this.escapeHTML(tempTitle) + '">' + this.escapeHTML(tempTitle) + '</\a><\/div>';
				itemElem.innerHTML = itemsString;
				this.itemWrap.appendChild(itemElem);
				if (item.d == 1 && serviceInfo) {
					this.getInfo(itemElem, infoExpType, urlType, serviceItemId, item.title, serviceItemType);
				}
			}
		} else {
			this.itemWrap.innerHTML = '';
		}
		this.profileContent.style.height = 'auto';
		this.profileContent.style.height = this.profileContent.offsetHeight + 'px';
	},

	getInfo : function(item, infoType, urlType, id, title, serviceType) {
		var infoAnchors = item.getElementsByTagName('a');
		for (var i = 0, infoAnchor; infoAnchor = infoAnchors[i]; i++) {
			if (infoAnchor.className == 'itemTitleAnchor' && serviceType != 'twitter') {
				var request = new HTTPRequest('GET', '/plugin/TistoryProfileLayer_get' + urlType + '?id=' + encodeURIComponent(id));
				request.info = infoAnchor;
				request.onSuccess = function () {
					var cnt = this.getText("/response/result");
					var nickname = this.getText("/response/nickname");
					if (nickname) {
						this.info.title = tistoryProfile.escapeHTML(nickname);
						this.info.innerHTML = tistoryProfile.escapeHTML(nickname) + '<span class="info"> (' + infoType + '<span class="infoCount"> ' + cnt + '<\/span>)<\/span>';
					} else {
						this.info.innerHTML = tistoryProfile.escapeHTML(title);
					}
				};
				request.onError = function () {
					this.info.innerHTML = tistoryProfile.escapeHTML(title);
				};
				request.send();
			} else if (infoAnchor.className == 'itemTitleAnchor' && serviceType == 'twitter') {
				return;// remove twitter follow count
				var request = new HTTPRequest('JSON', 'http://api.twitter.com/1/users/show.json?screen_name=' + encodeURIComponent(id) + '&callback=?');
				request.info = infoAnchor;
				request.onSuccess = function () {
					if (this.jsonData) {
						var cnt = this.jsonData.followers_count;
						var nickname = this.jsonData.screen_name;
						if (cnt && nickname) {
							this.info.title = tistoryProfile.escapeHTML(nickname);
							this.info.innerHTML = tistoryProfile.escapeHTML(nickname) + '<span class="info"> (' + infoType + '<span class="infoCount"> ' + cnt + '<\/span>)<\/span>';
						} else {
							this.info.innerHTML = tistoryProfile.escapeHTML(title);
						}
					}
				};
				request.onError = function () {
					this.info.innerHTML = tistoryProfile.escapeHTML(title);
				};
				request.send();
			}
		}
	},

	getSidebarInfo : function(datas) {
		return;// remove twitter follow count
		if (datas) {
			for (var i = 0, data; data = datas[i]; i++) {
				if (data) {
					for (var r = 0, item;  item = data[r]; r++) {
						if (item && item.itemId && item.screen_name) {
							var request = new HTTPRequest('JSON', 'http://api.twitter.com/1/users/show.json?screen_name=' + encodeURIComponent(item.screen_name) + '&callback=?');
							request.info = document.getElementById(item.itemId);
							request.onSuccess = function () {
								if (this.jsonData) {
									var cnt = this.jsonData.followers_count;
									var nickname = this.jsonData.screen_name;
									if (cnt && nickname) {
										this.info.title = tistoryProfile.escapeHTML(nickname);
										this.info.innerHTML = tistoryProfile.escapeHTML(nickname) + '<span class="info"> (follower <span class="infoCount"> ' + cnt + '<\/span>)<\/span>';
									}
								}
							};
							request.send();
						}
					}
				}
			}
		}
	},

	pressTwitter : function(target, json) {
		if (target && json) {
			target.innerHTML = this.escapeHTML(json.screen_name) + '<span class="info"> (follower<span class="infoCount"> ' + json.followers_count + '<\/span>)<\/span>';
		}
	},

	itemHover : function(elem, type) {
		if (type == "over") {
			elem.className = elem.className + ' hover';
		} else {
			elem.className = elem.className.split(' hover').join('');
		}
	},

	show : function(e, elem, info) {
		var e = e ? e : window.event;
		if (this.targetElem && this.targetElem == elem) {
			if (this.profileWrap.style.visibility != 'visible') {
				var elemCoords = this.getCoords(e, elem);
				var pw = this.profileWrap;
				var gap = {h : 10, w : 14};
				pw.style.left = elemCoords.left - gap.w + 'px';
				pw.style.top = elemCoords.top - gap.h - pw.offsetHeight + 'px';
				this.profileWrap.style.visibility = 'visible';
			} else {
				this.profileWrap.style.visibility = 'hidden';
			}
		} else {
			this.init(info, elem);
			this.targetElem = elem;
			this.setItems();
			var elemCoords = this.getCoords(e, elem);
			var pw = this.profileWrap;
			var gap = {h : 10, w : 14};
			pw.style.left = elemCoords.left - gap.w + 'px';
			pw.style.top = elemCoords.top - gap.h - pw.offsetHeight + 'px';
			pw.style.visibility = 'visible';
		}
		window.__pageTracker = {};
		if (typeof __Tiara != "undefined" && typeof __Tiara.__getTracker != "undefined") {
			__pageTracker = __Tiara.__getTracker();
		} else {
			__pageTracker.__trackPageview = function(){};
			__pageTracker.__addParam = function(){};
		}
		__pageTracker.__addParam("svcdomain","user.tistory.com");
		__pageTracker.__addParam("param2","p");
		window.setTimeout("try { __pageTracker.__trackPageview(window.location.href); } catch(e) {}", 1);
	},

	close : function() {
		this.profileWrap.style.visibility = 'hidden';
	}
};