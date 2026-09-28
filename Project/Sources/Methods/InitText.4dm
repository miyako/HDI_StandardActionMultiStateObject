//%attributes = {}
If (Get database localization:C1009(Current localization:K5:22)="ja")
	$json:=JSON Parse:C1218(Folder:C1567(fk resources folder:K87:11).file("SAMPLE-ja.json").getText(); Is collection:K8:32)
Else 
	$json:=JSON Parse:C1218(Folder:C1567(fk resources folder:K87:11).file("SAMPLE-en.json").getText(); Is collection:K8:32)
End if 

$SAMPLE:=$json.query("ID == :1"; 1).first()

//QUERY([SAMPLE]; [SAMPLE]ID=1)

WriteProArea:=$SAMPLE.Text4DWrite
stText:=$SAMPLE.TextVariable