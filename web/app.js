// Alt, der kan indstilles, står i config.lua og sendes med hver notifikation
(function () {
	'use strict';

	var stack = document.getElementById('stack');
	var POSITIONS = ['right-center', 'left-center', 'top-right', 'top-left', 'bottom-right', 'bottom-left', 'top-center', 'bottom-center'];
	var SIZES = { width: '--width', edge: '--edge', gap: '--gap', radius: '--radius', titleSize: '--title-size', textSize: '--text-size' };
	var OUT_MS = 230;

	function applyStyle(style) {
		Object.keys(SIZES).forEach(function (key) {
			if (typeof style[key] === 'number') stack.style.setProperty(SIZES[key], style[key] + 'px');
		});
		if (style.textColor) stack.style.setProperty('--text-color', style.textColor);
		if (style.font) stack.style.setProperty('--font', '"' + style.font + '", "Segoe UI", sans-serif');
	}

	function icon(path) {
		var ns = 'http://www.w3.org/2000/svg';
		var svg = document.createElementNS(ns, 'svg');
		svg.setAttribute('class', 'note__ico');
		svg.setAttribute('viewBox', '0 0 24 24');
		var shape = document.createElementNS(ns, 'path');
		shape.setAttribute('d', path);
		svg.appendChild(shape);
		return svg;
	}

	// textContent: indholdet bliver aldrig tolket som HTML
	function element(tag, className, text) {
		var el = document.createElement(tag);
		el.className = className;
		el.textContent = text || '';
		return el;
	}

	function remove(el) {
		if (!el.parentNode || el.classList.contains('is-out')) return;
		el.classList.add('is-out');
		setTimeout(function () { el.remove(); }, OUT_MS);
	}

	function show(d) {
		stack.setAttribute('data-pos', POSITIONS.indexOf(d.position) !== -1 ? d.position : 'right-center');
		applyStyle(d.style || {});

		var el = element('div', 'note');
		el.style.background = d.color;

		var title = element('div', 'note__title');
		if (d.icon) title.appendChild(icon(d.icon));
		title.appendChild(element('span', '', d.title));

		el.appendChild(title);
		el.appendChild(element('div', 'note__text', d.description));
		stack.appendChild(el);

		// For mange på én gang: den ældste fjernes
		var max = Math.max(1, Number(d.maxVisible) || 5);
		var live = stack.querySelectorAll('.note:not(.is-out)');
		for (var i = 0; i < live.length - max; i++) remove(live[i]);

		setTimeout(function () { remove(el); }, d.duration || 4000);
	}

	window.addEventListener('message', function (event) {
		var d = event.data || {};
		if (d.action === 'notify') show(d);
	});
})();
