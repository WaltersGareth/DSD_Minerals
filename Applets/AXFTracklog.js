function addToAxfTracklog(){

if (!Application.UserProperties("prevX")){
	Application.UserProperties("prevX") = GPS.X
	Application.UserProperties("prevY") = GPS.Y

}
else {
	//Console.print (GPS.X + ", " + GPS.Y)
	var r = 6371e3
	var x = (GPS.X - Application.UserProperties("prevX")) + Math.cos(Application.UserProperties("prevY") + GPS.Y);
	//Console.print(x)
	var y = (GPS.Y - Application.UserProperties("prevY"));
	var dm = Math.sqrt(x*x + y*y)
	//Console.print (dm)

	if (dm > 5 ){
	  Application.UserProperties("prevX") = GPS.X;
	  Application.UserProperties("prevY") = GPS.Y;

	  var mapLayerName = Map.Layers("MASTER.MERRegApp_MinTracklogPoint").Name;
	  var ds = Map.Layers("MASTER.MERRegApp_MinTracklogPoint").Datasource;

	  if (ds.IsOpen){
		var sqlFields = "LATITUDE, LONGITUDE, ALTITUDE, EASTING, NORTHING,  UTCTIME, SOG, COG, MAG_VAR, SATS_USED, HPE, VPE, EPE, HDOP, VDOP, PDOP, QUALITY, DIFF_AGE, DIFF_ID, DEPTH, DEPTH_OFF, WATERTEMP, AXF_TIMESTAMP, AXF_STATUS";

		var d = new Date();
		var formattedDate = d.getFullYear() + "-" + ( Number(d.getMonth()) + 1 ) + "-" + d.getDate() + " " + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();


		var sqlValues = GPS.Y + ", " + GPS.X + ", " + 0 + ", " + 0 + ", " + 0 + ", '" + ( d.getHours() + ":" + d.getMinutes() ) + "', " + 0 + ", " + 0 + ", " + 0 + ", " + 0 + ", " + 0 + ", " + 0 + ", " + 0 + ", " + 0 + ", " + 0 + ", " + 0 + ", " + 0 + ", " + 0 + ", " + 0 + ", " + 0 + ", " + 0 + ", " + 0 + ", '" + formattedDate + "', 1";
		//Console.print (sqlValues);
		var sqlString = "INSERT INTO MERREGAPP_MINTRACKLOGPOINT " + "(" + sqlFields + ") VALUES (" + sqlValues + ");";
		//Console.print (sqlString);
		var result = ds.Execute( sqlString );
	  }
	}
}


}
