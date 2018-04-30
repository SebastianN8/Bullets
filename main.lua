-----------------------------------------------------------------------------------------
--
-- main.lua
-- Created by: Sebastian N
-- Created on: April 23
--
-- This program moves an object to four sides and has gravity
-----------------------------------------------------------------------------------------
-- Addition of physics
local physics = require('physics')
physics.start()
physics.setGravity(0, 25)
--physics.setDrawMode('hybrid')

local theBullets = {} -- This is the table created

-- Left barrier
local leftBarrier = display.newRect(0, display.contentHeight / 2, 1, display.contentHeight)
leftBarrier.id = 'The left Barrier'
--physics.addBody(leftBarrier, 'static', {
--	friction = 0.5,
--	bounce = 0.3
--})

-- Right barrier
--local rightBarrier = display.newRect(display.contentWidth, display.contentHeight / 2, 1, display.contentHeight)
--rightBarrier.id = 'The right barrier'
--physics.addBody(rightBarrier, 'static', {
--	friction = 0.5,
--	bounce = 0.3
--})

-- The land from the top
local topLand = display.newImageRect('./Assets/Sprites/land.png', 1000, 200)
topLand.x = display.contentCenterX + 800
topLand.y = display.contentCenterY
topLand.id = 'Top land'
physics.addBody(topLand, 'static', {
	friction = 0.5,
	bounce = 0.3
	})

-- The land
local theLand = display.newImageRect('./Assets/Sprites/land.png', 2000, 400)
theLand.x = display.contentCenterX + 500
theLand.y = display.contentHeight
theLand.id = 'The land'
-- Addition of physics for the land
physics.addBody(theLand, 'static', {
	friction = 0.5,
	bounce = 0.3
	})

-- The character
local theSnowMan = display.newImageRect('./Assets/Sprites/SnowMan.png', 350, 400)
theSnowMan.x = display.contentCenterX + 500
theSnowMan.y = display.contentCenterY - 500
theSnowMan.id = 'Snow Man'
-- Addition of physics for the snow man
physics.addBody(theSnowMan, 'dynamic', {
	density = 3.0,
	friction = 0.5,
	bounce = 0.3
	})
theSnowMan.isFixedRotation = true

-- The second dynamic sprite
local theLandSquare = display.newImage('./Assets/Sprites/landSquare.png')
theLandSquare.x = display.contentCenterX
theLandSquare.y = display.contentCenterY
theLandSquare.id = 'The land square'
physics.addBody(theLandSquare, 'dynamic', {
	friction = 0.5,
	bounce = 0.3
	})
theLandSquare.isFixedRotation = true

-- D-pad
local thedPad = display.newImage('./Assets/Sprites/d-pad.png')
thedPad.x = 160
thedPad.y = display.contentHeight - 160
thedPad.id = 'The d-pad'
thedPad.alpha = 0.5

-- Up arrow
local upArrow = display.newImage('./Assets/Sprites/upArrow.png')
upArrow.x = 160
upArrow.y = display.contentHeight - 268.7
upArrow.id = 'Up arrow'

-- Down arrow
local downArrow = display.newImage('./Assets/Sprites/downArrow.png')
downArrow.x = 160
downArrow.y = display.contentHeight - 52.3
downArrow.id = 'Down arrow'

-- Left arrow
local leftArrow = display.newImage('./Assets/Sprites/leftArrow.png')
leftArrow.x = 52
leftArrow.y = display.contentHeight - 160
leftArrow.id = 'Left arrow'

-- Right arrow
local rightArrow = display.newImage('./Assets/Sprites/rightArrow.png')
rightArrow.x = 268.7
rightArrow.y = display.contentHeight - 160
rightArrow.id = 'Right arrow'

-- Jump button
local jumpButton = display.newImage('./Assets/Sprites/jumpButton.png')
jumpButton.x = display.contentWidth - 80
jumpButton.y = display.contentHeight - 80
jumpButton.id = 'Jump button'
jumpButton.alpha = 1

local shootButton = display.newImage('./Assets/Sprites/jumpButton.png')
shootButton.x = display.contentWidth - 230
shootButton.y = display.contentHeight - 80
shootButton.id = 'Shoot button'

