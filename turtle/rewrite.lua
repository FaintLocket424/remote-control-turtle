local json = require('json')

local ws, err = http.websocket('ws://localhost:8081')

while (true) do
    local incoming = ws.receive()
    local table = json.decode(incoming)

    if table.target == '2' then
        if table.instruction == 'exitTurtle' then
            ws.close()
            break;
        elseif table.instruction == 'left' then
            turtle.turnLeft()

        elseif table.instruction == 'right' then
            turtle.turnRight()

        elseif table.instruction == 'forward' then
            turtle.forward()

        elseif table.instruction == 'back' then
            turtle.back()

        elseif table.instruction == 'up' then
            turtle.up()

        elseif table.instruction == 'down' then
            turtle.down()

        elseif table.instruction == 'refuel' then
            turtle.refuel()

        elseif table.instruction == 'dig' then
            turtle.dig()

        elseif table.instruction == 'digUp' then
            turtle.digUp()
            
        elseif table.instruction == 'digDown' then
            turtle.digDown()

        elseif table.instruction == 'place' then
            turtle.place()

        elseif table.instruction == 'placeUp' then
            turtle.placeUp()

        elseif table.instruction == 'placeDown' then
            turtle.placeDown()

        elseif table.instruction == 'equipLeft' then
            turtle.equipLeft()

        elseif table.instruction == 'equipRight' then
            turtle.equipRight()

        elseif table.instruction == 'label' then
            if table.data ~= '' then
                shell.run('label set '..table.data)
            else
                shell.run('label clear')
            end

        elseif table.instruction == 'select' then
            if table.data ~= nil then
                local slot = tonumber(table.data)
                if type(slot) == 'number' then
                    turtle.select(slot)
                end
                
                local payload = {target = 1, instruction = 'receiveSelected', data = slot}
                local payloadJson = json.encode(payload)
                ws.send(payloadJson)
            end

        elseif table.instruction == 'getInv' then
            local payload = {target = 1, instruction = 'receiveInv', data = {}}
            for slot = 1, 16 do
                local slotInfo = turtle.getItemDetail(slot)
                if slotInfo == nil then
                    slotInfo = {}
                    slotInfo.name = 'Empty'
                    slotInfo.count = '0'
                end
                payload['data'][slot] = {name = slotInfo.name, count = slotInfo.count}
            end
            local payloadJson = json.encode(payload)
            ws.send(payloadJson)

        elseif table.instruction == 'inspectPerInv' then
            if table.data ~= nil then
                local chest = peripheral.wrap(table.data)
                if chest ~= nil then
                    local payload = {target = 1, instruction = 'receivePerInv', data = {size = chest.size()}}
                    for slot = 1, chest.size() do
                        local slotInfo = chest.getItemDetail(slot)
                        if slotInfo == nil then
                            slotInfo = {}
                            slotInfo.name = 'Empty'
                            slotInfo.count = '0'
                        end
                        payload['data'][tostring(slot)] = {name = slotInfo.name, count = slotInfo.count}
                    end
                    local payloadJson = json.encode(payload)
                    ws.send(payloadJson)
                end
            end

        elseif table.instruction == 'inspectBlocks' then
            local payload = {target = 1, instruction = 'receiveBlocks', data = {}}
            local i, infront = turtle.inspect()
            local a, above = turtle.inspectUp()
            local b, below = turtle.inspectDown()

            if i ~= false then
                payload['data']['infront'] = infront.name
            else
                payload['data']['infront'] = 'minecraft:air'
            end

            if a ~= false then
                payload['data']['above'] = above.name
            else
                payload['data']['above'] = 'minecraft:air'
            end

            if b ~= false then
                payload['data']['below'] = below.name
            else
                payload['data']['below'] = 'minecraft:air'
            end
            
            local payloadJson = json.encode(payload)
            ws.send(payloadJson)

        elseif table.instruction == 'locate' then
            local x, y, z = gps.locate()
            local payload = {target = 1, instruction = 'receiveLocate', data = {}}
            if x ~= nil then
                payload.data.x = x
                payload.data.y = y
                payload.data.z = z
            else
                payload.data.x = 'Unknown'
                payload.data.y = 'Unknown'
                payload.data.z = 'Unknown'
            end

            local payloadJson = json.encode(payload)
            ws.send(payloadJson)

        elseif table.instruction == 'updateSelected' then
            local slot = turtle.getSelectedSlot()
            local payload = {target = 1, instruction = 'receiveSelected', data = slot}
            local payloadJson = json.encode(payload)
            ws.send(payloadJson)
        end
    end
end
