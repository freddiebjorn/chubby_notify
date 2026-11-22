-- Typer, som andre scripts sender. ox_lib's 'inform' og 'warning' vises som info.
local TYPES = { info = 'info', inform = 'info', warning = 'info', success = 'success', error = 'error' }

-- GTA's farvekode i teksten (~r~, ~g~ osv.) kan fortælle typen, hvis kaldet ikke selv angiver den.
local CODE_TYPES = { r = 'error', g = 'success', y = 'info', o = 'info', b = 'info' }

local MAX_TITLE, MAX_TEXT = 60, 300

-- Fjerner GTA's farvekoder og <br>. ~n~ bliver til linjeskift.
local function clean(text, limit)
	text = tostring(text or '')
	text = text:gsub('~n~', '\n'):gsub('~[%a]~', ''):gsub('<br%s*/?>', '\n')
	return text:sub(1, limit)
end

local function notify(data)
	if type(data) ~= 'table' then return end

	local kind = TYPES[data.type]
	if not kind and type(data.description) == 'string' then
		local code = data.description:match('~(%a)~')
		kind = code and CODE_TYPES[code]
	end
	kind = kind or 'info'

	local duration = tonumber(data.duration) or Config.DefaultDuration
	duration = math.max(Config.MinDuration, math.min(Config.MaxDuration, duration))

	SendNUIMessage({
		action = 'notify',
		type = kind,
		title = clean(data.title or Config.Titles[kind], MAX_TITLE),
		description = clean(data.description, MAX_TEXT),
		duration = duration,
		icon = type(data.icon) == 'string' and data.icon or nil,
		position = Config.Position,
		maxVisible = Config.MaxVisible,
	})
end

exports('notify', notify)
RegisterNetEvent('chubby_notify:notify', notify)
