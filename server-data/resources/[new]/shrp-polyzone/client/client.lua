local comboZone = nil
local insideZone = false
local createdZones = {}

local function addToComboZone(zone)
    if comboZone ~= nil then
        comboZone:AddZone(zone)
    else
        comboZone = ComboZone:Create({ zone }, { name = "shrp-polyzone" })
        comboZone:onPlayerInOutExhaustive(function(isPointInside, point, insideZones, enteredZones, leftZones)
            if leftZones ~= nil then
                for i = 1, #leftZones do
                    TriggerEvent("shrp-polyzone:exit", leftZones[i].name)
                end
            end
            if enteredZones ~= nil then
                for i = 1, #enteredZones do
                    TriggerEvent("shrp-polyzone:enter", enteredZones[i].name, enteredZones[i].data, enteredZones[i].center)
                end
            end
        end, 500)
    end
end

function AddBoxZone(name, vectors, length, width, options)
    if not options then options = {} end
    if options.data then
        zoneID = name .. "_" .. tostring(options.data.id)
        if createdZones[zoneID] then
            print('zone '..zoneID..' exists already')
            return
        end
    else
        if createdZones[name] then
            print('zone '..name..' exists already')
            return
        end
    end
    createdZones[name] = true
    options.name = name
    local boxCenter = type(vectors) ~= 'vector3' and vector3(vectors.x, vectors.y, vectors.z) or vectors
    local zone = BoxZone:Create(boxCenter, length, width, options)
    addToComboZone(zone)
end
exports("AddBoxZone", AddBoxZone)

function addCircleZone(name, center, radius, options)
    if not options then options = {} end
    if options.data then
        zoneID = name .. "_" .. tostring(options.data.id)
        if createdZones[zoneID] then
            print('zone '..zoneID..' exists already')
            return
        end
    else
        if createdZones[name] then
            print('zone '..name..' exists already') 
            return
        end
    end
    createdZones[name] = true
    options.name = name
    local circleCenter = type(center) ~= 'vector3' and vector3(center.x, center.y, center.z) or center
    local zone = CircleZone:Create(circleCenter, radius, options)
    addToComboZone(zone)
end
exports("AddCircleZone", addCircleZone)

function AddPolyZone(name, vectors, options)
    if not options then options = {} end
    if options.data then
        zoneID = name .. "_" .. tostring(options.data.id)
        if createdZones[zoneID] then
            print('zone '..zoneID..' exists already')
            return
        end
    else
        if createdZones[name] then
            print('zone '..name..' exists already')
            return
        end
    end
    createdZones[name] = true
    options.name = name
    local zone = PolyZone:Create(vectors, options)
    addToComboZone(zone)
end
exports("AddPolyZone", AddPolyZone)
