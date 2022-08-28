nadrp.Admin:AddRank("owner", {
    inherits = "dev",
    issuperadmin = true,
    allowafk = true,
    grant = 101
})

nadrp.Admin:AddRank("dev", {
    inherits = "superadmin",
    issuperadmin = true,
    allowafk = true,
    grant = 101
})

nadrp.Admin:AddRank("superadmin", {
    inherits = "admin",
    issuperadmin = true,
    allowafk = true,
    grant = 101
})

nadrp.Admin:AddRank("admin", {
    inherits = "mod",
    allowafk = true,
    isadmin = true,
    grant = 98
})

nadrp.Admin:AddRank("mod", {
    inherits = "trusted",
    isadmin = true,
    grant = 97
})

nadrp.Admin:AddRank("trusted", {
    inherits = "user",
    isadmin = true,
    grant = 96
})

nadrp.Admin:AddRank("user", {
    inherits = "",
    grant = 1
})