Option Explicit

Sub getGPS_Coords(pgeObject)
	pgeObject.Controls("txtLong").text = GPS.X
	pgeObject.Controls("txtLat").text = GPS.Y
End Sub


Sub removeGPS_Coords(pgeObject)
	pgeObject.Controls("txtLong").text = ""
	pgeObject.Controls("txtLat").text = ""
End Sub

Sub ConvertCoords(pgeObject, zonecode)
      'Create a Point object (which inherits the map's coordsys)
	Dim pPt
	Set pPt = Application.CreateAppObject ("Point")

	'Assign the X and Y values to the point object
	If pgeObject.COntrols("txtLong").text > "" Then
		pPt.X = CDbl(pgeObject.COntrols("txtLong").text)
		pPt.Y = CDbl(pgeObject.Controls("txtLat").text)
	End If

	Dim pCS 
	Set pCS = Application.CreateAppObject ("CoordSys")
	
	If zonecode = 52 Then
		pCS.Import "C:\DSD_Minerals\CoordSystems\GDA 1994 MGA Zone 52.prj"
	ElseIf zonecode = 53 Then
		pCS.Import "C:\DSD_Minerals\CoordSystems\GDA 1994 MGA Zone 53.prj"
	ElseIf zonecode = 54 Then
		pCS.Import "C:\DSD_Minerals\CoordSystems\GDA 1994 MGA Zone 54.prj"
	ElseIf zonecode = 99 Then
		pCS.Import "C:\DSD_Minerals\CoordSystems\GDA 1994 South Australia Lambert.prj"
	End If

	'Unproject the point to WGS 1984 Lat/Lon
	Dim pProj
	Set pProj = pCS.Project (pPt)

	'Display the unprojected coordinates

	pgeObject.Controls("lblConvertedX").text = pProj.X
	pgeObject.Controls("lblConvertedY").text = pProj.Y

	'Clean up
	Set pPt = Nothing
	Set pCS = Nothing
	Set pProj = Nothing
End Sub