-- Up Arrow Functions
function upArrow:touch(event)
	if (event.phase == 'ended') then
		-- Movement function
		transition.moveBy(theSnowMan, { 
			x = 0,
			y = -50,
			time = 100
			})
	end
end

-- Down Arrow Functions
function downArrow:touch(event)
	if (event.phase == 'ended') then
		-- Movement function
		transition.moveBy(theSnowMan, { 
			x = 0,
			y = 50,
			time = 100
			})
	end
end

-- Left Arrow Functions
function leftArrow:touch(event)
	if (event.phase == 'ended') then
		-- Movement function
		transition.moveBy(theSnowMan, { 
			x = -50,
			y = 0,
			time = 100
			})
	end
end

-- Right Arrow Functions
function rightArrow:touch(event)
	if (event.phase == 'ended') then
		-- Movement function
		transition.moveBy(theSnowMan, { 
			x = 50,
			y = 0,
			time = 100
			})
	end
end

-- Respawn snowman function
local function falllingSnow(event)
	if theSnowMan.y > display.contentHeight + 300 then
		theSnowMan.x = display.contentCenterX + 500
		theSnowMan.y = display.contentCenterY - 500
	end
	if theLandSquare.y > display.contentHeight + 300 then
		theLandSquare.x = display.contentCenterX
		theLandSquare.y = display.contentCenterY
	end
end

-- Respawn land function
--local function fallingLand(event)
--	if theLandSquare.y > display.contentHeight + 300 then
--		theLandSquare.x = display.contentCenterX
--		theLandSquare.y = display.contentCenterY
--	end
--end


-- Jumping function
local function jumpingSnow(event)
	if event.phase == 'ended' then
		theSnowMan:setLinearVelocity(0, -750)
	end
end

-- Collision function
local function collisionControl(self, event)
	if (event.phase == 'began') then
		print(self.id.. ' is on collision with '..event.other.id)
	elseif (event.phase == 'ended') then
		print(self.id.. ' ended collision with '..event.other.id)
	end
end

-- Shoot function 
function shootButton:touch(event)
	if (event.phase == 'began') then
		-- Creating the bullet in screen
		local singleBullet = display.newImage('./Assets/Sprites/Kunai.png')
		singleBullet.x = theSnowMan.x
		singleBullet.y = theSnowMan.y
		singleBullet.id = 'The bullet'
		physics.addBody(singleBullet, 'dynamic')
		singleBullet.isFixedRotation = true
		-- Making the object a bullet
		singleBullet.isBullet = true
		singleBullet.gravityScale = 0
		singleBullet:setLinearVelocity(1500, 0)

		-- Putting the bullet into the table
		table.insert(theBullets, singleBullet)
		print('# of bullet '.. tostring(#theBullets))
	end
end

local function checkBulletsOutBounds(event)
	-- variable for the counter
	local bulletCounter

	if #theBullets > 0 then
		for bulletCounter = #theBullets, 1, -1 do
			if theBullets[bulletCounter].x > display.contentWidth + 1000 then
				theBullets[bulletCounter]:removeSelf()
				theBullets[bulletCounter] = nil
				table.remove(theBullets, bulletCounter)
				print('# of bullet removed: '.. tostring(bulletCounter))
			end
		end
	end
end



-- Event Listeners
upArrow:addEventListener('touch', upArrow)
downArrow:addEventListener('touch', downArrow)
leftArrow:addEventListener('touch', leftArrow)
rightArrow:addEventListener('touch', rightArrow)
Runtime:addEventListener('enterFrame', falllingSnow)
jumpButton:addEventListener('touch', jumpingSnow)
--Runtime:addEventListener('enterFrame', fallingLand)
shootButton:addEventListener('touch', shootButton) -- Event listener forthe shoot button

-- Event listener for collision
theSnowMan.collision = collisionControl
theSnowMan:addEventListener('collision')
theLandSquare.collision = collisionControl
theLandSquare:addEventListener('collision')
Runtime:addEventListener('enterFrame', checkBulletsOutBounds)