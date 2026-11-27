-- Alt, der kan indstilles, står i config.lua

-- Finder typen: kaldets type, et andet navn for den eller GTA-farvekoden i beskeden
local function resolveType(data)
	local kind = data.type
	if not Config.Types[kind] then kind = Config.Aliases[kind] end
	if not Config.Types[kind] and type(data.description) == 'string' then
		kind = Config.ColorCodes[data.description:match('~(%a)~')]
	end
	return Config.Types[kind] and kind or Config.DefaultType
end

-- Fjerner GTA's farvekoder og <br>. ~n~ bliver til linjeskift.
local function clean(text, limit)
	text = tostring(text or '')
	text = text:gsub('~n~', '\n'):gsub('~[%a]~', ''):gsub('<br%s*/?>', '\n')
	return text:sub(1, limit)
end

local function notify(data)
	if type(data) ~= 'table' then return end

	local preset = Config.Types[resolveType(data)]
	local duration = tonumber(data.duration) or Config.DefaultDuration

	SendNUIMessage({
		action = 'notify',
		title = clean(data.title or preset.title, Config.MaxTitleLength),
		description = clean(data.description, Config.MaxTextLength),
		duration = math.max(Config.MinDuration, math.min(Config.MaxDuration, duration)),
		color = preset.color,
		icon = Config.Icons[data.icon] or Config.Icons[preset.icon],
		position = Config.Position,
		maxVisible = Config.MaxVisible,
		style = Config.Style,
	})
end

exports('notify', notify)
RegisterNetEvent('chubby_notify:notify', notify)
