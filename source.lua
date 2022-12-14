local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local mouse = game:GetService("Players").LocalPlayer:GetMouse()
local rogui = {}

function rogui:FollowMouse(NewUi)
	local mouseLocation = UserInputService:GetMouseLocation()
	if NewUi:IsA("TextLabel") or NewUi:IsA("TextButton") or NewUi:IsA("TextBox") then
		NewUi.Position = UDim2.new(0, mouseLocation.X+NewUi.TextBounds.X/2, 0, mouseLocation.Y-36)
	else
		NewUi.Position = UDim2.new(0, mouseLocation.X--[[+NewUi.AbsoluteSize.X/2]], 0, mouseLocation.Y-36)
	end
end
function rogui:DataFrame(obj, gui)
	if gui:FindFirstChild("DataFrame") then
		gui.DataFrame:Destroy()
	end
	
	local frame = Instance.new("Frame", gui)
	frame.Name = "DataFrame"
	frame.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
	frame.BackgroundTransparency = 0.5
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
