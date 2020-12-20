
local mortarPartitionGuid = Guid('7C592ADA-6915-4969-BFF2-A875027A9962')

local customBlueprintGuid = Guid('D407033B-49AE-DF14-FE19-FC786AE04EEE')
local customProjectileDataGuid = Guid('81E0126A-8452-AEC6-5E4E-94A72DBBB96E')
local customExplosionDataGuid = Guid('6B1E1B5F-2487-2511-A0D4-39262CFC74BE')
Events:Subscribe('Partition:Loaded', function(partition)

    if partition.guid ~= mortarPartitionGuid then
        return
    end

    local mortarBlueprint = partition.primaryInstance

    local artyProjectileBlueprint = ProjectileBlueprint(mortarBlueprint:Clone(customBlueprintGuid))
    local artyProjectileData = MissileEntityData(artyProjectileBlueprint.object:Clone(customProjectileDataGuid))
    local artyExplosionData = ExplosionEntityData(artyProjectileData.explosion:Clone(customExplosionDataGuid))
    artyProjectileBlueprint.object = artyProjectileData
    artyProjectileData.explosion = artyExplosionData
    --print(tostring(artyProjectileData.explosion.blastRadius).." | "..tostring(artyProjectileData.explosion.innerBlastRadius).." | "..tostring(artyProjectileData.explosion.blastDamage).." | "..tostring(artyProjectileData.explosion.shockwaveImpulse).." | "..tostring(artyProjectileData.explosion.shockwaveRadius).." | "..tostring(artyProjectileData.explosion.shockwaveTime).." | "
    --..tostring(artyProjectileData.explosion.hasStunEffect).." | "..tostring(artyProjectileData.explosion.cameraShockwaveRadius).." | ")
    -- Make changes...
    artyProjectileData.explosion.blastDamage = 0
    artyProjectileData.explosion.blastImpulse = 0
    artyProjectileData.explosion.empTime = 0
    artyProjectileData.explosion.blastRadius = 0
    artyProjectileData.explosion.innerBlastRadius = 0
    artyProjectileData.explosion.shockwaveRadius = 0
    artyProjectileData.explosion.shockwaveImpulse = 0
    artyProjectileData.explosion.shockwaveTime = 0
    artyProjectileData.explosion.hasStunEffect = false
    artyProjectileData.explosion.shockwaveDamage = 0

    --print(tostring(artyProjectileData.explosion.blastRadius).." | "..tostring(artyProjectileData.explosion.innerBlastRadius).." | "..tostring(artyProjectileData.explosion.blastDamage).." | "..tostring(artyProjectileData.explosion.shockwaveImpulse).." | "..tostring(artyProjectileData.explosion.shockwaveRadius).." | "..tostring(artyProjectileData.explosion.shockwaveTime).." | "
    --..tostring(artyProjectileData.explosion.hasStunEffect).." | "..tostring(artyProjectileData.explosion.cameraShockwaveRadius).." | ")
    partition:AddInstance(artyProjectileBlueprint)
    partition:AddInstance(artyProjectileData)
    partition:AddInstance(artyExplosionData)
    print("instances cloned")
end)

Events:Subscribe('Level:RegisterEntityResources', function(levelData)
 
    local partition = ResourceManager:FindDatabasePartition(mortarPartitionGuid)

    local artyProjectileBlueprint = ProjectileBlueprint(partition:FindInstance(customBlueprintGuid))
    local artyProjectileData = ProjectileEntityData(partition:FindInstance(customProjectileDataGuid))
    local artyExplosionData = ExplosionEntityData(partition:FindInstance(customExplosionDataGuid))

    local registry = RegistryContainer()
    registry.blueprintRegistry:add(artyProjectileBlueprint)
    registry.entityRegistry:add(artyProjectileData)
    registry.entityRegistry:add(artyExplosionData)

    ResourceManager:AddRegistry(registry, ResourceCompartment.ResourceCompartment_Game)

    print("registry added")
end)