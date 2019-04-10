SparkWerk.Options = {}
SparkWerk.Options.CheckboxOptions = {}
SparkWerk.Options.ColorPickerOptions = {}
SparkWerk.Options.SliderOptions = {}
SparkWerk.Options.DropDownOptions = {}

surface.CreateFont("options_title", {
    font = "Trebuchet MS",
    size = 30 * (ScrH()/720),
    weight = 100,
    antialias = true,
    shadow = false,
    extended = true,
    outline = false
})

surface.CreateFont("sub_title_font", {
    font = "Marlett",
    size = math.max(10 * (ScrH()/720), 12),
    weight = 100,
    antialias = true,
    shadow = false,
    extended = true,
    outline = false
})

if not BetterScreenScale then
    function BetterScreenScale()
        return math.max(ScrH() / 1080, 0.851) * (SparkWerk.Options.InterfaceSize or 1)
    end
end

function SparkWerk:AddNewCheckBoxOption(name, convar, cat)
    self.Options.CheckboxOptions[#self.Options.CheckboxOptions + 1] =
        {Name = name, Convar = convar, Cat = cat}
end

function SparkWerk:AddNewColorPickerOption(name, convars, cat)
    self.Options.ColorPickerOptions[#self.Options.ColorPickerOptions + 1] =
        {Name = name, Convars = convars, Cat = cat}
end

function SparkWerk:AddNewSliderOption(name, convar, decimals, min, max, cat)
    self.Options.SliderOptions[#self.Options.SliderOptions + 1] =
        {Name = name, Convar = convar, Decimals = decimals, Min = min, Max = max, Cat = cat}
end

function SparkWerk:AddNewDropDownOption(name, convar, option_mapping, binding, cat)
    self.Options.DropDownOptions[#self.Options.DropDownOptions + 1] =
        {Name = name, Convar = convar, OptionMapping = option_mapping, Binding = binding, Cat = cat}
end

OPTIONS_CATEGORY_COSMETICS = 1
OPTIONS_CATEGORY_CHAT = 2

SparkWerk.Options.OptionsMenuCategories = {
	[OPTIONS_CATEGORY_COSMETICS] 	= "Cosmetics",
	[OPTIONS_CATEGORY_CHAT] 		= "Chat"
}

local function GetChatboxFonts()
    local ret_table = {} --idk

    for font_name, _ in pairs(sparkchat.fonts) do
        ret_table[font_name] = font_name
    end
    
    return ret_table
end

local function ChatboxBinding()
    return sparkchat:GetFont()
end

local function BuildOptionsForMenu()
    SparkWerk.Options.CheckboxOptions = {}
	SparkWerk.Options.ColorPickerOptions = {}
	SparkWerk.Options.SliderOptions = {}
	SparkWerk.Options.DropDownOptions = {}

    SparkWerk:AddNewCheckBoxOption("Enable cosmetics", 			                "spark_cosmetics",	 		OPTIONS_CATEGORY_COSMETICS)

    SparkWerk:AddNewCheckBoxOption("Hide chat box", 							"spark_chat_hide",	 		OPTIONS_CATEGORY_CHAT)
    SparkWerk:AddNewCheckBoxOption("Enable chat emotes", 						"spark_chat_emotes",	    OPTIONS_CATEGORY_CHAT)
    SparkWerk:AddNewCheckBoxOption("Enable sound emotes", 						"spark_emotes",	 		    OPTIONS_CATEGORY_CHAT)
    SparkWerk:AddNewCheckBoxOption("Enable sound emotes in console", 			"spark_emotes_log",	 		OPTIONS_CATEGORY_CHAT)
    SparkWerk:AddNewSliderOption("Sound emote voice pitch", 			 "spark_voicepitch", 0, 50, 200,    OPTIONS_CATEGORY_CHAT)
    SparkWerk:AddNewDropDownOption("Chatbox font", 			             "sparkwerk_chat_font", GetChatboxFonts, ChatboxBinding, OPTIONS_CATEGORY_CHAT)
end

local function EasyLabel(parent, text, font, textcolor)
	local dpanel = vgui.Create("DLabel", parent)
	if font then
		dpanel:SetFont(font or "DefaultFont")
	end
	dpanel:SetText(text)
	dpanel:SizeToContents()
	if textcolor then
		dpanel:SetTextColor(textcolor)
	end
	dpanel:SetKeyboardInputEnabled(false)
	dpanel:SetMouseInputEnabled(false)

	return dpanel
end

function SparkWerk:MakeOptionsMenu()
    if self.OptionsMenu then
        local menu = self.OptionsMenu

        menu:SetVisible(true)
        menu:MakePopup()
        return
    else
        BuildOptionsForMenu()
    end

    local screenscale = BetterScreenScale()
	local wid, hei = math.min(ScrW(), 650) * screenscale, math.min(ScrH(), 650) * screenscale

	local y = 32

	local frame = vgui.Create("DFrame")
	frame:SetDeleteOnClose(false)
	frame:SetSize(wid, hei)
	frame:SetTitle(" ")
	frame:Center()
    frame:SetSkin("sunrust")

	local label = EasyLabel(frame, "Sunrust Options", "options_title", color_white)
	label:SetPos(wid * 0.5 - label:GetWide() * 0.5, y)
	y = y + label:GetTall() + 64

	self.OptionsMenu = frame
	self.OptionsMenu.Lists = {}
	self.OptionsMenu.Buttons = {}

    local options_tb = self.Options

	for i = 1, #options_tb.OptionsMenuCategories do
		local list = vgui.Create("DPanelList", frame)
		list:EnableVerticalScrollbar()
		list:EnableHorizontal(false)
		list:SetSize(wid - 24, hei - y - 12)
		list:SetPos(12, y)
		list:SetPadding(8)
		list:SetSpacing(8)

		local tbn = EasyButton(frame, options_tb.OptionsMenuCategories[i], 2, 8)
		tbn:SetFont("sub_title_font")
		tbn:SetAlpha(i == 1 and 255 or 70)
		tbn:MoveBelow(label, 16)
		tbn:SetContentAlignment(5)
		tbn:SetSize(100 * screenscale, 32 * screenscale)
		tbn:AlignLeft(8 + (i - 1) * 108 * screenscale)

		tbn.DoClick = function(me)
			for k, v in pairs(self.OptionsMenu.Lists) do
				v:SetVisible(k == i)
				self.OptionsMenu.Buttons[k]:SetAlpha(k == i and 255 or 70)
			end
		end

		for _, v in ipairs(options_tb.CheckboxOptions) do
			if v.Cat == i then
				local check = vgui.Create("DEXCheckBoxSunrustLabel", frame)
				check:SetText(v.Name)
				check:SetConVar(v.Convar)
				check:SetFont("sub_title_font")
				check:SizeToContents()
				list:AddItem(check)
			end
		end
		for _, v in ipairs(options_tb.ColorPickerOptions) do
			if v.Cat == i then
				list:AddItem(EasyLabel(frame, v.Name, "sub_title_font", color_white))
				local colpicker = vgui.Create("DColorMixer", frame)
				colpicker:SetAlphaBar(v.Convars.SetConVarA)
				colpicker:SetPalette(false)
				colpicker:SetConVarR(v.Convars.SetConVarR)
				colpicker:SetConVarG(v.Convars.SetConVarG)
				colpicker:SetConVarB(v.Convars.SetConVarB)
				colpicker:SetConVarA(v.Convars.SetConVarA)
				colpicker:SetTall(90 * screenscale)
				list:AddItem(colpicker)
			end
		end
		for _, v in ipairs(options_tb.SliderOptions) do
			if v.Cat == i then
				local slider = vgui.Create("DNumSlider", frame)
				slider:SetDecimals(v.Decimals)
				slider:SetMinMax(v.Min, v.Max)
				slider:SetConVar(v.Convar)
				slider:SetText(v.Name)
				slider.Label:SetFont("sub_title_font")
				slider:SizeToContents()
				list:AddItem(slider)
			end
		end
		for _, v in ipairs(options_tb.DropDownOptions) do
			if v.Cat == i then
				list:AddItem(EasyLabel(frame, v.Name, "sub_title_font", color_white))
				local dropdown = vgui.Create("DComboBox", frame)
				dropdown:SetMouseInputEnabled(true)

				local option_mapping = isfunction(v.OptionMapping) and v.OptionMapping() or v.OptionMapping

				for key, val in pairs(option_mapping) do
					dropdown:AddChoice(val)
				end
				dropdown.OnSelect = function(me, index, value, data)
					RunConsoleCommand(v.Convar, table.KeysFromValue(option_mapping, value)[1])
				end

				dropdown:SetText(v.Binding() or "default")
				dropdown:SetTextColor(color_white)
				dropdown:SetTall(30 * screenscale)

				list:AddItem(dropdown)
			end
		end

		list:SetVisible(i == 1)
		self.OptionsMenu.Lists[i] = list
		self.OptionsMenu.Buttons[i] = tbn
	end

	frame:MakePopup()
end

function SparkWerk:ClearOptionsMenu()
	if self.OptionsMenu then
		self.OptionsMenu:SetVisible(false)
		self.OptionsMenu = nil
	end
end
