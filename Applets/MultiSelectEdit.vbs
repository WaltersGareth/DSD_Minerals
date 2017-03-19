Option Explicit

Dim selrs
Dim ptID
Dim ptType

Sub CreateMultiSelectRectangle()

Dim objRect
Set objRect = Application.Map.TrackRectangle
If Not objRect Is Nothing Then
	Dim xMin, yMin, xMax, yMax

	xMin = objRect.Left
	yMin = objRect.Bottom
	xMax = objRect.Right
	yMax = objRect.Top

	Dim ds
	Set ds = Map.Layers("MASTER.MERRegApp_MinPoints").DataSource

	If ds.IsOpen then
		set selrs =	ds.Execute ("Select * from MERRegApp_MinPoints where shape_x between " & xMin & " and " & xMax & " and shape_Y between " & yMin & " and " & yMax & ";")

		If (Not selrs Is Nothing) Then
			selrs.MoveFirst
			
			Map.SelectXY selrs.Fields("SHAPE_X").Value, selrs.Fields("SHAPE_Y").Value

			If Map.SelectionBookmark > 0 Then
				ptID = selrs.Fields("PTID").Value
				ptType = selrs.Fields("PTTYPE").Value
				'Console.print ptID & ", " & ptType

				Applets("MineralsTeam").Forms("frmIdentify").Show
			End If
		End If

	End If

	Set objRect = Nothing
	ds.close


End If

End Sub

Sub getInfo ( objEvent )

objEvent.Object.Controls("txtX").Text = selrs.Fields("SHAPE_X").Value
objEvent.Object.Controls("txtY").Text = selrs.Fields("SHAPE_Y").Value


End Sub

Sub PopulateIdentifyForm( objEvent )

Dim sqlStr

If ptType = "DH" Then
	sqlStr = "select mp.globalid, st.DESCRIPTION as std, dt.description as dtd,  mp.ptinfo, ma.stage, ma.peprid, ma.axf_Timestamp from MERREGAPP_MINPOINTS as mp, CVD_MERREGAPP_MINPOINTS_SITETYPE as st, CVD_MERREGAPP_MINPOINTS_DRILLHOLETYPE as dt, MERREGAPP_MINASSESSMENTS as ma where mp.pttype = st.code and mp.drillholetype = dt.code and mp.ptid = ma.ptid and mp.ptid = '" + ptID + "' order by ma.axf_timestamp desc;"
Else
	sqlStr = "select mp.globalid, st.DESCRIPTION as std, mp.ptinfo, ma.stage, ma.peprid, ma.axf_Timestamp from MERREGAPP_MINPOINTS as mp, CVD_MERREGAPP_MINPOINTS_SITETYPE as st, MERREGAPP_MINASSESSMENTS as ma where mp.pttype = st.code and mp.ptid = ma.ptid and mp.ptid = '" + ptID + "' order by ma.axf_timestamp desc;"
End If

Dim ds
Set ds = Map.Layers("MASTER.MERRegApp_MinPoints").DataSource

If ds.IsOpen then
	set selrs =	ds.Execute (sqlStr)
	
	If (Not selrs Is Nothing) Then
		'Console.print "count: " & selrs.RecordCount
		selrs.MoveFirst
		objEvent.Controls("lblName").text = selrs.fields("ptinfo").value			
		objEvent.Controls("lblPtInfo").text = selrs.fields("std").value

		If ptType = "DH" Then	
			objEvent.Controls("lblDrillHoleType").text = selrs.fields("dtd").value	
		Else 
			objEvent.Controls("lblDrillHoleType").visible = false
		End If

		objEvent.Controls("lblDate").text = selrs.fields("axf_timestamp").value	
		objEvent.Controls("lblStatus").text = selrs.fields("stage").value
		objEvent.Controls("lblPeprID").text = selrs.fields("peprid").value	

		If (selrs.RecordCount > 0 ) Then
			objEvent.Controls("lblNoInspections").visible = false
		End If
	Else 
		'Console.print "nope"
	End If
End If


End Sub
