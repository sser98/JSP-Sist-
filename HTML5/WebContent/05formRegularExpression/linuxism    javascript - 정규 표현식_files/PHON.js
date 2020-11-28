/// PHP Object Notation

var PHON = new function () {
}

PHON.serialize = function (object) {
	switch (object) {
		case null:
			return "N;";
	}
	switch (typeof object) {
		case "boolean":
			return "b:" + (object ? "1;" : "0;");
		case "number":
			if ((object % 1) == 0)
				return "i:" + object + ";";
			else
				return "d:" + object + ";";
		case "string":
			return "s:" + this.strlen(object) + ':"' + object + '";';
		case "object":
			if (object.constructor == Array) {
				var length = 0;
				var notation = "";
				for (var key in object) {
					length++;
					if ((Number(key) == NaN) || ((Number(key) % 1) != 0))
						notation += this.serialize(key);
					else
						notation += this.serialize(Number(key));
					notation += this.serialize(object[key]);
				}
				return "a:" + length + ":{" + notation + "}";
			} else {
				var className = object.toString();
				var length = 0;
				var notation = "";
				for (var key in object) {
					length++;
					notation += this.serialize(key);
					notation += this.serialize(object[key]);
				}
				return "O:" + className.length + ':"' + className + '":' + length + ":{" + notation + "}";
			}
			break;
		default:
			alert(typeof object);
			break;
	}
	return null;
}

PHON.unserialize = function (notation) {
	return this._unserialize(notation)[0];
}

PHON._unserialize = function (notation) {
	switch (notation.charAt(0)) {
		case "N":
			return [null, notation.substr(2)];
		case "b":
			return [notation.substr(2, 1) == "1", notation.substr(4)];
		case "i":
		case "d":
			var value = notation.substring(2, notation.indexOf(";"));
			return [Number(value), notation.substr(value.length + 3)];
		case "s":
			var length = this._getLength(notation);
			var start = 4 + String(length).length;
			for (var end = start; (end = notation.indexOf('"', end)) > 0; end++) {
				if (this.strlen(notation.substring(start, end)) == length)
					return [notation.substring(start, end), notation.substr(end + 2)];
			}
			break;
		case "a":
			var length = this._getLength(notation);
			notation = notation.substr(String(length).length + 4);
			var array = new Array();
			var key;
			var value;
			for (var i = 0; i < length; i++) {
				key = this._unserialize(notation);
				notation = key[1];
				value = this._unserialize(notation);
				notation = value[1];
				array[key[0]] = value[0];
			}
			return [array, notation.substr(1)];
		case "O":
			var length = this._getLength(notation);
			var className = notation.substr(String(length).length + 4, length);
			notation  = notation.substr(String(length).length + 6 + length);
			var properties = Number(notation.substring(0, notation.indexOf(":")));
			notation = notation.substr(String(properties).length + 2);

			var object = new Object(className);
			var property;
			var value;
			for (var i = 0; i < properties; i++) {
				key = this._unserialize(notation);
				notation = key[1];
				value = this._unserialize(notation);
				notation = value[1];
				object[key[0]] = value[0];
			}
			return [object, notation.substr(1)];
	}
	return [undefined, null];
}

PHON.strlen = function (str) {
	len = 0;
	for (i = 0; i < str.length; i++) {
		if (str.charCodeAt(i) < 0x80)
			len += 1;
		else if (str.charCodeAt(i) < 0x800)
			len += 2;
		else if (str.charCodeAt(i) < 0x10000)
			len += 3;
		else
			len += 4;
	}
	return len;
}

PHON._getLength = function (notation) {
	return Number(notation.substring(2, notation.indexOf(":", 3)));
}