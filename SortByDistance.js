var tolerance = 5
var prs = Map.EditLayer.Records

prs.MoveFirst();
var sb = Map.SelectionBookmark;
prs.bookmark = sb;
var lon1 = prs.fields.shape.x;
var lat1 = prs.fields.shape.y;
Console.clear();
Console.print (prs.bookmark + ", " + prs.fields("ptType").value + ", " + lon1 + ", " + lat1);

prs.MoveFirst();

var distArray = [];

while ( !prs.EOF ){
 var lon2 = prs.fields.shape.x;
 var lat2 = prs.fields.shape.y;

 if (prs.bookmark !== sb ) {
  var km = getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2);
  if ( km < tolerance ) {
   Console.print (prs.bookmark + ", " + km);
   distArray.push([prs.bookmark, km]);
  }
 }
 prs.MoveNext();
}

Console.print ( distArray.sort( compareSecondColumn ) );

function getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {
  var R = 6371; // Radius of the earth in km
  var dLat = deg2rad(lat2-lat1);  // deg2rad below
  var dLon = deg2rad(lon2-lon1); 
  var a = 
    Math.sin(dLat/2) * Math.sin(dLat/2) +
    Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * 
    Math.sin(dLon/2) * Math.sin(dLon/2)
    ; 
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
  var d = R * c; // Distance in km
 
  return d;
}

function deg2rad(deg) {
  return deg * (Math.PI/180)
}

function compareSecondColumn(a, b) {
    if (a[1] === b[1]) {
        return 0;
    }
    else {
        return (a[1] < b[1]) ? -1 : 1;
    }
}