--[[
	chubby_notify - alle indstillinger står i denne fil.
	Du behøver ikke rette i andre filer. Genstart scriptet, når du har gemt: ensure chubby_notify
]]

Config = {}

---------------------------------------------------------------------------
-- Placering og tid
---------------------------------------------------------------------------

-- 'right-center', 'left-center', 'top-right', 'top-left', 'bottom-right', 'bottom-left', 'top-center', 'bottom-center'
Config.Position = 'right-center'

-- Så mange kan stå på skærmen på én gang. Kommer der flere, forsvinder den ældste.
Config.MaxVisible = 5

-- Varighed i millisekunder. Standard bruges, når kaldet ikke angiver en.
Config.DefaultDuration = 4000
Config.MinDuration = 1000
Config.MaxDuration = 30000

-- Længere tekster skæres af
Config.MaxTitleLength = 60
Config.MaxTextLength = 300

---------------------------------------------------------------------------
-- Udseende (mål er i pixels)
---------------------------------------------------------------------------

Config.Style = {
	width = 390,           -- bredden på en notifikation
	edge = 20,             -- afstand til skærmens kant
	gap = 12,              -- luft mellem notifikationer
	radius = 8,            -- runde hjørner (0 = skarpe)
	titleSize = 14,        -- skriftstørrelse i overskriften
	textSize = 13,         -- skriftstørrelse i beskeden
	textColor = '#ffffff', -- farve på tekst og ikon
	font = 'Poppins',      -- Poppins følger med. Du kan også skrive en skrifttype fra Windows, fx 'Arial'
}

---------------------------------------------------------------------------
-- Typer: overskrift, farve og ikon
---------------------------------------------------------------------------

-- title:  overskriften, når kaldet ikke selv angiver en
-- color:  baggrundsfarven. rgba(rød, grøn, blå, synlighed fra 0 til 1) eller en farvekode som '#006d52'
-- icon:   navnet på et ikon fra Config.Icons længere nede
--
-- Du kan lave dine egne typer: kopiér en linje, giv den et nyt navn, og brug navnet som type i dit kald.
Config.Types = {
	info    = { title = 'Info',   color = 'rgba(0, 109, 82, 0.88)',  icon = 'info' },
	success = { title = 'Succes', color = 'rgba(52, 126, 72, 0.75)', icon = 'success' },
	error   = { title = 'Fejl',   color = 'rgba(126, 53, 54, 0.75)', icon = 'error' },
}

-- Typen, der bruges, når et kald ikke angiver en kendt type
Config.DefaultType = 'info'

-- Andre navne for en type (ox_lib sender fx 'inform' og 'warning')
Config.Aliases = {
	inform = 'info',
	warning = 'info',
}

-- Har kaldet ingen type, kan en GTA-farvekode i beskeden vælge den: ~r~ giver 'error' osv.
Config.ColorCodes = {
	r = 'error',
	g = 'success',
	y = 'info',
	o = 'info',
	b = 'info',
}

---------------------------------------------------------------------------
-- Ikoner
---------------------------------------------------------------------------

-- Hvert ikon er en SVG-sti tegnet i 24 x 24.
-- Nyt ikon: find det på https://pictogrammers.com/library/mdi/, vælg "Copy SVG Path",
-- og sæt det ind herunder med et navn. Brug navnet som icon i en type eller i dit kald.
-- De fire ikoner her er fra Google Material Icons (Apache 2.0).
Config.Icons = {
	info = 'M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-6h2v6zm0-8h-2V7h2v2z',
	success = 'M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z',
	error = 'M1 21h22L12 2 1 21zm12-3h-2v-2h2v2zm0-4h-2v-4h2v4z',
	dollar = 'M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1.41 16.09V20h-2.67v-1.93c-1.71-.36-3.16-1.46-3.27-3.4h1.96c.1 1.05.82 1.87 2.65 1.87 1.96 0 2.4-.98 2.4-1.59 0-.83-.44-1.61-2.67-2.14-2.48-.6-4.18-1.62-4.18-3.67 0-1.72 1.39-2.84 3.11-3.21V4h2.67v1.95c1.86.45 2.79 1.86 2.85 3.39H14.3c-.05-1.11-.64-1.87-2.22-1.87-1.5 0-2.4.68-2.4 1.64 0 .84.65 1.39 2.67 1.91s4.18 1.39 4.18 3.91c-.01 1.83-1.38 2.83-3.12 3.16z',
}
