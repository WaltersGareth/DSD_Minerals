Option Explicit


Sub ArchiveTrackLog

Dim n
If Application.GPS.IsOpen then
	Application.GPS.Close() 'Turn Off the GPS
	n=1
End If

	Dim TrackLayer, fileName, DateText
	Set TrackLayer = Application.Map.Layers(0) 'Get the tracklog layer

	COnsole.print TrackLayer.FilePath

	fileName = "C:\DSD_Minerals\DATA\Tracklogs\Tracklog" 'Create a file name by removing the extensions
	DateText = "_" & hour(now) & minute(now) & second(now) & "_" & Day(Date) & "_" & Month(Date) & "_" & Year(Date) 'Create a DateTime Stamp

	Dim myFile
	Set myFile = Application.CreateAppObject("file") 'Create a File object to move the original tracklog to.

	'Move all of the files associated with the tracklog and rename them
	call myFile.Move((fileName & ".shp"), fileName & DateText &".shp")
	call myFile.Move((fileName & ".dbf"), fileName & DateText &".dbf")
	call myFile.Move((fileName & ".shx"), fileName & DateText &".shx")
	call myFile.Move((fileName & ".prj"), fileName & DateText &".prj")

	Map.AddLayerFromFile(fileName & DateText &".shp")

	Dim trs
	Set trs = Map.Layers(fileName & DateText &".shp").Records
    trs.MoveFirst

	Dim ds
	Set ds = Map.Layers("MASTER.MERRegApp_MinTracklogPoint").DataSource

    If ds.IsOpen Then
		Console.print "going to copy features..."
	End If

	If n=1 then
	Application.GPS.Open() 'Turn the GPS on
	Application.ExecuteCommand("gpstracklog") 'Turn the tracklog on
	End If
End Sub


Sub AddTracklog

 'Launch the add layer dialog for user add tracklog

  Dim strDefExt, strFileFilter, strTitle, lngFlags, varResult
  'Set the arguments of the Open dialog box
  strDefExt = "apl"
  strFileFilter = "ArcPad Layers|*.shp"
  strTitle = "Choose an archived tracklog file that you wish to create a line feature from."
  lngFlags = &H1000   'only allow existing files to be specified
  'Show the Open dialog box and get the result
  varResult = CommonDialog.ShowOpen(strDefExt,strFileFilter,strTitle,lngFlags)
  'If a file is selected, add it to the map and refresh the map  
  If Not IsEmpty (varResult) Then  
    Application.Map.AddLayerFromFile (varResult)  
    Application.Map.Refresh
	Application.Map.Layers(1).Editable = True
  End If

End Sub


Sub ConvertPointtoLine(src, dst)

  Dim rs, pts, poly

  If src is Nothing Then
    Application.MessageBox "Cannot find an editable point layer. Ensure that you have first added an archived tracklog to your map, and made it editable."
    Exit Sub
  End If
  If dst is Nothing Then
    Application.MessageBox "Cannot find an editable polyline layer. Ensure that you have first added a line layer - eg: tracks.shp - to your map, and made it editable."
    Exit Sub
  End If
  Set pts = Application.CreateAppObject("Points")
  Set rs = src.Records
  rs.MoveFirst
  While not rs.EOF
    pts.Add rs.Fields.Shape.Clone
    rs.MoveNext
  Wend
  Set poly = Application.CreateAppObject("Line")
  poly.Parts.Add pts
  Set rs = dst.Records
  rs.AddNew poly
  rs.Update
  Map.Refresh True

End Sub
