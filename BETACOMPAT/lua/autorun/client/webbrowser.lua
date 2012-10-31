
local PANEL={}

function PANEL:Init()
	self:SetVisible(false)
	self:SetSize(ScrW()*0.9,ScrH()*0.8)
	self:Center()
	self:SetTitle( "Web Browser" )
	self:SetDeleteOnClose( false )
	self:ShowCloseButton( true )
	self:SetDraggable( true )
	self:SetSizable( true )
	
	local top = vgui.Create( "EditablePanel", self )
		self.top=top
		top:Dock(TOP)
		top:SetTall(24)
		
	local btn = vgui.Create("DButton",self.top)
		btn:SetText("Back")
		btn:SizeToContents()
		btn:SetWide(btn:GetWide()+8)
		btn:Dock(LEFT)
		function btn.DoClick()
			self.browser:RunJavascript[[history.back();]]
		end
	local btn = vgui.Create("DButton",self.top)
		btn:SetText("Forward")
		btn:SizeToContents()
		btn:SetWide(btn:GetWide()+8)
		btn:Dock(LEFT)
		function btn.DoClick()
			self.browser:RunJavascript[[history.forward();]]
		end
	local btn = vgui.Create("DButton",self.top)
		btn:SetText("Refresh")
		btn:SizeToContents()
		btn:SetWide(btn:GetWide()+8)
		btn:Dock(LEFT)
		function btn.DoClick()
			self.browser:RunJavascript[[location.reload(true);]]
		end
		btn.Paint=function(btn,w,h) 
			DButton.Paint(btn,w,h)
			if self.loaded and self.browser:IsLoading() then
				self.loaded=false
			end
			if self.loaded then
				surface.SetDrawColor(100,240,50,200)
				surface.DrawRect(1,1,w-2,h-2)				
			end
			if not self.browser:IsLoading() then return end
			surface.SetDrawColor(240+math.sin(RealTime()*10)*15,100,50,200)
			surface.DrawRect(1,1,w-2,h-2)			
		end
		
	local entry = vgui.Create( "DTextEntry", top )
		self.entry=entry
		entry:Dock(FILL)
		entry:SetTall(  24 )
		
		function entry.OnEnter(entry)
			local val=entry:GetText()
			local js,txt = val:match("javascript:(.+)")
			if js and txt then
				self.browser:QueueJavascript(txt)
				return
			end
			self:OpenURL(val)
			
		end
		/*entry.Paint=function(entry,w,h)
			DTextEntry.Paint(entry,w,h)
			if self.browser:IsLoading() then
				draw.RoundedBox(h*0.5,w-h,0,h,h,Color(200,150,0,255))
			end
		end*/

		
	local browser = vgui.Create( "DHTML", self )
		self.browser=browser
		browser:Dock(FILL)
	browser.Paint=function() end
	browser.OpeningURL=print
	browser.FinishedURL=print
	browser:AddFunction( "gmod", "LoadedURL", function(url,title) self:LoadedURL(url,title) end )
	browser:AddFunction( "gmod", "dbg", function(...) Msg"[Browser] " print(...) end )
	browser:AddFunction( "gmod", "status", function(txt) self:StatusChanged(txt) end )
	browser.ActionSignal=function(...) Msg"[BrowserACT] " print(...)  end
	browser.OnKeyCodePressed=function(browser,code) 
		if code==96 then
			self.browser:RunJavascript[[location.reload(true);]]
			return
		end
		--print("BROWSERKEY",code)
	end
	
	local status = vgui.Create( "DLabel", self )
		self.status=status
		status:SetText""
		status:Dock(BOTTOM)
end

function PANEL:StatusChanged(txt)
	if self.statustxt~=txt then
		self.statustxt=txt
		self.status:SetText(txt or "")
	end
end

function PANEL:LoadedURL(url,title)
	if self.entry:HasFocus() then return end
	self.entry:SetText(url)
	self.loaded=true
	self:SetTitle(title and title!="" and title or "Web browser")
end
function PANEL:OpenURL(url)
	self.browser:OpenURL(url)
	self.entry:SetText(url)
end

function PANEL:Think(w,h)
	self.BaseClass.Think(self,w,h)
	if input.IsKeyDown(KEY_ESCAPE) then self:Close() end
	
	/*if self.browser:IsLoading() then
		self.browser:RunJavascript[[gmod.LoadedURL(document.location.href);]]
	end*/
	
	if not self.wasloading and self.browser:IsLoading() then
		self.wasloading=true
		--print"Loading..."
	end
	if self.wasloading and not self.browser:IsLoading() then
		self.wasloading=false
		--print("WAS LOADING")
		self.browser:QueueJavascript[[gmod.LoadedURL(document.location.href,document.title); gmod.status(""); ]]
		self.browser:QueueJavascript[[function alert(str) { console.log("Alert: "+str); }]]
		self.browser:QueueJavascript[[
			function getLink() {
				gmod.status(this.href || "-");
			}
			function clickLink() {
				if (this.href) {
					gmod.LoadedURL(this.href,"Loading...");
				}
				gmod.status("Loading...");
			}			
			var links = document.getElementsByTagName("a");
			for (i = 0; i < links.length; i++) {
				links[i].addEventListener('mouseover',getLink,false)
				links[i].addEventListener('click',clickLink,false)
			}

		]]
		--self.browser:QueueJavascript[[window.onclick = function( e ) { gmod.dbg("onclick"); }]]
		--self.browser:QueueJavascript[[window.onunload = function( e ) { gmod.dbg("onunload"); }]]
		--self.browser:QueueJavascript[[window.onbeforeunload = function( e ) { gmod.dbg("onbeforeunload"); }]]

	end	
	
end


function PANEL:Show()
	if not self:IsVisible() then
		self:SetVisible(true)
		self:MakePopup()
		self:SetKeyboardInputEnabled( true )
		self:SetMouseInputEnabled( true )
	end
	if ValidPanel(self.browser) then
		self.browser:RequestFocus()
	end
	--hook.Run("OnContextMenuOpen")
end


function PANEL:Close()
	self:SetVisible(false)
	--hook.Run("OnContextMenuClose")
end

local Cwebbrowser_panel = vgui.RegisterTable(PANEL,"DFrame")


local webbrowser_panel

function HidePanel()

	webbrowser_panel:Close()

end

local function ShowPanel(url)

	if not ValidPanel(webbrowser_panel) then
		webbrowser_panel=vgui.CreateFromTable(Cwebbrowser_panel)
		_G.p=webbrowser_panel
	end
	
	webbrowser_panel:Show()
	if url and url!="" then
		webbrowser_panel:OpenURL(url)
	end
	
end
function gui.OpenURL(url)
	ShowPanel(url)
end

concommand.Add( "webbrowser", function(a,b,c) local url=c[1] ShowPanel(url) end)