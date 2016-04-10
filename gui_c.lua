g_Me = localPlayer


function upgradesInit()
	local vehicle = getPedOccupiedVehicle(g_Me)
	if not vehicle then
		errMsg('Please enter a vehicle to change the upgrades of.')
		closeWindow(wndUpgrades)
		return
	end
	local installedUpgrades = getVehicleUpgrades(vehicle)
	local compatibleUpgrades = {}
	local slotName, group
	for i,upgrade in ipairs(getVehicleCompatibleUpgrades(vehicle)) do
		slotName = getVehicleUpgradeSlotName(upgrade)
		row = guiGridListAddRow(list)
		guiGridListSetItemText(list, row, upgradelist, tostring(upgrade), false,false)
	end
end

function selectUpgrade(leaf)
	setControlText(wndUpgrades, 'addremove', leaf.installed and 'remove' or 'add')
end

function addRemoveUpgrade(selUpgrade)
	-- Add or remove selected upgrade
	local vehicle = getPedOccupiedVehicle(g_Me)
	if not vehicle then
		return
	end
	
	if not selUpgrade then
		selUpgrade = getSelectedGridListLeaf(wndUpgrades, 'upgradelist')
		if not selUpgrade then
			return
		end
	end
	
	if selUpgrade.installed then
		-- remove upgrade
		selUpgrade.installed = false
		setControlText(wndUpgrades, 'addremove', 'add')
		triggerServerEvent("delVehUpg", resourceRoot, vehicle, selUpgrade.id)
	else
		-- add upgrade
		local prevUpgradeIndex = table.find(selUpgrade.siblings, 'installed', true)
		if prevUpgradeIndex then
			selUpgrade.siblings[prevUpgradeIndex].installed = false
		end
		selUpgrade.installed = true
		setControlText(wndUpgrades, 'addremove', 'remove')
		triggerServerEvent("addVehUpg", resourceRoot, vehicle, selUpgrade.id)
	end
end

        wndUpgrades = guiCreateWindow(0.13, 0.23, 0.21, 0.51, "", true)
        guiWindowSetSizable(wndUpgrades, false)

        list = guiCreateGridList(0.03, 0.08, 0.54, 0.90, true, wndUpgrades)
        upgradelist = guiGridListAddColumn(list, "Upgrade", 0.5)
        guiGridListAddColumn(list, "Installed", 0.5)
        addremove = guiCreateButton(0.62, 0.11, 0.33, 0.08, "Install Upgrade", true, wndUpgrades)
        ok = guiCreateButton(0.87, 0.93, 0.08, 0.04, "x", true, wndUpgrades)    
		guiSetVisible(wndUpgrades,false)