//the button already has "accept" standard action
If (Form event code:C388=On Clicked:K2:4)
	
	If (Form.quit)
		INVOKE ACTION(ak return to design mode)
	Else 
		
		var $window : Integer
		$window:=Open form window:C675("HDI2"; Plain form window:K39:10; On the left:K39:2; At the top:K39:5)
		SET WINDOW TITLE(Get window title(Current form window); $window)
		DIALOG:C40("HDI2"; Form; *)
		
	End if 
	
End if 
