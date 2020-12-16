
local mortarPartitionGuid = Guid('7C592ADA-6915-4969-BFF2-A875027A9962')
local customBlueprintGuid = Guid('D407033B-49AE-DF14-FE19-FC786AE04EEE')
NetEvents:Subscribe('vu-ks-smokescreen:Launch', function(player, position)

	position.y = position.y + 200

	local launchTransform = LinearTransform(
		Vec3(0,  0, -1),
		Vec3(1,  0,  0),
		Vec3(0, -1,  0),
		position
	)

	local params = EntityCreationParams()
	params.transform = launchTransform
	params.networked = true

	local projectileBlueprint = ResourceManager:FindInstanceByGuid(mortarPartitionGuid, customBlueprintGuid)

	local projectileEntityBus = EntityManager:CreateEntitiesFromBlueprint(projectileBlueprint, params)

	for _,entity in pairs(projectileEntityBus.entities) do

		entity:Init(Realm.Realm_ClientAndServer, true)
	end
end)