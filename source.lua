local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local mouse = game:GetService("Players").LocalPlayer:GetMouse()
local rogui = {}

function rogui:FollowMouse(NewUi)
	local mouseLocation = UserInputService:GetMouseLocation()
	NewUI.Position = UDim2.new(0, mouseLocation.X+NewUI.TextBounds.X/2, 0, mouseLocation.Y-36)
end
function rogui:DataFrame(obj)
	local frame = Instance.new("Frame", gui)
	frame.Size = UDim2.new(0,150,0,125)
	frame.Position = UDim2.new(0,0,0,0)
	local text = Instance.new("TextLabel", frame)
	text.Size = UDim2.new(1,0,0.1,0)
	text.BackgroundTransparency = 1
	text.Font = Enum.Font.ArialBold
	text.Text = 'Size: '..tostring(obj.Size)
	text.TextColor3 = Color3.new(1,1,1)
	text.TextScaled = true

	local text = Instance.new("TextLabel", frame)
	text.Size = UDim2.new(1,0,0.1,0)
	text.Position = UDim2.new(0,0,0.1,0)
	text.BackgroundTransparency = 1
	text.Font = Enum.Font.ArialBold
	text.Text = 'Position: '..tostring(obj.Position)
	text.TextColor3 = Color3.new(1,1,1)
	text.TextScaled = true

	local text = Instance.new("TextLabel", frame)
	text.Size = UDim2.new(1,0,0.1,0)
	text.Position = UDim2.new(0,0,0.2,0)
	text.BackgroundTransparency = 1
	text.Font = Enum.Font.ArialBold
	text.Text = 'Name: '..tostring(obj.Name)
	text.TextColor3 = Color3.new(1,1,1)
	text.TextScaled = true

	local text = Instance.new("TextLabel", frame)
	text.Size = UDim2.new(1,0,0.1,0)
	text.Position = UDim2.new(0,0,0.3,0)
	text.BackgroundTransparency = 1
	text.Font = Enum.Font.ArialBold
	text.Text = 'Anchor Point: '..tostring(obj.AnchorPoint)
	text.TextColor3 = Color3.new(1,1,1)
	text.TextScaled = true
	return frame
end

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
