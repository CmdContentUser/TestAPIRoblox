local rogui = {}

function rogui:DragGuiObject(obj)
  assert(obj ~= nil, "The object you have passed through this function is \"nil\".")
  
  function dr(gui)
    task.spawn(function()
      local dragging
      local dragInput
      local dragStart = Vector3.new(0,0,0)
      local startPos
      local function update(input)
        local delta = input.Position - dragStart
        local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        game:GetService("TweenService"):Create(gui, TweenInfo.new(.20), {Position = Position}):Play()
      end
      gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
          dragging = true
          dragStart = input.Position
          startPos = gui.Position

          input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
              dragging = false
            end
          end)
        end
      end)
      gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
          dragInput = input
        end
      end)
      UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
          update(input)
        end
      end)
    end)
  end
  dr(obj)
end

return rogui
