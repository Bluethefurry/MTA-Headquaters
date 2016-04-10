local vehPosx, vehPosy, vehPosz = 614.64966, -1.61339, 1000.5888
local vehInt = 1
local camera1x, camera1y, camera1z, camera2x, camera2y, camera2z = 609.35895, 0.04021, 1000.92438, 614.77997, -1.65957, 1000.92188

local screenW, screenH = guiGetScreenSize()
localPlayer = getLocalPlayer()
g_Me = localPlayer




function toggleHud(on)
if on then 
setPlayerHudComponentVisible("all", on)
else
setPlayerHudComponentVisible("all", on)
end
end



function guiInit()
        repairbtn = guiCreateButton(0.01, 0.88, 0.14, 0.06, "Repair", true)
        guiSetFont(repairbtn, "default-bold-small")
        guiSetProperty(repairbtn, "NormalTextColour", "FFAAAAAA")
		addEventHandler("onClientGUIClick", repairbtn, repair_func_c)
		guiSetVisible(repairbtn,false)
		
		
		
        setColour_btn = guiCreateButton(0.18, 0.88, 0.14, 0.06, "Set Colour", true)
        guiSetFont(setColour_btn, "default-bold-small")
        guiSetProperty(setColour_btn, "NormalTextColour", "FFAAAAAA")
		addEventHandler("onClientGUIClick", setColour_btn, setColour_func)
		guiSetVisible(setColour_btn,false)	
			
			
        tuneVeh_btn = guiCreateButton(0.36, 0.88, 0.14, 0.06, "Modify Vehicle", true)
        guiSetFont(tuneVeh_btn, "default-bold-small")
        guiSetProperty(tuneVeh_btn, "NormalTextColour", "FFAAAAAA")
		addEventHandler("onClientGUIClick", tuneVeh_btn, tuneVeh_func)
guiSetVisible(tuneVeh_btn,false)	
		
		
--        tuneveh_btn = guiCreateButton(0.53, 0.88, 0.14, 0.06, "Tune Vehicle", true)
--        guiSetFont(tuneveh_btn, "default-bold-small")
--        guiSetProperty(tuneveh_btn, "NormalTextColour", "FFAAAAAA")
--		addEventHandler("onClientGUIClick", tuneveh_btn, tuneveh_func)
--  	guiSetVisible(tuneveh_btn,false)	
		
		
        exitHQ = guiCreateButton(0.71, 0.88, 0.14, 0.06, "Exit HQ", true)
        guiSetFont(exitHQ, "default-bold-small")
        guiSetProperty(exitHQ, "NormalTextColour", "FFAAAAAA") 
		addEventHandler("onClientGUIClick", exitHQ, enterHQ)
		guiSetVisible(exitHQ,false)
end
addEventHandler("onClientResourceStart", resourceRoot, guiInit)


function guiDXInit()
        dxDrawRectangle(screenW * 0.0015, screenH * 0.8594, screenW * 0.9956, screenH * 0.1055, tocolor(81, 81, 81, 135), false)
end


hq = 0



function enterHQ()
hisVeh = getPedOccupiedVehicle(localPlayer)
if hisVeh then

if hq == 0 then
oldPosx, oldPosy, oldPosz = getElementPosition(hisVeh)
oldRotx, oldRoty, oldRotz = getElementRotation(hisVeh)
oldDim = getElementDimension(hisVeh)
oldInt = getElementInterior(hisVeh)
dim = math.random(0,60000)


triggerServerEvent("setdim_func", resourceRoot, localPlayer, dim)
triggerServerEvent("setdim_func", resourceRoot, hisVeh, dim)
triggerServerEvent("setint_func", resourceRoot, localPlayer, vehInt)
triggerServerEvent("setint_func", resourceRoot, hisVeh, vehInt)
setCameraMatrix(camera1x, camera1y, camera1z, camera2x, camera2y, camera2z)
setElementPosition(hisVeh, vehPosx, vehPosy, vehPosz)
setElementRotation(hisVeh, 0, 0, 30)
setElementFrozen(hisVeh, true)
setElementFrozen(hisVeh, false)
addEventHandler("onClientRender", root, guiDXInit)
setElementAlpha(localPlayer, 255)



guiSetVisible(repairbtn,true)
guiSetVisible(setColour_btn,true)
guiSetVisible(tuneVeh_btn,true)
guiSetVisible(exitHQ,true)
showCursor(true)
outputChatBox("Welcome to HQ!")
toggleHud(false)
hq = 1

else
setElementInterior(localPlayer, 0)
setCameraInterior(0)
setElementFrozen(hisVeh, true)
setElementFrozen(hisVeh, false)
removeEventHandler("onClientRender", root, guiDXInit)
guiSetVisible(repairbtn,false)
guiSetVisible(setColour_btn,false)
guiSetVisible(tuneVeh_btn,false)
guiSetVisible(exitHQ,false)
triggerServerEvent("setdim_func", resourceRoot, localPlayer, oldDim)
triggerServerEvent("setdim_func", resourceRoot, hisVeh, oldDim)
triggerServerEvent("setint_func", resourceRoot, localPlayer, oldInt)
triggerServerEvent("setint_func", resourceRoot, hisVeh, oldInt)
setElementPosition(hisVeh, oldPosx, oldPosy, oldPosz)
setElementRotation(hisVeh, oldRotx, oldRoty, oldRotz)
showCursor(false)
setCameraTarget(localPlayer)

toggleHud(true)
hq = 0
end

end
end
addCommandHandler("hq", enterHQ,false,false)









function repair_func_c()
triggerServerEvent("repair_func", resourceRoot, localPlayer)


end

function openColorPicker()
	editingVehicle = getPedOccupiedVehicle(localPlayer)
	if (editingVehicle) then
		colorPicker.openSelect(colors)
	end
end

function closedColorPicker()
	local r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4 = getVehicleColor(editingVehicle, true)
	local hr, hg, hb = getVehicleHeadLightColor(editingVehicle)
	triggerServerEvent("setVehCol", resourceRoot, editingVehicle, r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4, hr, hg, hb)
	editingVehicle = nil
end


function updateColor()
	if (not colorPicker.isSelectOpen) then return end
	local r, g, b = colorPicker.updateTempColors()
	if (editingVehicle and isElement(editingVehicle)) then
		local r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4 = getVehicleColor(editingVehicle, true)
		if (guiCheckBoxGetSelected(checkColor1)) then
			r1, g1, b1 = r, g, b
		end
		if (guiCheckBoxGetSelected(checkColor2)) then
			r2, g2, b2 = r, g, b
		end
		if (guiCheckBoxGetSelected(checkColor3)) then
			r3, g3, b3 = r, g, b
		end
		if (guiCheckBoxGetSelected(checkColor4)) then
			r4, g4, b4 = r, g, b
		end
		if (guiCheckBoxGetSelected(checkColor5)) then
			setVehicleHeadLightColor(editingVehicle, r, g, b)
		end
		setVehicleColor(editingVehicle, r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4)
	end
end
addEventHandler("onClientRender", root, updateColor)


function setColour_func()
openColorPicker()
end

function tuneVeh_func()
upgradesInit()
end
