-- Peds
local fish_selling = {
    id = "fish_selling",
    model =  "a_m_y_beachvesp_02",
    pedType = 3,
    distance = 25,
    components = {
        {type = "component", component = 0, drawable = 4, texture = 1, palette = 2},
        {type = "component", component = 2, drawable = -1, texture = 0, palette = 2},
        {type = "component", component = 3, drawable = 0, texture = 1, palette = 3},
        {type = "component", component = 4, drawable = 0, texture = 0, palette = 2},
        {type = "prop", component = 0, drawable = 3, texture = 0},
    },
    position = {
        coords = vector3(-1096.102, -324.94, 36.824), heading = 349.967,
    },
    options = {freeze = true, ignore = true, invincible = true}
}
RegisterPed(fish_selling)

local shark_selling = {
    id = "shark_selling",
    model =  "s_m_y_chef_01",
    pedType = 3,
    distance = 45,
    components = { 
        {type = "component", component = 3, drawable = 0, texture = 2, palette = 0}, 
        {type = "component", component = 8, drawable = 1, texture = 0, palette = 2}
    },
    position = {coords = vector3(-1845.079, -1195.621, 18.18), heading = 149.8927 },
    options = {freeze = true, ignore = true, invincible = true}
}
RegisterPed(shark_selling)

local boat_rental = {
    id = "boat_rental",
    model =  "a_m_y_jetski_01",
    pedType = 3,
    distance = 25,
    components = {
        {type = "component", component = 0, drawable = 1, texture = 0, palette = 2},
        {type = "component", component = 1, drawable = 0, texture = 0, palette = 0},
        {type = "component", component = 2, drawable = 1, texture = 0, palette = 2},
        {type = "component", component = 3, drawable = 0, texture = 1, palette = 2},
        {type = "component", component = 4, drawable = 0, texture = 4, palette = 2},
        {type = "component", component = 8, drawable = -1, texture = 0, palette = 2},
        {type = "component", component = 9, drawable = 1, texture = 3, palette = 2}
    },
    position = {coords = vector3(3859.743, 4459.096, 0.835), heading = 92.512},
    options = {freeze = true, ignore = true, invincible = true}
}
RegisterPed(boat_rental)

local boat_rental2 = {
    id = "boat_rental2",
    model =  "a_m_y_jetski_01",
    pedType = 3,
    distance = 25,
    components = {
        {type = "component", component = 0, drawable = 1, texture = 0, palette = 2}, 
        {type = "component", component = 1, drawable = 0, texture = 0, palette = 0}, 
        {type = "component", component = 2, drawable = 1, texture = 0, palette = 2}, 
        {type = "component", component = 3, drawable = 0, texture = 1, palette = 2}, 
        {type = "component", component = 4, drawable = 0, texture = 4, palette = 2}, 
        {type = "component", component = 8, drawable = -1, texture = 0, palette = 2}, 
        {type = "component", component = 9, drawable = 1, texture = 3, palette = 2}
    },
    position = {coords = vector3(-1608.173,5264.51,2.974), heading = 205.772},
    options = {freeze = true, ignore = true, invincible = true}
}
RegisterPed(boat_rental2)