Config = {}

-- Hvor notifikationerne står på skærmen. Gyldige værdier:
-- 'right-center', 'left-center', 'top-right', 'top-left', 'bottom-right', 'bottom-left', 'top-center', 'bottom-center'
Config.Position = 'right-center'

-- Så mange notifikationer kan stå på skærmen på én gang. Kommer der flere, forsvinder den ældste.
Config.MaxVisible = 5

-- Hvor længe en notifikation står, når kaldet ikke angiver en varighed (millisekunder).
Config.DefaultDuration = 4000

-- Grænser for varigheden, så ingen kan sende en notifikation, der aldrig forsvinder (millisekunder).
Config.MinDuration = 1000
Config.MaxDuration = 30000

-- Overskrifterne, når kaldet ikke angiver en titel. Ret teksten her, hvis du vil have et andet sprog.
Config.Titles = {
	info = 'Info',
	success = 'Succes',
	error = 'Fejl',
}
