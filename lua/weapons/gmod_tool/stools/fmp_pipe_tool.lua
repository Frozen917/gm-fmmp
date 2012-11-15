TOOL.Mode       = "fmp_pipe_tool"
TOOL.Category   = "Building Tools"
TOOL.Name       = "Pipe Tool"
TOOL.Tab        = "FMP"

PipeTool = {}
PipeTool.pipes = {}    -- shared, has to be synchronized manually

PipeTool.integerBitCount = 32
PipeTool.pipeIndex = 1
PipeTool.pipeMaxLength = 512

-- CLIENT
if CLIENT then
    language.Add("Tool.fmp_pipe_tool.name", "Pipe Tool" )
    language.Add("Tool.fmp_pipe_tool.desc", "Create a pipe !" )
    language.Add("Tool.fmp_pipe_tool.0", "Left click an entity to create a pipe")
    language.Add("Tool.fmp_pipe_tool.1", "Left click an entity to finish the pipe")

    function PipeTool.DrawPipes()
        for k,v in pairs(PipeTool.pipes) do
            v:Draw()
        end
    end
    hook.Add("RenderScreenspaceEffects", "PipeToolDrawPipes", PipeTool.DrawPipes)

    function PipeTool.UpdatePipes()
        PipeTool.pipes = {}
        while net.ReadBit() == 1 do
            local id = net.ReadInt(PipeTool.integerBitCount)
            PipeTool.pipes[id] = Pipe.New(id, net.ReadEntity():GetPlugByID(net.ReadDouble()), net.ReadEntity():GetPlugByID(net.ReadDouble()))
        end
    end
    net.Receive("PipeToolUpdatePipes", PipeTool.UpdatePipes)

    function PipeTool.AddPipe()
        if LocalPlayer().readyToPlay then
            local id = net.ReadInt(PipeTool.integerBitCount)
            PipeTool.pipes[id] = Pipe.New(id, net.ReadEntity():GetPlugByID(net.ReadDouble()), net.ReadEntity():GetPlugByID(net.ReadDouble()))
        end
    end
    net.Receive("PipeToolAddPipe", PipeTool.AddPipe)

    function PipeTool.RemovePipe()
        if LocalPlayer().readyToPlay then
            local id = net.ReadInt(PipeTool.integerBitCount)
            local pipe = PipeTool.pipes[id]
            pipe:Delete()
            PipeTool.pipes[id] = nil
        end
    end
    net.Receive("PipeToolRemovePipe", PipeTool.RemovePipe)
end

-- SERVER
if SERVER then
    util.AddNetworkString("PipeToolUpdatePipes")
    util.AddNetworkString("PipeToolAddPipe")
    util.AddNetworkString("PipeToolRemovePipe")

    function PipeTool.BroadcastPipes()
        net.Start("PipeToolUpdatePipes")
        for k,v in pairs(PipeTool.pipes) do
            net.WriteBit(true)
            net.WriteInt(k, PipeTool.integerBitCount)
            net.WriteEntity(v:GetEntryPlug():GetEntity())
            net.WriteDouble(v:GetEntryPlug():GetID())
            net.WriteEntity(v:GetExitPlug():GetEntity())
            net.WriteDouble(v:GetExitPlug():GetID())
        end
        net.WriteBit(false)
        net.Broadcast()
    end
    hook.Add("PlayerReadyToPlay", "PipeToolBroadcastPipes", PipeTool.BroadcastPipes)

    function PipeTool.AddPipe(nID, pEntry, pExit)
        PipeTool.pipes[nID] = Pipe.New(nID, pEntry, pExit)
        net.Start("PipeToolAddPipe")
            net.WriteInt(nID, PipeTool.integerBitCount)
            net.WriteEntity(pEntry:GetEntity())
            net.WriteDouble(pEntry:GetID())
            net.WriteEntity(pExit:GetEntity())
            net.WriteDouble(pExit:GetID())
        net.Broadcast()
    end

    function PipeTool.RemovePipe(index)
        if PipeTool.pipes[index] == nil then return end
        PipeTool.pipes[index]:Delete()
        PipeTool.pipes[index] = nil
        net.Start("PipeToolRemovePipe")
            net.WriteInt(index, PipeTool.integerBitCount)
        net.Broadcast()
    end

    function PipeTool.UnlinkRemovedEntity(entity)
        if entity.plugs != nil then
            for i,v in ipairs(entity:GetPlugs()) do
                local pipe = v:GetPipe()
                if pipe != nil then
                    PipeTool.RemovePipe(pipe:GetID())
                end
            end
        end
    end
    hook.Add("EntityRemoved", "PipeToolRemoveBrokenPipes", PipeTool.UnlinkRemovedEntity)

    function PipeTool.CheckPipesLength()
        for k,v in pairs(PipeTool.pipes) do
            if v:GetLength() > PipeTool.pipeMaxLength then
                PipeTool.RemovePipe(v:GetID())
            end
        end
    end
    timer.Create("PipeToolCheckPipesLength", 1, 0, PipeTool.CheckPipesLength)
end

-- SHARED
function TOOL:LeftClick(trace)
    local entity = trace.Entity
    if self:GetStage() == 0 then
        if entity:IsValid() and entity.GetFreePlug != nil then
            local entryPlug = entity:GetFreePlug(entity:WorldToLocal(trace.HitPos))
            if entryPlug != nil then
                self:GetOwner().PipeEntryPlug = entryPlug
                self:SetStage(1)
                return true
            end
        end
    elseif self:GetStage() == 1 then
        local entryPlug = self:GetOwner().PipeEntryPlug
        if entity:IsValid() and entity.GetFreePlug != nil and entryPlug:GetEntity() != nil and entryPlug:GetEntity():IsValid() and entryPlug:GetEntity() != entity then
            local exitPlug = entity:GetFreePlug(entity:WorldToLocal(trace.HitPos))
            if exitPlug != nil then
                if SERVER then
                    PipeTool.pipeIndex = PipeTool.pipeIndex + 1
                    local pipeid = PipeTool.pipeIndex
                    undo.Create("Pipe " .. pipeid)
                        undo.AddFunction(function()
                            PipeTool.RemovePipe(pipeid)
                            end)
                        undo.SetPlayer(self:GetOwner())
                    undo.Finish()
                    PipeTool.AddPipe(pipeid, entryPlug, exitPlug)
                end
                self:SetStage(0)
                return true
            end
        end
    end
end

function TOOL:Holster()
    self:SetStage(0)
end

function TOOL:Reload(trace)
    if SERVER then
        PipeTool.UnlinkRemovedEntity(trace.Entity)
    end
end
