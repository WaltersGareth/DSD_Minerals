<?xml version="1.0" encoding="UTF-8"?>
<ArcPad>
	<LAYER name="Tracks">
		<SYMBOLOGY>
			<SIMPLELABELRENDERER visible="true" field="Name" rotationfield="" expression="" language="">
				<TEXTSYMBOL fontcolor="168,0,0" font="Arial" fontsize="8" horzalignment="center" vertalignment="center" rtl="false" fontstyle="regular">
				</TEXTSYMBOL>
			</SIMPLELABELRENDERER>
			<SIMPLERENDERER>
				<GROUPSYMBOL>
					<COMPLEXLINESYMBOL linetype="marker" color="168,0,0" width="8" pattern="MGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG">
						<MARKERSYMBOL>
							<TRUETYPEMARKERSYMBOL fontcolor="168,0,0" character="62" font="ESRI Arrowhead" fontsize="11.2"/>
						</MARKERSYMBOL>
					</COMPLEXLINESYMBOL>
					<COMPLEXLINESYMBOL color="168,0,0" width="1" pattern="M" decoration="start">
						<DECORATIONSYMBOL positions="1">
							<TRUETYPEMARKERSYMBOL fontcolor="168,0,0" character="33" font="ESRI Default Marker" fontsize="12"/>
						</DECORATIONSYMBOL>
					</COMPLEXLINESYMBOL>
					<COMPLEXLINESYMBOL color="168,0,0" width="1" pattern="M" decoration="end">
						<DECORATIONSYMBOL flipfirst="false" positions="1">
							<TRUETYPEMARKERSYMBOL fontcolor="168,0,0" character="34" font="ESRI Default Marker" fontsize="12"/>
						</DECORATIONSYMBOL>
					</COMPLEXLINESYMBOL>
				</GROUPSYMBOL>
			</SIMPLERENDERER>
		</SYMBOLOGY>
		<FORMS>
			<EDITFORM name="Tracks" caption="Tracks" width="130" height="130" attributespagevisible="false" picturepagevisible="true" symbologypagevisible="true" geographypagevisible="true" required="false">
				<PAGE name="page1" caption="Track Description">
					<LABEL name="lblName" x="1" y="18" width="111" height="12" caption="Name or Description" tooltip="" border="false">
					</LABEL>
					<EDIT name="txtName" x="2" y="28" width="122" height="40" defaultvalue="" tooltip="" tabstop="true" border="true" required="true" field="NAME">
					</EDIT>
					<LABEL name="lblCreated" x="41" y="3" width="29" height="12" caption="Created" tooltip="" border="false">
					</LABEL>
					<DATETIME name="dtpCreated" x="69" y="4" width="60" height="12" defaultvalue="" tooltip="" tabstop="true" border="true" field="Created">
					</DATETIME>
				</PAGE>
			</EDITFORM>
		</FORMS>
		<METADATA/>
		<QUERY where=""/>
	</LAYER>
</ArcPad>
