on('GetMainObject', (framework, event, resourceName, cb) => {
	let object = undefined

	if (framework && framework.toLowerCase().trim() === 'esx') {
		try {
			cb((object = exports[resourceName || 'es_extended']['getSharedObject']()))
		} catch {
			emit(event || 'esx:getSharedObject', (_object) => cb((object = _object)))

			setTimeout(() => {
				if (object === undefined) {
					console.log('^1================ WARNING ================^7')
					console.log('^7Failed to ^2load^7 shared object!^7')
					console.log('^1================ WARNING ================^7')

					cb(object)
				}
			}, 100)
		}
	} else if (framework && framework.toLowerCase().trim() === 'qbcore') {
		try {
			cb((object = exports[resourceName || 'qb-core']['GetCoreObject']()))
		} catch {
			try {
				cb((object = exports[resourceName || 'qb-core']['GetSharedObject']()))
			} catch {
				emit(event || 'QBCore:GetObject', (_object) => cb((object = _object)))

				setTimeout(() => {
					if (object === undefined) {
						console.log('^1================ WARNING ================^7')
						console.log('^7Failed to ^2load^7 shared object!^7')
						console.log('^1================ WARNING ================^7')

						cb(object)
					}
				}, 100)
			}
		}
	} else {
		console.log('^1================ WARNING ================^7')
		console.log('^7Choose your ^2framework^7 in the config!^7')
		console.log('^1================ WARNING ================^7')

		cb(object)
	}
})
