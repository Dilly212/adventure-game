
-- Adventure Game (Love2D)
-- Basic structure: Start menu, pause/exit, test arena with combat

function love.load()
    state = 'start' -- start, play, pause
    assets = {}
    assets.bg = love.graphics.newImage('assets/arena.png')
    assets.player = love.graphics.newImage('assets/character.png')
    assets.enemy = love.graphics.newImage('assets/enemy.png')
    player = {x=100, y=200, hp=100, mode='physical'}
    enemy = {x=400, y=200, hp=100}
    font = love.graphics.newFont(18)
    menu_selected = 1
    pause_selected = 1
end

function love.keypressed(key)
    if state == 'start' then
        if key == 'up' or key == 'w' then menu_selected = 1 end
        if key == 'down' or key == 's' then menu_selected = 2 end
        if key == 'return' or key == 'space' then
            if menu_selected == 1 then state = 'play' end
            if menu_selected == 2 then love.event.quit() end
        end
    elseif state == 'play' then
        if key == 'escape' then state = 'pause' end
        if key == '1' then player.mode = 'physical' end
        if key == '2' then player.mode = 'ranged' end
        if key == '3' then player.mode = 'magic' end
        if key == 'f' then attack() end
    elseif state == 'pause' then
        if key == 'up' or key == 'w' then pause_selected = 1 end
        if key == 'down' or key == 's' then pause_selected = 2 end
        if key == 'return' or key == 'space' then
            if pause_selected == 1 then state = 'play' end
            if pause_selected == 2 then love.event.quit() end
        end
    end
end

function attack()
    local dmg = 0
    if player.mode == 'physical' then dmg = 10
    elseif player.mode == 'ranged' then dmg = 7
    elseif player.mode == 'magic' then dmg = 12 end
    enemy.hp = enemy.hp - dmg
    if enemy.hp < 0 then enemy.hp = 0 end
end

function love.draw()
    love.graphics.setFont(font)
    if state == 'start' then
        love.graphics.printf('ADVENTURE GAME', 0, 80, 800, 'center')
        love.graphics.printf('> Start Game', 0, 160, 800, menu_selected==1 and 'center' or 'center')
        love.graphics.printf('  Exit', 0, 200, 800, menu_selected==2 and 'center' or 'center')
        if menu_selected == 2 then
            love.graphics.setColor(1,0,0)
            love.graphics.printf('> Exit', 0, 200, 800, 'center')
            love.graphics.setColor(1,1,1)
        end
    elseif state == 'play' then
        love.graphics.draw(assets.bg, 0, 0)
        love.graphics.draw(assets.player, player.x, player.y)
        love.graphics.draw(assets.enemy, enemy.x, enemy.y)
        love.graphics.print('Player HP: '..player.hp..' | Mode: '..player.mode..' (1-Physical, 2-Ranged, 3-Magic)', 10, 10)
        love.graphics.print('Enemy HP: '..enemy.hp, 10, 40)
        love.graphics.print('Press F to attack. ESC to pause.', 10, 70)
    elseif state == 'pause' then
        love.graphics.printf('PAUSED', 0, 120, 800, 'center')
        love.graphics.printf('> Resume', 0, 180, 800, pause_selected==1 and 'center' or 'center')
        love.graphics.printf('  Exit', 0, 220, 800, pause_selected==2 and 'center' or 'center')
        if pause_selected == 2 then
            love.graphics.setColor(1,0,0)
            love.graphics.printf('> Exit', 0, 220, 800, 'center')
            love.graphics.setColor(1,1,1)
        end
    end
end
