-- Create a function to convert the colors to HTML.
local function ColorToHTML( color )

	-- Convert the color to a table.
	local colorTbl = {color.r,color.g,color.b,color.a}

	-- Update the alpha of the color
	colorTbl[4] = math.Round(colorTbl[4] / 255, 1)

	-- Return the CSS code.
	return "rgba(" .. table.concat(colorTbl, ",") .. ")"

end

-- Create a table to store the derma element in.
local PANEL = {}

-- Create a init function for the panel.
function PANEL:Init( )

	-- Set the theme.
	EdgeScoreboard.SetEdgeTheme( self, true, true )

end

-- Create a function to set the stats.
function PANEL:SetStats( statsTable, maxHeight, lineColor, dotColor, backgroundColor )

	-- Create a string for the SVG-HTML.
	local SVGHTML = ""

	-- Get the columnWidth.
	local columnWidth = self:GetWide() / 11

	-- Create the columns.
	for i = 1,10 do
		SVGHTML = SVGHTML .. "<rect x='" .. math.Round(columnWidth * i,2) .. "' height='100%' width='1px'/>"
	end

	-- Create a var for the highest value.
	local highestValue = 0

	-- Find the highest value.
	for k,v in pairs(statsTable) do
		highestValue = math.max(highestValue,v)
	end

	-- Calculate the value-fraction so the graph never exceeds more than 80% of the height.
	local valFrac = self:GetTall() * maxHeight / math.max(highestValue,1)

	-- Create a string for the polygon points.
	local points = ""

	-- Calculate the background polygon points.
	for k,v in pairs(statsTable) do
		points = points .. math.Round(columnWidth * (k - 1),2) .. "," .. math.Round(self:GetTall() - v * valFrac) .. " "
	end

	-- Add the bottom corners.
	points = points .. self:GetWide() .. "," .. self:GetTall() .. " "
	points = points .. "0," .. self:GetTall()

	-- Add the polygon to the SVGHTML var.
	SVGHTML = SVGHTML .. "<polygon points='" .. points .. "'/>"

	-- Add the lines.
	for i = 1,11 do
		SVGHTML = SVGHTML .. "<line x1='" .. math.Round(columnWidth * (i - 1),2) .. "' y1='" .. math.Round(self:GetTall() - statsTable[i] * valFrac) .. "' x2='" .. math.Round(columnWidth * i,2) .. "' y2='" .. math.Round(self:GetTall() - statsTable[i + 1] * valFrac) .. "'/>"
	end

	-- Add the dots.
	for i = 1,10 do
		SVGHTML = SVGHTML .. "<circle r='1.75%' cx='" .. math.Round(columnWidth * i,2) .. "' cy='" .. math.Round(self:GetTall() - statsTable[i + 1] * valFrac) .. "'/>"
	end

	-- Set the HTML of the panel.
	self:SetHTML("<html><head><meta name='viewport' content='width=device-width, initial-scale=1.0'><style>*{margin: 0;padding: 0;overflow: hidden;}rect{fill: rgba(255,255,255,0.1);}polygon{fill:" .. ColorToHTML(backgroundColor) .. ";}line{stroke:" .. ColorToHTML(lineColor) .. ";stroke-width:2;}circle{fill:" .. ColorToHTML(dotColor) .. ";}</style></head><body><svg width='100%' height='100%'>" .. SVGHTML .. "</svg></body></html>")

end

-- Register the derma element.
vgui.Register("EdgeScoreboard:Graph", PANEL, "DHTML")