If (Form event code:C388=On Load:K2:1)
	OBJECT SET VISIBLE:C603(*; "Tb_@"; False:C215)
End if 

If (Form event code:C388=On Clicked:K2:4)
	If (tab control=1)
		OBJECT SET VISIBLE:C603(*; "Tb_@"; False:C215)
	Else 
		OBJECT SET VISIBLE:C603(*; "Tb_@"; True:C214)
	End if 
End if 