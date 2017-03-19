Dim n
If Application.GPS.IsOpen then
	Application.GPS.Close() 'Turn Off the GPS
	n=1
End If

	Dim TrackLayer, fileName, DateText
	Set TrackLayer = Application.Map.Layers(0) 'Get the tracklog layer

	COnsole.print TrackLayer.Name

Dim filePath, name, fileName
filePath = "C:\DSD_Minerals\DATA\TrackLogs"
name = "Tracklog"
fileName = filePath & "\" & name



	DateText = "_" & hour(now) & minute(now) & second(now) & "_" & Day(Date) & "_" & Month(Date) & "_" & Year(Date) 'Create a DateTime Stamp

	Dim myFile
	Set myFile = Application.CreateAppObject("file") 'Create a File object to move the original tracklog to.

	'Move all of the files associated with the tracklog and rename them
	call myFile.Move((fileName & ".shp"), fileName & DateText &".shp")
	call myFile.Move((fileName & ".dbf"), fileName & DateText &".dbf")
	call myFile.Move((fileName & ".shx"), fileName & DateText &".shx")
	call myFile.Move((fileName & ".prj"), fileName & DateText &".prj")



	Dim trs
	Set trs = Map.Layers(fileName & DateText &".shp").Records
    trs.MoveFirst

	Dim ds
	Set ds = Map.Layers("MASTER.MERRegApp_MinTracklogPoint").DataSource

    If ds.IsOpen Then
		Console.print "going to copy features..."
                While not trs.EOF
                 
                Wend
	End If

	If n=1 then
	Application.GPS.Open() 'Turn the GPS on
	Application.ExecuteCommand("gpstracklog") 'Turn the tracklog on
	End If
