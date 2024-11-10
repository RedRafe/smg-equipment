local sounds = require '__base__.prototypes.entity.sounds'
local item_sounds = require '__base__.prototypes.item_sounds'

data:extend({
  -- Item
  {
    type = 'item',
    name = 'personal-smg-equipment',
    icon = '__smg-equipment__/graphics/icons/personal-smg-equipment.png',
    place_as_equipment_result = 'personal-smg-equipment',
    subgroup = 'military-equipment',
    order = 'b[active-defense]-a[personal-smg-equipment]',
    inventory_move_sound = item_sounds.turret_inventory_move,
    pick_sound = item_sounds.turret_inventory_pickup,
    drop_sound = item_sounds.turret_inventory_move,
    stack_size = 20,
    weight = 200 * kg,
  },
  -- Recipe
  {
    type = 'recipe',
    name = 'personal-smg-equipment',
    enabled = false,
    energy_required = 10,
    ingredients = {
      { type = 'item', name = 'processing-unit', amount = 20 },
      { type = 'item', name = 'low-density-structure', amount = 5 },
      { type = 'item', name = 'gun-turret', amount = 5 },
    },
    results = { { type = 'item', name = 'personal-smg-equipment', amount = 1 } },
  },
  -- Equipment
  {
    type = 'active-defense-equipment',
    name = 'personal-smg-equipment',
    sprite = {
      filename = '__smg-equipment__/graphics/equipment/personal-smg-equipment.png',
      width = 128,
      height = 128,
      priority = 'medium',
      scale = 0.5,
    },
    shape = { width = 2, height = 2, type = 'full' },
    energy_source = { type = 'electric', usage_priority = 'secondary-input', buffer_capacity = '150kJ' },
    attack_parameters = {
      type = 'projectile',
      ammo_category = 'bullet',
      ammo_type = {
        energy_consumption = "30kJ",
        action = {
          type = 'direct',
          action_delivery = {
            type = 'instant',
            source_effects = { type = 'create-explosion', entity_name = 'explosion-gunshot' },
            target_effects = {
              {
                type = 'create-entity',
                entity_name = 'explosion-hit',
                offsets = { { 0, 1 } },
                offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
              },
              { type = 'damage', damage = { amount = 20, type = 'physical' } },
              { type = 'activate-impact', deliver_category = 'bullet' },
            },
          },
        },
      },
      damage_modifier = 1.6,
      health_penalty = 1,
      cooldown = 6,
      projectile_creation_distance = 1.39375,
      projectile_center = { 0, -0.0875 }, -- same as gun_turret_attack shift
      shell_particle = {
        name = 'shell-particle',
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = { -0.0625, 0 },
        creation_distance = -1.925,
        starting_frame_speed = 0.2,
        starting_frame_speed_deviation = 0.1,
      },
      range = 18,
      sound = sounds.gun_turret_gunshot,
    },
    automatic = true,
    categories = { 'armor' },
  },
  -- Technology
  {
    type = 'technology',
    name = 'personal-smg-equipment',
    icons = util.technology_icon_constant_equipment('__smg-equipment__/graphics/technology/personal-smg-equipment.png'),
    prerequisites = { 'gun-turret', 'military-3', 'low-density-structure', 'power-armor' },
    effects = { { type = 'unlock-recipe', recipe = 'personal-smg-equipment' } },
    unit = {
      count = 100,
      ingredients = {
        { 'automation-science-pack', 1 },
        { 'logistic-science-pack', 1 },
        { 'chemical-science-pack', 1 },
        { 'military-science-pack', 1 },
      },
      time = 30,
    },
  },
})
