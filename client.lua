local usingBinoculars = false
local visionMode = 0
local fov = 45.0
local minFov = 5.0
local maxFov = 70.0
local zoomSpeed = 1.0
local binocularCam = nil
local heading, pitch = 0.0, 0.0
local rotationSpeed = 0.1

RegisterNetEvent('binoculars:use', function()
    if usingBinoculars then
        exitBinoculars()
        return
    end

    local ped = PlayerPedId()
    usingBinoculars = true
    visionMode = 0
    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_BINOCULARS', 0, true)

    Wait(1500)
    SetFollowPedCamViewMode(4)
    fov = 45.0
    heading = GetEntityHeading(ped)
    pitch = 0.0

    SendNUIMessage({ action = 'show' })

    binocularCam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
    AttachCamToEntity(binocularCam, ped, 0.0, 0.0, 1.0, true)
    SetCamRot(binocularCam, pitch, 0.0, heading, 2)
    SetCamFov(binocularCam, fov)
    RenderScriptCams(true, true, 500, true, true)

    CreateThread(function()
        while usingBinoculars do
            DisableAllControlActions(0)

            -- Zoom scroll
            if IsDisabledControlJustPressed(0, 241) then
                fov = math.max(fov - zoomSpeed, minFov)
                SetCamFov(binocularCam, fov)
            elseif IsDisabledControlJustPressed(0, 242) then
                fov = math.min(fov + zoomSpeed, maxFov)
                SetCamFov(binocularCam, fov)
            end

            -- Mouse movement
            local rightX = GetDisabledControlNormal(0, 1)
            local rightY = GetDisabledControlNormal(0, 2)
            heading = heading + rightX * rotationSpeed * -10.0
            pitch = pitch + rightY * rotationSpeed * -10.0
            pitch = math.clamp(pitch, -89.0, 89.0)
            SetCamRot(binocularCam, pitch, 0.0, heading, 2)

            -- Switch view mode
            if IsDisabledControlJustPressed(0, 38) then
                visionMode = (visionMode + 1) % 3
                updateVisionMode(visionMode)
            elseif IsDisabledControlJustPressed(0, 202) then
                exitBinoculars()
            end

            Wait(0)
        end
    end)
end)

function updateVisionMode(mode)
    SetNightvision(mode == 1)
    SetSeethrough(mode == 2)
end

function exitBinoculars()
    local ped = PlayerPedId()
    ClearPedTasks(ped)
    SetNightvision(false)
    SetSeethrough(false)
    RenderScriptCams(false, true, 500, true, true)
    DestroyCam(binocularCam, false)
    SetFollowPedCamViewMode(1)
    binocularCam = nil
    usingBinoculars = false
    visionMode = 0
    SendNUIMessage({ action = 'hide' })
end

function math.clamp(val, min, max)
    return math.max(min, math.min(max, val))
end
