--[[
License: MIT

Copyright 2020 Pithlit

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--]]


fluidInserterLib = {}
--[[
@brief A library to create inserters that take fluid energy sources (eg. steam or petroleum)
@usage: create and entity and an item using 'fluidInserterLib.createFluidInserterEntity' and 'fluidInserterLib.createFluidInserterItem'.
@example: 
local name = "pneumatic-inserter"
local entity = fluidInserterLib.createFluidInserterEntity(name, "inserter", "pipe", "steam", 165)
local item = fluidInserterLib.createFluidInserterItem(name, "inserter", "pipe", "steam")
--]]


--[[
@brief custom icons placed here are prefered over generated icons.
@example fluidInserterLib.icons_predefined["pneumatic-inserter"] = "__pneumatic-inserter__/graphics/icons/pneumatic-inserter.png"
--]]
fluidInserterLib.icons_predefined = {}


--[[
@brief takes a pipe and updates it with the stats of an inserter
@param inserter_src_name: the name of the inserter entity you wish to use
@param pipe_name: the name of the pipe entity you wish to use
--]]
fluidInserterLib.combineInserterAndPipe = function (inserter_src_name, pipe_name)
	local pipe = data.raw.pipe[pipe_name]
	local inserter = data.raw.inserter[inserter_src_name]
	local entity = util.merge({pipe, inserter})	-- util.merge is defined in factorio lualib
	local from_pipe = {"resistances", "collision_box", "selection_box", "next_upgrade"}
	local from_inserter = {"working_sound"}
	for _,key in ipairs(from_pipe) do
		value = pipe[key]
		if type(value) == table then
			value = table.deepcopy(value)
		end
		entity[key] = value
	end
	for _,key in ipairs(from_inserter) do
		entity[key] = inserter[key]
	end
	return entity
end


--[[
@brief sets the name of the entity where needed
@param target_name: the name of the entity you wish to create
--]]
fluidInserterLib.adjustNames = function (entity, target_name)
	custom = {
		name = target_name,
		minable = {result = target_name},
	}
	return util.merge({entity, custom})
end


--[[
@brief creates icons. manually drawn still looks better.
@param inserter_name: determines the icon of the inserter used.
@param pipe_name: determines the icon of the pipe to use. In vanilla only "pipe" is possible
@param fluid_name: determines the icon of the fluid used
--]]
fluidInserterLib.createIcons = function (inserter_name, pipe_name, fluid_name)
	local inserter = data.raw.item[inserter_name]
	local pipe = data.raw.item[pipe_name]
	local fluid = data.raw.fluid[fluid_name]
	local icons = {
		{
			icon = inserter.icon,
			icon_size = inserter.icon_size,
			icon_mipmaps = inserter.icon_mipmaps,
			shift = {2, -4}
		},
		{
			icon = pipe.icon,
			icon_size = pipe.icon_size,
			icon_mipmaps = pipe.icon_mipmaps,
			scale = 0.35,
			shift = {8, 8}
		},
		--[[{
			icon = fluid.icon,
			icon_size = fluid.icon_size,
			icon_mipmaps = fluid.icon_mipmaps,
			scale = 0.3,
			shift = {-8, 8}
		}--]]
	}
	return icons
end


--[[
@brief returns an entityies energy_source
@param fluid_name: only allow this fluid. If nil, allow all fluids
@param temperature: the temperature needed. If nil, the fluids is burned instead of consuming temperature
--]]
fluidInserterLib.createFluidEnergySource = function (fluid_name, optimal_temperature)
	local images = data.raw["mining-drill"]["electric-mining-drill"].input_fluid_box
	if optimal_temperature then 
		local burns = false
	else
		local burns = true
	end
	return {
		type = 'fluid',
		maximum_temperature = optimal_temperature,
		burns_fluid = burns,
		scale_fluid_usage = true,
		fluid_box = {
			production_type = "input-output",
			filter = fluid_name,
			base_area = 1,
			height = 2,
			base_level = -1,
			pipe_connections = {
				{ position = {1, 0} },
				{ position = {-1, 0} }
			},
			pipe_picture = images.pipe_picture,
			pipe_covers = images.pipe_covers,
		}
	}
end


--[[
@brief returns an entity prototype.
@param target_name: the name of the entity you wish to create
@param inserter_src_name: the inserter your entity is based on (gets most of the stats)
@param pipe_name: the pipe prototype to use. In vanilla only "pipe" is possible
@param fluid_name: only allow this fluid. If nil, allow all fluids
@param temperature: the temperature needed. If nil, the fluids is burned instead of consuming temperature
--]]
fluidInserterLib.createFluidInserterEntity = function (target_name, inserter_src_name, pipe_name, fluid_name, temperature)
	local entity = fluidInserterLib.combineInserterAndPipe(inserter_src_name, pipe_name)
	entity = fluidInserterLib.adjustNames(entity, target_name)
	entity.icon = fluidInserterLib.icons_predefined[target_name]
	entity.icon_size = 64
	entity.icon_mipmaps = 4
	if not entity.icon then
		entity.icons = fluidInserterLib.createIcons(inserter_src_name, pipe_name, fluid_name)
	end
	entity.energy_source = fluidInserterLib.createFluidEnergySource(fluid_name, temperature)
	
	custom = {
		fast_replaceable_group = "pipe",
		-- replace the entities platform graphics with the pipe entities graphics
		platform_picture = {
			north=entity.pictures.straight_horizontal,
			east=entity.pictures.straight_vertical,
			south=entity.pictures.straight_horizontal,
			west=entity.pictures.straight_vertical},
		
	}

	entity = util.merge({entity, custom})
	entity.fluid_box = nil
	entity.pictures = nil
	return entity
end

--[[
@brief returns an item prototype.
@param target_name: the name of the item you wish to create
@param inserter_src_name: the inserter your item is based on (gets most of the stats)
@param pipe_name: the pipe item prototype to use. In vanilla only "pipe" is possible
@param fluid_name: use this fluid when creating the icon. Currently not used.
--]]
fluidInserterLib.createFluidInserterItem = function (target_name, inserter_src_name, pipe_name, fluid_name)
	if fluidInserterLib.order_counter == nil then
		fluidInserterLib.order_counter = 0
	end
	fluidInserterLib.order_counter = fluidInserterLib.order_counter + 1
	local item = {
		type = "item",
		name = target_name,
		subgroup = "inserter",
		order = "ac-"..tostring(fluidInserterLib.order_counter).."-["..target_name.."]",
		place_result = target_name,
		stack_size = 50,
		icon_size = 64, icon_mipmaps = 4
	}
	item.icon = fluidInserterLib.icons_predefined[target_name]
	if not item.icon then
		item.icons = fluidInserterLib.createIcons(inserter_src_name, pipe_name, fluid_name)
	end
	return item
end

return fluidInserterLib