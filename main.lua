require("Math/Math")
require("Renderer")
require("Shader")
require("Camera")
require("Renderable")
require("Material")

Resolution = {x = 1600, y = 900}
WindowSize = {x = 1600, y = 900}
local myRenderer = Renderer(0, 0, Resolution.x, Resolution.y)
local myCamera = Camera(WindowSize.x / WindowSize.y)
local myShader = Shader(myCamera)
local myMaterial = Material(myShader)
local cat = Renderable(myMaterial)

local rotate = 0

function love.load()
  --Load model from .obj file, set its position and scale
  --加载.obj文件
  cat:LoadObj("chair_01.obj")
  cat:SetPosition(0, -0.5, 0)
  cat:SetScale(6, 6, 6)

  --Init windows and image,etc
  --初始化窗口等
  love.window.setMode(WindowSize.x, WindowSize.y, {resizable = true})
  imageData = love.image.newImageData(Resolution.x, Resolution.y)
  image = love.graphics.newImage(imageData)
  image:setFilter("nearest")
end

function love.update(dt)
  --Rotate model
  --旋转模型
  rotate = rotate + dt / 3
  cat:SetRotation(0, rotate, 0)

  --Clear imageData every frame
  --每帧清空buffer
  imageData:mapPixel(
    function()
      return 0, 0, 0, 0
    end
  )

  myRenderer:Render(dt, imageData, cat, Vector4(0.4, 0.7, 1, 1))
end

function love.draw()
  image:replacePixels(imageData)
  love.graphics.draw(image, 0, 0, 0, WindowSize.x / Resolution.x, WindowSize.y / Resolution.y)
  love.graphics.print("FPS: " .. love.timer.getFPS(), WindowSize.x / 2, 0)
  love.graphics.print("Resolution: " .. Resolution.x .. "," .. Resolution.y, WindowSize.x * 0.8, 0)
end
