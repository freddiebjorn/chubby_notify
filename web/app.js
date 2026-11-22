(function () {
	'use strict';

	var stack = document.getElementById('stack');
	var POSITIONS = ['right-center', 'left-center', 'top-right', 'top-left', 'bottom-right', 'bottom-left', 'top-center', 'bottom-center'];
	var OUT_MS = 230;

	// Hvid fyldt figur. Selve tegnet i ikonet får kortets egen farve (--c).
	var ICONS = {
		error: '<svg class="note__ico" viewBox="0 0 24 24"><path fill="#fff" d="M12 2.8 22.4 21H1.6L12 2.8z"/><path fill="var(--c)" d="M11 9.4h2v6h-2zM11 16.6h2v2h-2z"/></svg>',
		success: '<svg class="note__ico" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10.5" fill="#fff"/><path fill="none" stroke="var(--c)" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round" d="M7 12.4l3.4 3.4L17 9"/></svg>',
		info: '<svg class="note__ico" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10.5" fill="#fff"/><path fill="var(--c)" d="M11 10.5h2v7h-2zM11 6.5h2v2h-2z"/></svg>',
		// Valgfrit ikon: send icon = 'dollar' sammen med beskeden
		dollar: '<svg class="note__ico" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10.5" fill="#fff"/><path fill="none" stroke="var(--c)" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round" d="M14.9 9.3c-.4-1-1.5-1.6-2.9-1.6-1.7 0-2.9.9-2.9 2.2 0 3 6 1.4 6 4.4 0 1.4-1.3 2.3-3.1 2.3-1.5 0-2.7-.6-3.1-1.8M12 5.6v2M12 16.7v1.9"/></svg>'
	};
	// Tegnets farve = kortets farve. Info er mørk grøn, ellers kunne man ikke se tegnet.
	var COLORS = { error: '#7e3536', success: '#347e48', info: '#0b6b52' };

	function remove(el) {
		if (!el.parentNode || el.classList.contains('is-out')) return;
		el.classList.add('is-out');
		setTimeout(function () { el.remove(); }, OUT_MS);
	}

	function show(d) {
		if (POSITIONS.indexOf(d.position) !== -1) stack.setAttribute('data-pos', d.position);
		else if (!stack.hasAttribute('data-pos')) stack.setAttribute('data-pos', 'right-center');

		var type = ICONS[d.type] && d.type !== 'dollar' ? d.type : 'info';
		var el = document.createElement('div');
		el.className = 'note note--' + type;
		el.style.setProperty('--c', COLORS[type]);

		// Tekst sættes med textContent, så indholdet aldrig bliver tolket som HTML
		var title = document.createElement('div');
		title.className = 'note__title';
		title.innerHTML = ICONS[d.icon] || ICONS[type];
		var label = document.createElement('span');
		label.textContent = d.title || '';
		title.appendChild(label);

		var text = document.createElement('div');
		text.className = 'note__text';
		text.textContent = d.description || '';

		el.appendChild(title);
		el.appendChild(text);
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
