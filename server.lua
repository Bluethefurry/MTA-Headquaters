function repair_func(thePlayer)
local vehicle = getPedOccupiedVehicle(thePlayer)
if vehicle then
fixVehicle(vehicle)
end
end
addEvent("repair_func", true)
addEventHandler("repair_func", root, repair_func)
addCommandHandler("repair", repair_func,false,false)

function setdim_func(theElement, theDim)
setElementDimension(theElement, theDim)

end
addEvent("setdim_func", true)
addEventHandler("setdim_func", root, setdim_func)


function flip_func(thePlayer)
	local vehicle = getPedOccupiedVehicle(thePlayer)
	if vehicle then
		local rX, rY, rZ = getElementRotation(vehicle)
		setElementRotation(vehicle, 0, 0, (rX > 90 and rX < 270) and (rZ + 180) or rZ)
	end
end
addCommandHandler("flip", flip_func,false,false)





function setdim_func(theElement, theDim)
setElementDimension(theElement, theDim)

end
addEvent("setdim_func", true)
addEventHandler("setdim_func", root, setdim_func)

function setInt_func(theElement, theDim)
setElementInterior(theElement, theDim)

end
addEvent("setint_func", true)
addEventHandler("setint_func", root, setInt_func)


function setVehCol(veh, r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4, hr, hg, hb)
setVehicleColor(veh, r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4)
setVehicleHeadLightColor(veh, hr, hg, hb)

end
addEvent("setVehCol", true)
addEventHandler("setVehCol", root, setVehCol)

function addVehUpg(veh,upgradeID)
addVehicleUpgrade(veh, upgradeID)

end
addEvent("addVehUpg", true)
addEventHandler("addVehUpg", root, addVehUpg)


function setVehPlateText(veh,plateText)
setVehiclePlateText(veh, plateText)

end
addEvent("setVehPlateText", true)
addEventHandler("setVehPlateText", root, setVehPlateText)

function delVehUpg(veh,upgradeID)
removeVehicleUpgrade(veh, upgradeID)

end
addEvent("delVehUpg", true)
addEventHandler("delVehUpg", root, delVehUpg)