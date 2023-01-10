﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pViewer.aspx.cs" Inherits="pViewer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <title>CadViewer</title>

    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta name="generator" content="TMS" />
    <meta name="description" content="CADViewer " />

    <link href="../app/css/cvjs-core-styles.css" media="screen" rel="stylesheet" type="text/css" />
    <link href="../app/css/font-awesome.min.css" media="screen" rel="stylesheet" type="text/css" />
    <link href="../app/css/bootstrap-multiselect.css" rel="stylesheet" type="text/css" />
    <link href="../app/css/jquery.qtip.min.css" media="screen" rel="stylesheet" type="text/css" />
    <link href="../app/css/jquery-ui-1.13.2.min.css" media="screen" rel="stylesheet" type="text/css" />

    <link href="../app/css/bootstrap-cadviewer.css" media="screen" rel="stylesheet" type="text/css" />


    <script src="../app/js/jquery-2.2.3.js" type="text/javascript"></script>
    <!-- <script src="../app/js/jquery-3.5.1.js" type="text/javascript"></script> -->
    <script src="../app/js/jquery.qtip.min.js" type="text/javascript"></script>

    <script src="../app/js/popper.js" type="text/javascript"></script>

    <script src="../app/js/bootstrap-cadviewer.js" type="text/javascript"></script>



    <script src="../app/js/jquery-ui-1.13.2.min.js" type="text/javascript"></script>

    <script src="../app/cv/cv-pro/cadviewer.min.js" type="text/javascript"></script>


    <script src="../app/cv/cv-pro/custom_rules_template.js" type="text/javascript"></script>
    <script src="../app/cv/cv-custom_commands/CADViewer_custom_commands.js" type="text/javascript"></script>

    <script src="../app/cv/cvlicense.js" type="text/javascript"></script>


    <script src="../app/js/bootstrap-multiselect.js" type="text/javascript"></script>
    <script src="../app/js/library_js_svg_path.js" type="text/javascript"></script>
    <script src="../app/js/snap.svg-min.js" type="text/javascript"></script>

    <script src="../app/js/cvjs_api_styles_2_0_26.js" type="text/javascript"></script>
    <script src="../app/js/rgbcolor.js" type="text/javascript"></script>
    <script src="../app/js/StackBlur.js" type="text/javascript"></script>
    <script src="../app/js/canvg.js" type="text/javascript"></script>
    <script src="../app/js/list.js" type="text/javascript"></script>
    <script src="../app/js/jscolor.js" type="text/javascript"></script>

    <script src="../app/js/jstree/jstree.min.js"></script>
    <script src="../app/js/xml2json.min.js"></script>
    <script src="../app/js/d3.v3.min.js"></script>
    <script src="../app/js/qrcode.min.js" type="text/javascript"></script>
    
    <script type="text/javascript">


        var ServerUrl = "";
        var ServerBackEndUrl = "";
        
        // PATH and FILE to be loaded, can be in formats DWG, DXF, DWF, SVG , JS, DGN, PCF, JPG, GIF, PNG
        //var FileName = ServerUrl + "/content/drawings/dwg/LI_1077929.dwg";        
        var FileName ="";
        var ServerLocation = "";

        $(document).ready(function () {

            ServerUrl = $('#hiddenServerUrl').val();
            ServerBackEndUrl = ServerUrl;
            FileName = ServerUrl + "content/drawings/dwg/hq17_.dwg";

            cvjs_debugMode(false);
            cvjs_setFileLoadTimeOut("floorPlan", 180);    //
            // Set CADViewer with full CADViewer Pro features
            cvjs_CADViewerPro(true);

            // Pass over the location of the installation, will update the internal paths
            //cvjs_setAllServerURLsLocation(ServerBackEndUrl, ServerUrl, ServerLocation);
            cvjs_setAllServerPaths_and_Handlers(ServerBackEndUrl, ServerUrl, ServerLocation, "dotNet", "JavaScript", "floorPlan");

            // IF CADVIEWER IS OPENED WITH A URL  http://localhost/cadviewer/html/CADViewer_sample_610.html?drawing_name=../content/drawings/dwg/hq17.dwg
            //  or CADViewer_sample_610.html?drawing_name=http://localhost/cadviewer/content/drawings/dwg/hq17.dwg
            //  this code segment will pass over the drawing_name to FileName for load of drawing

            var myDrawing = cvjs_GetURLParameter("drawing_name");
            console.log("DRAWING NAME >" + cvjs_GetURLParameter("drawing_name") + "</end>  ");
            if (myDrawing == "") {
                console.log("no drawing_name parameter!!!");
            }
            else {
                //			console.log("we pass over to FileName to load Drawing");
                FileName = myDrawing;
            }

            var fileUrl = $('#hiddenFileUrl').val();
            if (fileUrl) {
                console.log("fileUrl: ",fileUrl);
                FileName = fileUrl;
            } 

            cvjs_jsonLocation = cvjs_GetURLParameter("json_location");
            console.log("json_location >" + cvjs_GetURLParameter("json_location") + "</end>  ");
            if (cvjs_jsonLocation == "") {
                console.log("no json_location!");
            }
            else {
                //			window.alert("WE GOT JSON "+cvjs_jsonLocation);
                console.log("WE GOT JSON " + cvjs_jsonLocation);
            }

            var print_modal_custom_checkbox = cvjs_GetURLParameter("print_modal_custom_checkbox");
            console.log("print_modal_custom_checkbox >" + cvjs_GetURLParameter("print_modal_custom_checkbox") + "</end>  ");
            if (print_modal_custom_checkbox == "") {
                console.log("no print_modal_custom_checkbox!");
            }
            else {
                //			window.alert("WE GOT print_modal_custom_checkbox "+print_modal_custom_checkbox);
                cvjs_setPrintModalCustomCheckBox(true, print_modal_custom_checkbox);
            }


            // For "Merge DWG" / "Merge PDF" commands, set up the email server to send merged DWG files or merged PDF files with redlines/interactive highlight.
            // See php / xampp documentation on how to prepare your server
            cvjs_emailSettings_PDF_publish("From CAD Server", "my_from_address@mydomain.com", "my_cc_address@mydomain.com", "my_reply_to@mydomain.com");

            // CHANGE LANGUAGE - DEFAULT IS ENGLISH
            cvjs_loadCADViewerLanguage("English", "/app/cv/cv-pro/language_table/cadviewerProLanguage.xml");
            // Available languages:  "English" ; "French, "Korean", "Spanish", "Portuguese", "Portuguese (Brazil)" ;  "Russian" ; "Malay" ;  "Chinese-Simplified"

            // Set Icon Menu Interface controls. Users can:
            // 1: Disable all icon interfaces
            //  cvjs_displayAllInterfaceControls(false, "floorPlan");  // disable all icons for user control of interface
            // 2: Disable either top menu icon menus or navigation menu, or both
            //	cvjs_displayTopMenuIconBar(false, "floorPlan");  // disable top menu icon bar
            //	cvjs_displayTopNavigationBar(false, "floorPlan");  // disable top navigation bar
            // 3: Users can change the number of top menu icon pages and the content of pages, based on a configuration file in folder /cadviewer/app/js/menu_config/


            cvjs_setTopMenuXML("floorPlan", "cadviewer_full_commands_03.xml", "/app/cv/cv-pro/menu_config/");


            // Initialize CADViewer  - needs the div name on the svg element on page that contains CADViewerJS and the location of the
            // main application "app" folder. It can be either absolute or relative

            // THIS IS THE DESIGN OF THE pop-up MODAL WHEN CLICKING ON SPACES
            var my_cvjsPopUpBody = "<div class=\"cvjs_modal_1\" onclick=\"my_own_clickmenu1();\">Custom<br>Hello!<br><i class=\"glyphicon glyphicon-transfer\"></i></div>";
            my_cvjsPopUpBody += "<div class=\"cvjs_modal_1\" onclick=\"my_own_clickmenu2();\">Custom<br>Menu 2<br><i class=\"glyphicon glyphicon-info-sign\"></i></div>";
            my_cvjsPopUpBody += "<div class=\"cvjs_modal_1\" onclick=\"cvjs_zoomHere();\">Zoom<br>Here<br><i class=\"glyphicon glyphicon-zoom-in\"></i></div>";


            // SETTINGS OF THE COLORS OF SPACES
            cvjsRoomPolygonBaseAttributes = {
                fill: '#ffd7f4', //'#D3D3D3',   // #FFF   #ffd7f4
                "fill-opacity": 0.3,    //"0.05",   // 0.1
                stroke: '#CCC',
                'stroke-width': 0.25,
                'stroke-linejoin': 'round',
                "opacity": 0.3
            };

            cvjsRoomPolygonHighlightAttributes = {
                fill: '#a4d7f4',
                "fill-opacity": "0.8",
                stroke: '#a4d7f4',
                'stroke-width': 0.75,
                "opacity": 0.8
            };

            cvjsRoomPolygonSelectAttributes = {
                fill: '#5BBEF6',
                "fill-opacity": "0.8",
                stroke: '#5BBEF6',
                'stroke-width': 0.75,
                "opacity": 0.8
            };


            //      Setting Space Object Modals Display to be based on a callback method - VisualQuery mode -
            cvjs_setCallbackForModalDisplay(true, myCustomPopUpBody, populateMyCustomPopUpBody);


            // Initialize CADViewer - needs the div name on the svg element on page that contains CADViewerJS and the location of the
            // And we intialize with the Space Object Custom values
            cvjs_InitCADViewer_highLight_popUp_app("floorPlan", ServerUrl + "app/", cvjsRoomPolygonBaseAttributes, cvjsRoomPolygonHighlightAttributes, cvjsRoomPolygonSelectAttributes, my_cvjsPopUpBody);

            //		cvjs_InitCADViewer_app("floorPlan", ServerUrl+"app/");
            //		//cvjs_InitCADViewerJS_app("floorPlan", "../app/");

            // set the location to license key, typically the js folder in main app application folder ../app/js/
            cvjs_setLicenseKeyPath(ServerUrl + "app/cv/");
            // alternatively, set the key directly, by pasting in the cvKey portion of the cvlicense.js file, note the JSON \" around all entities
            //cvjs_setLicenseKeyDirect('{ \"cvKey\": \"00110010 00110010 00110000 00110010 00110001 00111001 00111001 00110001 00110100 00111000 00110001 00110100 00110101 00110001 00110101 00110111 00110001 00110101 00111001 00110001 00110100 00111000 00110001 00110101 00110010 00110001 00110100 00110101 00110001 00110100 00110001 00110001 00110100 00110000 00110001 00111001 00110111 00110010 00110000 00110111 00110010 00110000 00110110 00110010 00110000 00110001 00110010 00110001 00110000 00110010 00110000 00111000 00110010 00110001 00110000 00110010 00110000 00111000 00110010 00110001 00110000 00110010 00110000 00110111 00110001 00111001 00111000 00110010 00110000 00110110 00110010 00110000 00111000 00110010 00110000 00110111 00110001 00111001 00111001 00110010 00110001 00110001 00110010 00110000 00111000 00110010 00110000 00110111 00110010 00110001 00110001 00110010 00110000 00110101 00110010 00110000 00111000 \" }');

            cvjs_allowFileLoadToServer(true);

            //		cvjs_setUrl_singleDoubleClick(1);
            //		cvjs_encapsulateUrl_callback(true);

            // NOTE BELOW: THESE SETTINGS ARE FOR SERVER CONTROLS FOR UPLOAD OF REDLINES
            cvjs_setRedlinesAbsolutePath(ServerUrl + '/content/redlines/fileloader_670/', ServerLocation + '/content/redlines/fileloader_670/');
            // NOTE ABOVE: THESE SETTINGS ARE FOR SERVER CONTROLS FOR UPLOAD OF REDLINES


            // NOTE BELOW: THESE SETTINGS ARE FOR SERVER CONTROLS FOR UPLOAD OF FILES AND FILE MANAGER
            cvjs_setServerFileLocation_AbsolutePaths(ServerLocation + '/content/drawings/dwg/', ServerUrl + 'content/drawings/dwg/', "", "");
            // NOTE ABOVE: THESE SETTINGS ARE FOR SERVER CONTROLS FOR UPLOAD OF FILES AND FILE MANAGER


            // NOTE BELOW: THESE SETTINGS ARE FOR SERVER CONTROLS OF SPACE OBJECTS
            // Set the path to folder location of Space Objects
            cvjs_setSpaceObjectsAbsolutePath(ServerUrl + '/content/spaceObjects/', ServerLocation + '/content/spaceObjects/');
            // NOTE ABOVE: THESE SETTINGS ARE FOR SERVER CONTROLS OF SPACE OBJECTS


            cvjs_setInsertImageObjectsAbsolutePath(ServerUrl + 'content/inserted_image_objects/', ServerLocation + '/content/inserted_image_objects/');

            // NOTE BELOW: THESE SETTINGS ARE FOR SERVER CONTROLS FOR CONVERTING DWG, DXF, DWF files
            cvjs_conversion_clearAXconversionParameters();

            // window.alert("HERE");

            var dgn_workspace = cvjs_GetURLParameter("dgn_workspace");
            console.log("dgn_workspace >" + cvjs_GetURLParameter("dgn_workspace") + "</end>  ");
            if (dgn_workspace == "") {
                console.log("no dgn_workspace parameter!!!");
            }
            else {
                //			window.alert("WE GOT workspace"+dgn_workspace);
                console.log("WE GOT workspace" + dgn_workspace);
                cvjs_setDgnWorkSpace(dgn_workspace, "");
            }

            //		cvjs_conversion_addAXconversionParameter("model", "");
            cvjs_conversion_addAXconversionParameter("last", "");
            //		cvjs_conversion_addAXconversionParameter("extents", "");

            cvjs_conversion_addAXconversionParameter("rl", "RM_");
            cvjs_conversion_addAXconversionParameter("tl", "RM_TXT");
            cvjs_conversion_addAXconversionParameter("la", "");

            //     cvjs_conversion_addAXconversionParameter("RL", "EC1 Space Polygons");
            //     cvjs_conversion_addAXconversionParameter("TL", "EC1 Space Numbers");
            //cvjs_conversion_addAXconversionParameter("PARTOFF", "WA-EXT;WA");
            // cvjs_conversion_addAXconversionParameter("LOFF", "WA-EXT;WA");
            //cvjs_conversion_addAXconversionParameter("LON", "PL;RM_TXT;WA-EXT");
            //cvjs_conversion_addAXconversionParameter("LON", "dummy");
            //        cvjs_conversion_addAXconversionParameter("rl", "RM$");
            //		cvjs_conversion_addAXconversionParameter("tl", "RM$TXT");

            cvjs_conversion_addAXconversionParameter("fpath", ServerLocation + "/converters/ax2020/windows/fonts");
            // NOTE ABOVE: THESE SETTINGS ARE FOR SERVER CONTROLS FOR CONVERTING DWG, DXF, DWF files
            // Load file - needs the svg div name and name and path of file to load

            cvjs_LoadDrawing("floorPlan", FileName);

            // set maximum CADViewer canvas side
            cvjs_resizeWindow_position("floorPlan");
            // alternatively set a fixed CADViewer canvas size
            //	cvjs_resizeWindow_fixedSize(800, 600, "floorPlan");

            // NOTE
            // we initialize the space icon size to 100%
            cvjs_setGlobalSpaceImageObjectScaleFactor(1.0);

            // here we clone icons to be able to move them into the canvas

            $("#device_drag").clone().appendTo("#myImagesToDrag").prop('id', 'device_drag_clone').css('position', 'absolute').css('width', '50px').hide();
            $("#wifi_drag").clone().appendTo("#myImagesToDrag").prop('id', 'wifi_drag_clone').css('position', 'absolute').css('width', '50px').hide();
            $("#pin_drag").clone().appendTo("#myImagesToDrag").prop('id', 'pin_drag_clone').css('position', 'absolute').css('width', '50px').hide();
            $("#aircon_drag").clone().appendTo("#myImagesToDrag").prop('id', 'aircon_drag_clone').css('position', 'absolute').css('width', '50px').hide();
            $("#boiler_drag").clone().appendTo("#myImagesToDrag").prop('id', 'boiler_drag_clone').css('position', 'absolute').css('width', '50px').hide();
            $("#vent_drag").clone().appendTo("#myImagesToDrag").prop('id', 'vent_drag_clone').css('position', 'absolute').css('width', '50px').hide();
            $("#temp_drag").clone().appendTo("#myImagesToDrag").prop('id', 'temp_drag_clone').css('position', 'absolute').css('width', '50px').hide();
            $("#assembly_drag").clone().appendTo("#myImagesToDrag").prop('id', 'assembly_drag_clone').css('position', 'absolute').css('width', '50px').hide();
            $("#danger_drag").clone().appendTo("#myImagesToDrag").prop('id', 'danger_drag_clone').css('position', 'absolute').css('width', '50px').hide();
            $("#fire_alarm_drag").clone().appendTo("#myImagesToDrag").prop('id', 'fire_alarm_drag_clone').css('position', 'absolute').css('width', '50px').hide();
            $("#fire_exit_drag").clone().appendTo("#myImagesToDrag").prop('id', 'fire_exit_drag_clone').css('position', 'absolute').css('width', '50px').hide();
            $("#fire_extinguisher_drag").clone().appendTo("#myImagesToDrag").prop('id', 'fire_extinguisher_drag_clone').css('position', 'absolute').css('width', '50px').hide();
            $("#refuge_point_drag").clone().appendTo("#myImagesToDrag").prop('id', 'refuge_point_drag_clone').css('position', 'absolute').css('width', '50px').hide();

            $("#myImagesToDrag").mousemove(function (event) {
                //console.log(insertImageSelected);
                //console.log(event.pageX+"  "+event.pageY);
                handleDragImages(event);
            });

            $("#space_icon_table2").mousemove(function (event) {
                // console.log(insertImageSelected);
                // console.log(event.pageX+"  "+event.pageY);
                handleDragImages(event);
            });



            $("#space_icon_table2").mouseover(function (event) {

            });


            $("#space_icon_table2").mouseup(function (event) {

                console.log("hello " + insertImageSelected);
                console.log(event.pageX + "  " + event.pageY);

                if (insertImageSelected == 0) {
                    lastXbeforeDrag = event.pageX;
                    lastYbeforeDrag = event.pageY;
                }

                if (lastYbeforeDrag > device_from_top_base && lastYbeforeDrag < (device_from_top_base + height * 1)) {
                    insertImageSelected = 1;
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 1) && lastYbeforeDrag < (device_from_top_base + height * 2)) {
                    insertImageSelected = 2;
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 2) && lastYbeforeDrag < (device_from_top_base + height * 3)) {
                    insertImageSelected = 3;
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 3) && lastYbeforeDrag < (device_from_top_base + height * 4)) {
                    insertImageSelected = 4;
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 4) && lastYbeforeDrag < (device_from_top_base + height * 5)) {
                    insertImageSelected = 5;
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 5) && lastYbeforeDrag < (device_from_top_base + height * 6)) {
                    insertImageSelected = 6;
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 6) && lastYbeforeDrag < (device_from_top_base + height * 7)) {
                    insertImageSelected = 7;
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 7) && lastYbeforeDrag < (device_from_top_base + height * 8)) {
                    insertImageSelected = 8;
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 8) && lastYbeforeDrag < (device_from_top_base + height * 9)) {
                    insertImageSelected = 9;
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 9) && lastYbeforeDrag < (device_from_top_base + height * 10)) {
                    insertImageSelected = 10;
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 10) && lastYbeforeDrag < (device_from_top_base + height * 11)) {
                    insertImageSelected = 11;
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 11) && lastYbeforeDrag < (device_from_top_base + height * 12)) {
                    insertImageSelected = 12;
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 12) && lastYbeforeDrag < (device_from_top_base + height * 13)) {
                    insertImageSelected = 13;
                }

                handleDragImages(event);
            });


            $("#myImagesToDrag").mouseleave(function (event) {

                if (insertImageSelected == 1) {
                    $("#device_drag_clone").hide();
                }
                if (insertImageSelected == 2) {
                    $("#wifi_drag_clone").hide();
                }
                if (insertImageSelected == 3) {
                    $("#pin_drag_clone").hide();
                }
                if (insertImageSelected == 4) {
                    $("#aircon_drag_clone").hide();
                }
                if (insertImageSelected == 5) {
                    $("#boiler_drag_clone").hide();
                }
                if (insertImageSelected == 6) {
                    $("#vent_drag_clone").hide();
                }
                if (insertImageSelected == 7) {
                    $("#temp_drag_clone").hide();
                }
                if (insertImageSelected == 8) {
                    $("#assembly_drag_clone").hide();
                }
                if (insertImageSelected == 9) {
                    $("#danger_drag_clone").hide();
                }
                if (insertImageSelected == 10) {
                    $("#fire_alarm_drag_clone").hide();
                }
                if (insertImageSelected == 11) {
                    $("#fire_exit_drag_clone").hide();
                }
                if (insertImageSelected == 12) {
                    $("#fire_extinguisher_drag_clone").hide();
                }
                if (insertImageSelected == 13) {
                    $("#refuge_point_drag_clone").hide();
                }


                $('#icon_div_popup').hide();
                console.log("out...." + insertImageSelected);
                insertImageSelected = 0;
            });


            $('.topIconMenu_placeholder_1').css({ 'top': '0px','left':'150px' });


        });  // end ready()



        $(window).resize(function () {
            // set maximum CADViewer canvas side
            cvjs_resizeWindow_position("floorPlan");
            // alternatively set a fixed CADViewer canvas size
            //	cvjs_resizeWindow_fixedSize(800, 600, "floorPlan");
        });

        /// NOTE: THESE METHODS BELOW ARE JS SCRIPT CALLBACK METHODS FROM CADVIEWER JS, THEY NEED TO BE IMPLEMENTED BUT CAN BE EMPTY

        function cvjs_OnLoadEnd() {
            // generic callback method, called when the drawing is loaded
            // here you fill in your stuff, call DB, set up arrays, etc..
            // this method MUST be retained as a dummy method! - if not implemeted -
            console.log('cvjs_OnLoadEnd');
            cvjs_resetZoomPan("floorPlan");

            var user_name = "Bob Smith";
            var user_id = "user_1";

            // set a value for redlines
            //cvjs_setCurrentStickyNoteValues_NameUserId(user_name, user_id);
            //cvjs_setCurrentRedlineValues_NameUserid(user_name, user_id);

            cvjs_dragBackgroundToFront_SVG("floorPlan");
            //cvjs_initZeroWidthHandling("floorPlan", 1.0);

            roomLayer1 = cvjs_clearLayer(roomLayer1);

            cvjs_LayerOff("EC1 Space Names");
            cvjs_LayerOff("EC1 Space Status Descs");
            cvjs_LayerOff("EC1 Space Project");
            cvjs_LayerOff("EC1 Space Function Descs");
            cvjs_LayerOff("EC1 Space Type Descs");
            cvjs_LayerOff("EC1 Tenant Names");
            cvjs_LayerOff("EC1 UDA Design Capacity");
            cvjs_LayerOff("EC1 UDA Is Secured");

            var slider = document.getElementById("myRange");
            var output = document.getElementById("iconsize");
            output.innerHTML = slider.value + "%";

            slider.oninput = function () {
                output.innerHTML = this.value + "%";
                // SETTTING THE CADVIEWER GLOBAL CONTROLS:
                cvjs_setGlobalSpaceImageObjectScaleFactor(this.value / 100.0);

            }
            
            //$('.topIconMenu_placeholder_1').css({'top':'0px'});

            cvjs_setServerSaveHandlerRedlines("SaveRedlinesHandler.ashx");	// name of server side save-file controller document
            cvjs_setServerLoadHandlerRedlines("LoadRedlinesHandler.ashx"); // name of server side append-file controller document


            if ($('#HiddenHasJsonFile').val())  fnRedLineLoad();
            
        }

        


        function cvjs_EmailSentStatus(html) {
            window.alert("Callback from email process: " + html);
        }


        function cvjs_OnLoadEndRedlines() {
            // generic callback method, called when the redline is loaded
            // here you fill in your stuff, hide specific users and lock specific users
            // this method MUST be retained as a dummy method! - if not implemeted -

            console.log('cvjs_OnLoadEndRedlines');

            // I am hiding users added to the hide user list
            cvjs_hideAllRedlines_HiddenUsersList();

            // I am freezing users added to the lock user list
            cvjs_lockAllRedlines_LockedUsersList();
        }


        // generic callback method, tells which FM object has been clicked
        function cvjs_change_space() {

        }

        function cvjs_graphicalObjectCreated(graphicalObject) {

            // do something with the graphics object created!
            //		window.alert(graphicalObject);

        }


        function cvjs_popupTitleClick(myclick) {

            window.alert(" cvjs_popupTitleClick: " + myclick);

        }

        function cvjs_ObjectSelected(rmid) {
            // placeholder for method in tms_cadviewerjs_modal_1_0_14.js   - must be removed when in creation mode and using creation modal
        }


        // Callback Method on Creation and Delete
        function cvjs_graphicalObjectOnChange(type, graphicalObject, spaceID) {
            // do something with the graphics object created!

            var myobject2 = cvjs_returnSpaceObjectID(spaceID);

            console.log(" cvjs_graphicalObjectOnChange: " + type + " " + graphicalObject + " " + spaceID, myobject2);


            if (type == 'Create' && graphicalObject.toLowerCase().indexOf("space") > -1 && graphicalObject.toLowerCase().indexOf("circle") == -1) {

                /*
                * Return a JSON structure of all content of a space object clicked: <br>
                * 	var jsonStructure =  	{	"path":   path, <br>
                *								"tags": tags, <br>
                *								"node": node, <br>
                *								"area": area, <br>
                *								"outerhtml": outerHTML, <br>
                *								"occupancy": occupancy, <br>
                *								"name": name, <br>
                *								"type": type, <br>
                *								"id": id, <br>
                *								"defaultcolor": defaultcolor, <br>
                *								"layer": layer, <br>
                *								"group": group, <br>
                *								"linked": linked, <br>
                *								"attributes": attributes, <br>
                *								"attributeStatus": attributeStatus, <br>
                *								"displaySpaceObjects": displaySpaceObjects, <br>
                *								"translate_x": translate_x, <br>
                *								"translate_y": translate_y, <br>
                *								"scale_x": scale_x ,<br>
                *								"scale_y": scale_y ,<br>
                *								"rotate": rotate, <br>
                *								"transform": transform} <br>
                * @return {Object} jsonSpaceObject - Object with the entire space objects content
                */

                myobject = cvjs_returnSpaceObjectID(spaceID);

                // I can save this object into my database, and then use command
                // cvjs_setSpaceObjectDirect(jsonSpaceObject)
                // when I am recreating the content of the drawing at load

                // for the fun of it, display the SVG geometry of the space:
                console.log("This is the SVG path: " + myobject.path)

            }


            if (type == 'Delete' && graphicalObject.toLowerCase().indexOf("space") > -1) {
                // remove this entry from my DB

                window.alert("We have deleted: " + spaceID)
            }


            if (type == 'Move' && graphicalObject.toLowerCase().indexOf("space") > -1) {
                // remove this entry from my DB

                console.log("This object has been moved: " + spaceID)
                myobject = cvjs_returnSpaceObjectID(spaceID);

            }
        }



        function myCustomPopUpBody(rmid) {

            console.log("click on myCustomPopUpBody: " + rmid + " I now change the pop-up menu");
            // make your own popup based on callback
            var my_cvjsPopUpBody = "";

            if (rmid == 120 || rmid == 121 || rmid == 122 || rmid == 123 || rmid == 124) {
                my_cvjsPopUpBody = "<div class=\"cvjs_modal_1\" onclick=\"my_own_clickmenu1();\">Custom<br>Menu One<br><i class=\"glyphicon glyphicon-transfer\"></i></div>";
                my_cvjsPopUpBody += "<div class=\"cvjs_modal_1\" onclick=\"cvjs_zoomHere();\">Zoom<br>Here<br><i class=\"glyphicon glyphicon-zoom-in\"></i></div>";

            } else {
                my_cvjsPopUpBody = "<div class=\"cvjs_modal_1\" onclick=\"my_own_clickmenu1();\">Custom<br>Menu 1<br><i class=\"glyphicon glyphicon-transfer\"></i></div>";
                my_cvjsPopUpBody += "<div class=\"cvjs_modal_1\" onclick=\"my_own_clickmenu2();\">Custom<br>Menu 2<br><i class=\"glyphicon glyphicon-info-sign\"></i></div>";
                my_cvjsPopUpBody += "<div class=\"cvjs_modal_1\" onclick=\"cvjs_zoomHere();\">Zoom<br>Here<br><i class=\"glyphicon glyphicon-zoom-in\"></i></div>";

            }
            return my_cvjsPopUpBody;
        }


        function cvjs_callbackForModalDisplay(rmid, node) {

            console.log("cvjs_callbackForModalDisplay: used to populate and update the modal: " + rmid, node);
            // populateMyCustomPopUpBody(rmid, node);
        }

        function populateMyCustomPopUpBody(rmid, node) {

            console.log(" we actually have a second callback to change the pop-up menu (developed originally for Angular2) populateMyCustomPopUpBody: " + rmid + "  " + node);

        }



        /// NOTE: THESE METHODS ABOVE ARE JS SCRIPT CALLBACK METHODS FROM CADVIEWER JS, THEY NEED TO BE IMPLEMENTED BUT CAN BE EMPTY
        /// NOTE: BELOW REDLINE SAVE LOAD CONTROLLERS
        // This method is linked to the save redline icon in the imagemap
        function cvjs_saveStickyNotesRedlinesUser() {

            // there are two modes, user handling of redlines
            // alternatively use the build in redline file manager
            //cvjs_openRedlineSaveModal("floorPlan");

            // custom method fnSetupSaveAndLoad to set the name and location of redline to save
            // see implementation below
            fnSetupSaveAndLoad();
            console.log('cvjs_saveStickyNotesRedlinesUser');
            // API call to save stickynotes and redlines
            cvjs_saveStickyNotesRedlines("floorPlan");
        }


        // This method is linked to the load redline icon in the imagemap
        function cvjs_loadStickyNotesRedlinesUser() {

            //cvjs_openRedlineLoadModal("floorPlan");

            // first the drawing needs to be cleared of stickynotes and redlines
            //cvjs_deleteAllStickyNotes();
            //cvjs_deleteAllRedlines();

            // custom method fnSetupSaveAndLoad to set the name and location of redline to load
            // see implementation below
            fnSetupSaveAndLoad();

            // API call to load stickynotes and redlines
            console.log('cvjs_loadStickyNotesRedlinesUser');
            //cvjs_setStickyNoteRedlineUrl(ServerUrl + "content/redlines/fileloader_670/redline-test1.js");
            
            cvjs_loadStickyNotesRedlines("floorPlan");
        }

        /// NOTE: ABOVE REDLINE SAVE LOAD CONTROLLERS




        // Here we are writing a basic function that will be used in the PopUpMenu
        // this is template on all the good stuff users can add
        function my_own_clickmenu1() {
            var id = cvjs_idObjectClicked();
            //		var node = cvjs_NodeObjectClicked();
            window.alert("Custom menu item 1: object ID is: " + id);
        }

        // Here we are writing a basic function that will be used in the PopUpMenu
        // this is template on all the good stuff users can add
        function my_own_clickmenu2() {
            var id = cvjs_idObjectClicked();
            //var node = cvjs_NodeObjectClicked();
            window.alert("Custom menu item 2: object ID is: " + id);
            //window.alert("Custom menu item 2: Clicked object Node is: "+node);
        }




        /// NOTE: BELOW CUSTOM MODAL COMMANDS

        // General settings method for Space Images, must be declared!!!!!
        function cvjs_loadSpaceImage_UserConfiguration(floorplan_div) {

            // When inserting a Space Image Object.
            // The following items must be defined:

            // location and name of SVG or bitmap file to insert
            // cvjs_loadSpaceImage_Location
            // ID of the Space for API access
            // cvjs_loadSpaceImage_ID
            // Type of the Space for modal highlight
            // cvjs_loadSpaceImage_Type
            console.log('cvjs_loadSpaceImage_UserConfiguration ServerUrl:', ServerUrl)
            cvjs_loadSpaceImage_Location = ServerUrl + "content/drawings/svg/" + $('#image_sensor_location').val();
            cvjs_loadSpaceImage_ID = $('#image_ID').val();
            cvjs_loadSpaceImage_Type = $('#image_Type').val();
            cvjs_loadSpaceImage_Layer = "cvjs_SpaceLayer";

        }

        var roomLayer1;

        function highlight_space_object() {

            roomLayer1 = cvjs_clearLayer(roomLayer1);
            cvjs_highlightSpaceObjectIdDiv($('#sensor_to_highlight').val(), highlight_colorgrade_D_1, roomLayer1, "floorPlan");

        }

        function clear_space_highlight() {

            cvjs_clearSpaceLayer();
            roomLayer1 = cvjs_clearLayer(roomLayer1);
        }


        function highlight_all_spaces() {

            var secondcolor = selectedColor.substring(0, 5);
            secondcolor += "FF";
            // window.alert(secondcolor);

            var colortype = {
                fill: selectedColor,
                "fill-opacity": "0.8",
                stroke: selectedColor,
                'stroke-width': 1,
                'stroke-opacity': "1",
                'stroke-linejoin': 'round'
            };

            var spaceObjectIds = cvjs_getSpaceObjectIdList();
            for (spc in spaceObjectIds) {
                var rmid = spaceObjectIds[spc];
                cvjs_highlightSpace(rmid, colortype);
            }

        }


        function highlight_all_borders() {
            var colortype = {
                fill: '#fff',
                "fill-opacity": 0.01,
                stroke: selectedColor,
                'stroke-width': 3.0,
                'stroke-opacity': 1,
                'stroke-linejoin': 'round'
            };

            var spaceObjectIds = cvjs_getSpaceObjectIdList();
            for (spc in spaceObjectIds) {

                var rmid = spaceObjectIds[spc];
                cvjs_highlightSpace(rmid, colortype);
            }
        }

        function highlight_space_type() {
            var type = $('#image_Type').val();
            var colortype = {
                fill: selectedColor,
                "fill-opacity": "0.8",
                stroke: '#fe50d9',
                'stroke-width': 1,
                'stroke-opacity': "1",
                'stroke-linejoin': 'round'
            };

            var spaceObjectIds = cvjs_getSpaceObjectIdList();
            for (spc in spaceObjectIds) {
                var spaceType = cvjs_getSpaceObjectTypefromId(spaceObjectIds[spc]);
                var vqid = spaceObjectIds[spc];
                console.log(spc + "  " + vqid + "  " + spaceType + "  " + spaceType.indexOf("Device"));
                if (spaceType.indexOf(type) == 0)
                    cvjs_highlightSpace(vqid, colortype);
            }
        }

        function highlight_space_id() {
            var spaceid = $('#image_ID').val();
            var colortype = {
                fill: selectedColor,
                "fill-opacity": "0.8",
                stroke: selectedColor,
                'stroke-width': 1,
                'stroke-opacity': "1",
                'stroke-linejoin': 'round'
            };

            var spaceObjectIds = cvjs_getSpaceObjectIdList();
            for (spc in spaceObjectIds) {
                console.log(spaceid + "  " + spaceObjectIds[spc] + " " + (spaceid.indexOf(spaceObjectIds[spc]) == 0) + " " + ((spaceid.length == spaceObjectIds[spc].length)));
                if (spaceid.indexOf(spaceObjectIds[spc]) == 0 && (spaceid.length == spaceObjectIds[spc].length))
                    cvjs_highlightSpace(spaceObjectIds[spc], colortype);
            }
        }



        function insert_space_icon() {

            cvjs_loadSpaceImage_Location = ServerUrl + "content/drawings/svg/" + $('#image_sensor_location').val();
            cvjs_loadSpaceImage_ID = $('#image_ID').val();
            cvjs_loadSpaceImage_Type = $('#image_Type').val();
            cvjs_loadSpaceImage_Layer = "cvjs_SpaceLayer";

            //window.alert(cvjs_loadSpaceImage_ID);

            $('#sensor_to_highlight').val(cvjs_loadSpaceImage_ID)
            cvjs_addFixedSizeImageSpaceObject("floorPlan");
            iconObjectCounter++;
            currentDiv(slideIndex)
        }


        var iconObjectCounter = 1;

        // Functions to drag elements
        var lastXbeforeDrag = 0;
        var lastYbeforeDrag = 0;

        // locations of leftside device menu
        var device_from_top_base = 200;
        var height = 52;


        function handleDragImages(event) {

            // handle move

            lastXbeforeDrag = event.pageX;
            lastYbeforeDrag = event.pageY;


            if (insertImageSelected == 0) {  // nothing selected , we show a popup

                if (lastYbeforeDrag > device_from_top_base && lastYbeforeDrag < (device_from_top_base + height * 1)) {
                    $('#icon_div_popup').html("Device");
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 1) && lastYbeforeDrag < (device_from_top_base + height * 2)) {
                    $('#icon_div_popup').html("WiFi");
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 2) && lastYbeforeDrag < (device_from_top_base + height * 3)) {
                    $('#icon_div_popup').html("Marker");
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 3) && lastYbeforeDrag < (device_from_top_base + height * 4)) {
                    $('#icon_div_popup').html("Aircon");
                }

                if (lastYbeforeDrag > (device_from_top_base + height * 4) && lastYbeforeDrag < (device_from_top_base + height * 5)) {
                    $('#icon_div_popup').html("Boiler");
                }

                if (lastYbeforeDrag > (device_from_top_base + height * 5) && lastYbeforeDrag < (device_from_top_base + height * 6)) {
                    $('#icon_div_popup').html("Vent");
                }

                if (lastYbeforeDrag > (device_from_top_base + height * 6) && lastYbeforeDrag < (device_from_top_base + height * 7)) {
                    $('#icon_div_popup').html("Heater");
                }

                if (lastYbeforeDrag > (device_from_top_base + height * 7) && lastYbeforeDrag < (device_from_top_base + height * 8)) {
                    $('#icon_div_popup').html("Assembly Point");
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 8) && lastYbeforeDrag < (device_from_top_base + height * 9)) {
                    $('#icon_div_popup').html("Danger");
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 9) && lastYbeforeDrag < (device_from_top_base + height * 10)) {
                    $('#icon_div_popup').html("Alarm");
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 10) && lastYbeforeDrag < (device_from_top_base + height * 11)) {
                    $('#icon_div_popup').html("Exit");
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 11) && lastYbeforeDrag < (device_from_top_base + height * 12)) {
                    $('#icon_div_popup').html("Fire Extinguisher");
                }
                if (lastYbeforeDrag > (device_from_top_base + height * 12) && lastYbeforeDrag < (device_from_top_base + height * 13)) {
                    $('#icon_div_popup').html("Meet");
                }

                $('#icon_div_popup').css({                    
                    top: event.pageY - 20,
                    "z-index": 1000
                });

                $('#icon_div_popup').show();

            }
            else {
                $('#icon_div_popup').hide();
            }

            //console.log("1b " + lastXbeforeDrag + " " + lastYbeforeDrag + "  " + event.pageX + "  " + event.pageY);

            if (insertImageSelected == 1) {
                $("#device_drag_clone").css({ "left": (event.pageX + 4), "top": (event.pageY - device_from_top_base + 20) }).css({ 'z-index': 1000 }).css({ 'border': '1px solid black' }).show();
            }
            if (insertImageSelected == 2) {
                $("#wifi_drag_clone").css({ "left": (event.pageX + 4), "top": (event.pageY - device_from_top_base + 20) }).css({ 'z-index': 1000 }).css({ 'border': '1px solid black' }).show();
            }
            if (insertImageSelected == 3) {
                $("#pin_drag_clone").css({ "left": (event.pageX + 4), "top": (event.pageY - device_from_top_base + 20) }).css({ 'z-index': 1000 }).css({ 'border': '1px solid black' }).show();
            }
            if (insertImageSelected == 4) {
                $("#aircon_drag_clone").css({ "left": (event.pageX + 4), "top": (event.pageY - device_from_top_base + 20) }).css({ 'z-index': 1000 }).css({ 'border': '1px solid black' }).show();
            }
            if (insertImageSelected == 5) {
                $("#boiler_drag_clone").css({ "left": (event.pageX + 4), "top": (event.pageY - device_from_top_base + 20) }).css({ 'z-index': 1000 }).css({ 'border': '1px solid black' }).show();
            }
            if (insertImageSelected == 6) {
                $("#vent_drag_clone").css({ "left": (event.pageX + 4), "top": (event.pageY - device_from_top_base + 20) }).css({ 'z-index': 1000 }).css({ 'border': '1px solid black' }).show();
            }
            if (insertImageSelected == 7) {
                $("#temp_drag_clone").css({ "left": (event.pageX + 4), "top": (event.pageY - device_from_top_base + 20) }).css({ 'z-index': 1000 }).css({ 'border': '1px solid black' }).show();
            }
            if (insertImageSelected == 8) {
                $("#assembly_drag_clone").css({ "left": (event.pageX + 4), "top": (event.pageY - device_from_top_base + 20) }).css({ 'z-index': 1000 }).css({ 'border': '1px solid black' }).show();
            }
            if (insertImageSelected == 9) {
                $("#danger_drag_clone").css({ "left": (event.pageX + 4), "top": (event.pageY - device_from_top_base + 20) }).css({ 'z-index': 1000 }).css({ 'border': '1px solid black' }).show();
            }
            if (insertImageSelected == 10) {
                $("#fire_alarm_drag_clone").css({ "left": (event.pageX + 4), "top": (event.pageY - device_from_top_base + 20) }).css({ 'z-index': 1000 }).css({ 'border': '1px solid black' }).show();
            }
            if (insertImageSelected == 11) {
                $("#fire_exit_drag_clone").css({ "left": (event.pageX + 4), "top": (event.pageY - device_from_top_base + 20) }).css({ 'z-index': 1000 }).css({ 'border': '1px solid black' }).show();
            }
            if (insertImageSelected == 12) {
                $("#fire_extinguisher_drag_clone").css({ "left": (event.pageX + 4), "top": (event.pageY - device_from_top_base + 20) }).css({ 'z-index': 1000 }).css({ 'border': '1px solid black' }).show();
            }
            if (insertImageSelected == 13) {
                $("#refuge_point_drag_clone").css({ "left": (event.pageX + 4), "top": (event.pageY - device_from_top_base + 20) }).css({ 'z-index': 1000 }).css({ 'border': '1px solid black' }).show();
            }


        }

        var selectedColor = '#AAAA00';

        function custom_ColorHex(pickcolor) {

            selectedColor = "#" + pickcolor;
            console.log("selectedColor" + selectedColor);

        }

        ///  HERE ARE ALL THE CUSTOM TEMPLATES TO DO STUFF ON THE CANVAS

        /**
         * Template start drag method for custom canvas
         */

        var generic_start_method_01 = function () {
            console.log("generic_start_method_01");
        }

        /**
         * Template move drag method for custom canvas
         */
        var generic_move_method_01 = function (dx, dy, x, y) {

            var svg_x = cvjs_SVG_x(x);
            var svg_y = cvjs_SVG_y(y);
            console.log("generic_move_method_01: dx=" + dx + " dy=" + dy + " x=" + x + " y=" + y + " svg_x=" + svg_x + "  svg_y=" + svg_y);
        }

        /**
         * Template stop drag method for custom canvas
         */
        var generic_stop_method_01 = function () {

            cvjs_removeCustomCanvasMethod();
            console.log("REMOVE: generic_stop_method_01");
        };

        /**
         * Template mouse-move method for custom canvas
         */

        var generic_mousemove_method_01 = function (e, x, y) {

            var svg_x = cvjs_SVG_x(x);
            var svg_y = cvjs_SVG_y(y);

            //cvjs_removeCustomCanvasMethod();
            console.log("generic_mousemove_method_01: x=" + x + " y=" + y + " svg_x=" + svg_x + "  svg_y=" + svg_y);
        }

        /**
         * Template mouse-down method for custom canvas
         */

        var generic_mousedown_method_01 = function (e, x, y) {

            var svg_x = cvjs_SVG_x(x);
            var svg_y = cvjs_SVG_y(y);

            //cvjs_removeCustomCanvasMethod();
            console.log("generic_mousedown_method_01: x=" + x + " y=" + y + " svg_x=" + svg_x + "  svg_y=" + svg_y);

        };

        /**
         * Template mouse-up method for custom canvas
         */

        var generic_mouseup_method_01 = function (e, x, y) {

            var svg_x = cvjs_SVG_x(x);
            var svg_y = cvjs_SVG_y(y);

            console.log("generic_mouseup_method_01: x=" + x + " y=" + y + " svg_x=" + svg_x + "  svg_y=" + svg_y);

        };

        /**
         * Template double-click method for custom canvas
         */

        var generic_dblclick_method_01 = function (e, x, y) {
            cvjs_removeCustomCanvasMethod();

            var svg_x = cvjs_SVG_x(x);
            var svg_y = cvjs_SVG_y(y);
            console.log("REMOVE: generic_dblclick_method_01: x=" + x + " y=" + y + " svg_x=" + svg_x + "  svg_y=" + svg_y);
        };


        // SAMPLE TO CREATE RECTANGLE BY CLICK

        var generic_canvas_flag_first_click_rectangle = false;
        var generic_canvas_flag_rectangle = false;

        var generic_make_rect_init_method = function () {
            console.log("generic_make_rect_init_method");
            generic_canvas_flag_first_click_rectangle = false;
            generic_canvas_flag_rectangle = false;
        }


        var generic_make_rect_mousedown_method = function (e, x, y) {

            try {
                console.log("generic_make_rect_mousedown_method");

                if (!generic_canvas_flag_first_click_rectangle) {
                    var tPath_r = "M" + 0 + "," + 0;
                    cvjs_RubberBand = cvjs_makeGraphicsObjectOnCanvas('Path', tPath_r).attr({ stroke: "#b00000", fill: "none" });
                    generic_canvas_flag_first_click_rectangle = true;
                    generic_canvas_flag_rectangle = false;
                    console.log("rubberband");
                }
                else {
                    console.log(generic_canvas_flag_first_click_rectangle + "  " + generic_canvas_flag_rectangle);
                    if (generic_canvas_flag_rectangle) {
                        generic_make_rect_stop_method();
                    }
                }
            }
            catch (err) { console.log(err) }
            //console.log("mouse down ");
        }


        var generic_make_rect_mouseup_method = function () {

            try {
                console.log("generic_make_rect_mouseup_method");
            }
            catch (err) { console.log(err) }
        }


        var generic_make_rect_dblclick_method = function () {

            try {
                console.log("generic_make_rect_dblclick_method");
            }
            catch (err) { console.log(err) }
        }


        var generic_make_rect_mousemove_method = function (e, x, y) {

            try {
                if (generic_canvas_flag_first_click_rectangle) {
                    cvjs_customCanvasMethod_globalScale();
                    if (!generic_canvas_flag_rectangle) {
                        cvjs_firstX = cvjs_SVG_x(x);
                        cvjs_firstY = cvjs_SVG_y(y)
                        cvjs_lastX = cvjs_firstX;
                        cvjs_lastY = cvjs_firstY;
                        generic_canvas_flag_rectangle = true;
                    }
                    else {
                        // we cannot have the mouse directly on top of the rubberband path, then it will not respond
                        var mousedelta = 1;
                        cvjs_lastX = cvjs_SVG_x(x - mousedelta);
                        cvjs_lastY = cvjs_SVG_y(y - mousedelta);
                    }

                    var tPath_r = "M" + cvjs_firstX + "," + cvjs_firstY;
                    tPath_r += "L" + cvjs_firstX + "," + cvjs_lastY;
                    tPath_r += "L" + cvjs_lastX + "," + cvjs_lastY;
                    tPath_r += "L" + cvjs_lastX + "," + cvjs_firstY;
                    tPath_r += "L" + cvjs_firstX + "," + cvjs_firstY + " Z";
                    cvjs_RubberBand.attr({ 'path': tPath_r });
                }
            }
            catch (err) {
                console.log(err);
            }
        }

        var generic_make_rect_stop_method = function () {

            cvjs_RubberBand.attr({ fill: '#ff9999', "fill-opacity": "0.5", stroke: '#ff9999', 'stroke-opacity': "1" });
            cvjs_removeCustomCanvasMethod();

        };

        // END - SAMPLE TO CREATE RECTANGLE BY CLICK


        // SAMPLE TO CREATE RECTANGLE BY DRAG

        var generic_drag_rect_start = function () {

            generic_canvas_flag_first_click_rectangle = true;
            generic_canvas_flag_rectangle = false;

            var tPath_r = "M" + 0 + "," + 0;
            cvjs_RubberBand = cvjs_makeGraphicsObjectOnCanvas('Path', tPath_r).attr({ stroke: "#b00000", fill: "none" });

            console.log("generic_start_method_01");
        }

        /**
         * Template move drag method for custom canvas
         */
        var generic_drag_rect_move = function (dx, dy, x, y) {

            try {
                if (generic_canvas_flag_first_click_rectangle) {
                    cvjs_customCanvasMethod_globalScale();
                    if (!generic_canvas_flag_rectangle) {
                        cvjs_firstX = cvjs_SVG_x(x);
                        cvjs_firstY = cvjs_SVG_y(y)
                        cvjs_lastX = cvjs_firstX;
                        cvjs_lastY = cvjs_firstY;
                        generic_canvas_flag_rectangle = true;
                    }
                    else {
                        // we cannot have the mouse directly on top of the rubberband path, then it will not respond
                        var mousedelta = 1;
                        cvjs_lastX = cvjs_SVG_x(x - mousedelta);
                        cvjs_lastY = cvjs_SVG_y(y - mousedelta);
                    }

                    var tPath_r = "M" + cvjs_firstX + "," + cvjs_firstY;
                    tPath_r += "L" + cvjs_firstX + "," + cvjs_lastY;
                    tPath_r += "L" + cvjs_lastX + "," + cvjs_lastY;
                    tPath_r += "L" + cvjs_lastX + "," + cvjs_firstY;
                    tPath_r += "L" + cvjs_firstX + "," + cvjs_firstY + " Z";
                    cvjs_RubberBand.attr({ 'path': tPath_r });
                }
            }
            catch (err) {
                console.log(err);
            }

        }

        /**
         * Template stop drag method for custom canvas
         */
        var generic_drag_rect_stop = function () {

            cvjs_RubberBand.attr({ fill: '#99ff99', "fill-opacity": "0.5", stroke: '#ff9999', 'stroke-opacity': "1" });
            cvjs_removeCustomCanvasMethod();
            console.log("REMOVE: generic_drag_rect_stop");
        };


        // END - SAMPLE TO CREATE RECTANGLE BY DRAG




        // SAMPLE TO DRAG RECTANGLE if overlapping space objects

        var select_drag_rect_start = function () {

            generic_canvas_flag_first_click_rectangle = true;
            generic_canvas_flag_rectangle = false;

            var tPath_r = "M" + 0 + "," + 0;
            cvjs_RubberBand = cvjs_makeGraphicsObjectOnCanvas('Path', tPath_r).attr({ fill: '#ff9999', "fill-opacity": "0.5", stroke: '#ff9999', 'stroke-opacity': "1" });

            console.log("generic_start_method_01");
        }

        var select_drag_rect_move = function (dx, dy, x, y) {

            try {
                if (generic_canvas_flag_first_click_rectangle) {
                    cvjs_customCanvasMethod_globalScale();
                    if (!generic_canvas_flag_rectangle) {
                        cvjs_firstX = cvjs_SVG_x(x);
                        cvjs_firstY = cvjs_SVG_y(y)
                        cvjs_lastX = cvjs_firstX;
                        cvjs_lastY = cvjs_firstY;
                        generic_canvas_flag_rectangle = true;
                    }
                    else {
                        // we cannot have the mouse directly on top of the rubberband path, then it will not respond
                        var mousedelta = 1;
                        cvjs_lastX = cvjs_SVG_x(x - mousedelta);
                        cvjs_lastY = cvjs_SVG_y(y - mousedelta);
                    }

                    var tPath_r = "M" + cvjs_firstX + "," + cvjs_firstY;
                    tPath_r += "L" + cvjs_firstX + "," + cvjs_lastY;
                    tPath_r += "L" + cvjs_lastX + "," + cvjs_lastY;
                    tPath_r += "L" + cvjs_lastX + "," + cvjs_firstY;
                    tPath_r += "L" + cvjs_firstX + "," + cvjs_firstY + " Z";
                    cvjs_RubberBand.attr({ 'path': tPath_r });
                }
            }
            catch (err) {
                console.log(err);
            }

        }


        var select_drag_rect_stop = function () {

            cvjs_RubberBand.attr({ 'path': "M0,0" });
            var mybox;
            var overlap;
            var selected_list = "";

            // reorder x,  if not dragged left to right, top to buttom
            var temp;
            if (cvjs_firstX > cvjs_lastX) {
                temp = cvjs_firstX;
                cvjs_firstX = cvjs_lastX;
                cvjs_lastX = temp;
            }
            // reorder y,  if not dragged left to right, top to buttom
            if (cvjs_firstY > cvjs_lastY) {
                temp = cvjs_firstY;
                cvjs_firstY = cvjs_lastY;
                cvjs_lastY = temp;
            }


            // get all spaces
            var spaceObjectIds = cvjs_getSpaceObjectIdList();
            // loop over all spaces
            for (var spc in spaceObjectIds) {
                // get the bounding box of the space

                mybox = cvjs_getSpaceObjectBoundingBox(spaceObjectIds[spc]);
                // check if it operlaps with the drag rectangle
                if (mybox == false) continue;

                //console.log(cvjs_firstX+"  "+ cvjs_firstY+" "+ cvjs_lastX+ " "+ cvjs_lastY+"  "+spc);
                //console.log(mybox.x+" "+ mybox.y+" "+ (mybox.x+mybox.width) + " "+ (mybox.y+mybox.height));

                overlap = cvjs_rect_doOverlap(cvjs_firstX, cvjs_firstY, cvjs_lastX, cvjs_lastY, mybox.x, mybox.y, mybox.x + mybox.width, mybox.y + mybox.height);

                if (overlap)
                    selected_list += spaceObjectIds[spc] + ";";
            }

            if (selected_list == "") selected_list = "None";

            window.alert("Selected Objects: " + selected_list);
            //cvjs_RubberBand.attr({fill: '#99ff99', "fill-opacity": "0.5", stroke: '#ff9999', 'stroke-opacity': "1"});
            cvjs_removeCustomCanvasMethod();
            console.log("REMOVE: generic_drag_rect_stop");
        };

        // END - SAMPLE TO DRAG RECTANGLE if overlapping space objects




        // SAMPLE TO CREATE RECTANGLE w TEXT and ARRow BY CLICK

        var logic_flags = [false, false, false, false, false, false];
        var operation_type = "";
        var mybasewidth = 1;

        var generic_make_rect_arrow_init_method = function () {
            console.log("generic_make_rect_init_method");
            logic_flags = [false, false, false, false, false, false];
            operation_type = "box";
        }
        var tPath_r;

        var generic_make_rect_arrow_mousedown_method = function (e, x, y) {

            try {
                if ((operation_type.indexOf("arrow") == 0) && logic_flags[0] && logic_flags[1]) {
                    generic_make_rect_arrow_stop_method2();
                }

                if ((operation_type.indexOf("box") == 0) && !logic_flags[0]) {  // first box
                    var tPath_r = "M" + 0 + "," + 0;
                    cvjs_RubberBand = cvjs_makeGraphicsObjectOnCanvas('Path', tPath_r).attr({ stroke: "#b00000", fill: "none" });
                    logic_flags[0] = true;
                    logic_flags[1] = false;
                }
                if ((operation_type.indexOf("box") == 0) && logic_flags[0] && logic_flags[1]) {
                    generic_make_rect_arrow_stop_method1();
                }
            }
            catch (err) { console.log(err) }
            //console.log("mouse down ");
        }


        var generic_make_rect_arrow_mouseup_method = function () {

            try {
                console.log("generic_make_rect_mouseup_method");
            }
            catch (err) { console.log(err) }
        }


        var generic_make_rect_arrow_dblclick_method = function () {

            try {
                console.log("generic_make_rect_dblclick_method");
            }
            catch (err) { console.log(err) }
        }


        var generic_make_rect_arrow_mousemove_method = function (e, x, y) {

            try {
                if ((operation_type.indexOf("box") == 0) && logic_flags[0]) {
                    cvjs_customCanvasMethod_globalScale();
                    if (!logic_flags[1]) {
                        cvjs_firstX = cvjs_SVG_x(x);
                        cvjs_firstY = cvjs_SVG_y(y)
                        cvjs_lastX = cvjs_firstX;
                        cvjs_lastY = cvjs_firstY;
                        logic_flags[1] = true;
                    }
                    else {
                        // we cannot have the mouse directly on top of the rubberband path, then it will not respond
                        var mousedelta = 1;
                        cvjs_lastX = cvjs_SVG_x(x - mousedelta);
                        cvjs_lastY = cvjs_SVG_y(y - mousedelta);
                    }

                    tPath_r = "M" + cvjs_firstX + "," + cvjs_firstY;
                    tPath_r += "L" + cvjs_firstX + "," + cvjs_lastY;
                    tPath_r += "L" + cvjs_lastX + "," + cvjs_lastY;
                    tPath_r += "L" + cvjs_lastX + "," + cvjs_firstY;
                    tPath_r += "L" + cvjs_firstX + "," + cvjs_firstY + " Z";
                    cvjs_RubberBand.attr({ 'path': tPath_r });
                }


                if ((operation_type.indexOf("arrow") == 0) && logic_flags[0]) {
                    cvjs_customCanvasMethod_globalScale();

                    logic_flags[1] = true;
                    var mousedelta = 1;
                    cvjs_lastX = cvjs_SVG_x(x - mousedelta);
                    cvjs_lastY = cvjs_SVG_y(y - mousedelta);

                    tPath_r = "M" + cvjs_firstX + "," + cvjs_firstY;
                    tPath_r += "L" + cvjs_lastX + "," + cvjs_lastY;
                    cvjs_RubberBand.attr({ 'path': tPath_r });
                }
            }
            catch (err) {
                console.log(err);
            }
        }

        var randomNr;

        var generic_make_rect_arrow_stop_method1 = function () {


            // find the current highest node number
            var Node_id = cvjs_currentMaxNodeId();
            // increment and set current node underbar
            Node_id++;
            cvjs_currentNode_underbar = Node_underbar + Node_id;
            randomNr = Math.floor(Math.random() * Math.floor(100000)); window.alert("randomNr " + randomNr);

            cvjs_RubberBand.attr({ fill: 'none', "fill-opacity": "0.5", stroke: '#0000b0', 'stroke-opacity': "1" });
            // create a group with space as main object
            cvjs_createSpaceObjectGroup(cvjs_currentNode_underbar, cvjs_RubberBand, "API" + randomNr, "API" + randomNr, "Generic", "myLayer", "myGroup");

            // create a new border object as separate graphics - we use the rubberband as our graphics variable
            cvjs_RubberBand = cvjs_makeGraphicsObjectOnCanvas('Path', tPath_r).attr({ fill: 'none', "fill-opacity": "1", stroke: '#000', 'stroke-opacity': "1", 'stroke-width': mybasewidth });
            cvjs_addGraphicsToSpaceObjectGroup(cvjs_currentNode_underbar, cvjs_RubberBand, "rect01");

            var myText = cvjs_rPaper[cvjs_active_floorplan_div_nr].text(cvjs_firstX + (cvjs_lastX - cvjs_firstX) / 10.0, cvjs_lastY - (cvjs_lastY - cvjs_firstY) / 5.0, "API" + randomNr).attr({ fill: '#000', "fill-opacity": "1", stroke: '#000', 'font-size': (Math.abs(cvjs_lastY - cvjs_firstY) / 2.0) });
            //	var myText = cvjs_rPaper[cvjs_active_floorplan_div_nr].text("HELLO!!").attr({textpath: tPath_r}).attr({fill: '#000', "fill-opacity": "1", stroke: '#000'});
            cvjs_addGraphicsToSpaceObjectGroup(cvjs_currentNode_underbar, myText, "text01");



            // we change to arrow, and directly make the mouse draggable
            operation_type = "arrow";
            logic_flags[0] = true;
            logic_flags[1] = false;

            // set rubberband to middle of box side
            cvjs_firstX = (cvjs_firstX + cvjs_lastX) / 2.0;
            cvjs_firstY = cvjs_lastY;
            // make new rubberband
            tPath_r = "M" + cvjs_firstX + "," + cvjs_firstY;
            cvjs_RubberBand = cvjs_makeGraphicsObjectOnCanvas('Path', tPath_r).attr({ stroke: "#b00000", fill: "none" });
        };



        var generic_make_rect_arrow_stop_method2 = function () {

            cvjs_RubberBand.attr({ fill: 'none', "fill-opacity": "1", stroke: '#000', 'stroke-opacity': "1", 'stroke-width': mybasewidth });
            // we create an arrow object and add to space object


            // here we have to add the graphical object to our already created object
            cvjs_addGraphicsToSpaceObjectGroup(cvjs_currentNode_underbar, cvjs_RubberBand, "arrow-line01");

            // create an arrow
            var angleInDegrees = (Math.atan2((cvjs_lastY - cvjs_firstY), (cvjs_lastX - cvjs_firstX)) / Math.PI * 180.0);
            var scaleTriangle = mybasewidth;  // same as stroke-width
            var triangle_design = -5.0 * scaleTriangle + "," + 5.5 * scaleTriangle + " " + 0.0 * scaleTriangle + "," + -4.5 * scaleTriangle + " " + 5.0 * scaleTriangle + "," + 5.5 * scaleTriangle;
            var mysin = Math.sin(angleInDegrees / 180 * Math.PI);
            var mycos = Math.cos(angleInDegrees / 180 * Math.PI);
            var Ttrans = 'r' + (angleInDegrees - 270) + 'T' + (cvjs_lastX + mycos * scaleTriangle) + "," + cvjs_lastY;
            var Triangle = cvjs_rPaper[cvjs_active_floorplan_div_nr].polyline(triangle_design);
            Triangle.attr({
                fill: "#000",
                transform: Ttrans
            });

            // here we add an arrow to the object
            cvjs_addGraphicsToSpaceObjectGroup(cvjs_currentNode_underbar, Triangle, "arrow01");

            cvjs_graphicalObjectCreated('CustomObject');
            cvjs_graphicalObjectOnChange('Create', 'CustomObject', "N" + randomNr);

            cvjs_removeCustomCanvasMethod();
        };


        var selected_handles = [];
        var handle_selector = false;
        var current_selected_handle = "";



        // ENABLE ALL API EVENT HANDLES FOR AUTOCAD Handles
        function cvjs_mousedown(id, handle, entity) {

        }

        function cvjs_click(id, handle, entity) {


            console.log("mysql click " + id + "  " + handle);
            // if we click on an object, then we add to the handle list
            if (handle_selector) {
                selected_handles.push({ id, handle });
                current_selected_handle = handle;
            }

            // tell to update the Scroll bar
            //vqUpdateScrollbar(id, handle);
            // window.alert("We have clicked an entity: "+entity.substring(4)+"\r\nThe AutoCAD Handle id: "+handle+"\r\nThe svg id is: "+id+"\r\nHighlight SQL pane entry");
        }

        function cvjs_dblclick(id, handle, entity) {

            console.log("mysql dblclick " + id + "  " + handle);
            window.alert("We have double clicked entity with AutoCAD Handle: " + handle + "\r\nThe svg id is: " + id);
        }

        function cvjs_mouseout(id, handle, entity) {

            console.log("mysql mouseout " + id + "  " + handle);

            if (current_selected_handle == handle) {
                // do nothing
            }
            else {
                cvjs_mouseout_handleObjectStyles(id, handle);
            }
        }

        function cvjs_mouseover(id, handle, entity) {

            //console.log("mysql mouseover " + id + "  " + handle + "  " + jQuery("#" + id).css("color"))
            //cvjs_mouseover_handleObjectPopUp(id, handle);
        }

        function cvjs_mouseleave(id, handle, entity) {

            console.log("mysql mouseleave " + id + "  " + handle + "  " + jQuery("#" + id).css("color"));
        }


        function cvjs_mouseenter(id, handle, entity) {
            //	cvjs_mouseenter_handleObjectStyles("#a0a000", 4.0, 1.0, id, handle);
            //	cvjs_mouseenter_handleObjectStyles("#ffcccb", 5.0, 0.7, true, id, handle);


            cvjs_mouseenter_handleObjectStyles("#0F0", 1.0, 1.0, true, id, handle);

        }

        // END OF MOUSE OPERATION

    </script>

    <script id="scriptIconImage">


        var insertImageSelected = 0;

        function selectIconImage(n) {

            insertImageSelected = n;

            if (n == 1) {
                $('#image_Type').val("Device");
                $('#image_ID').val("device_" + iconObjectCounter);
                //	$('#image_sensor_location').val("H1.svg");  
                $('#image_sensor_location').val("device_54.svg");
            }

            if (n == 2) {
                $('#image_Type').val("Wifi");
                $('#image_ID').val("wifi_" + iconObjectCounter);
                $('#image_sensor_location').val("wifi_25.svg");
            }

            if (n == 3) {
                $('#image_Type').val("Marker");
                $('#image_ID').val("marker_" + iconObjectCounter);
                $('#image_sensor_location').val("pin_02.svg");
                //	$('#image_sensor_location').val("assembly_point.png");  

            }

            if (n == 4) {
                $('#image_Type').val("AirCon");
                $('#image_ID').val("aircon_" + iconObjectCounter);
                $('#image_sensor_location').val("HVAC_04.svg");
            }

            if (n == 5) {
                $('#image_Type').val("Boiler");
                $('#image_ID').val("boiler_" + iconObjectCounter);
                $('#image_sensor_location').val("HVAC_01.svg");
            }

            if (n == 6) {
                $('#image_Type').val("Ventilator");
                $('#image_ID').val("vent_" + iconObjectCounter);
                $('#image_sensor_location').val("HVAC_02.svg");
            }

            if (n == 7) {
                $('#image_Type').val("Temp");
                $('#image_ID').val("temp_" + iconObjectCounter);
                $('#image_sensor_location').val("HVAC_03.svg");
            }

            if (n == 8) {
                $('#image_Type').val("Assembly");
                $('#image_ID').val("assembly_" + iconObjectCounter);
                $('#image_sensor_location').val("assembly_point.png");
            }

            if (n == 9) {
                $('#image_Type').val("Danger");
                $('#image_ID').val("danger_" + iconObjectCounter);
                $('#image_sensor_location').val("danger.png");
            }

            if (n == 10) {
                $('#image_Type').val("Fire Alarm");
                $('#image_ID').val("fire_alarm_" + iconObjectCounter);
                $('#image_sensor_location').val("fire_alarm_call_point.png");
            }

            if (n == 11) {
                $('#image_Type').val("Fire Exit");
                $('#image_ID').val("exit_" + iconObjectCounter);
                $('#image_sensor_location').val("fire_exit.png");
            }

            if (n == 12) {
                $('#image_Type').val("Fire Extinguisher");
                $('#image_ID').val("extinguisher_" + iconObjectCounter);
                $('#image_sensor_location').val("fire_extinguisher.png");
            }

            if (n == 13) {
                $('#image_Type').val("Refuge");
                $('#image_ID').val("refuge_" + iconObjectCounter);
                $('#image_sensor_location').val("refuge_point.png");
            }


            // clone image

            // API COMMAND CALL TO CADVIEWER
            // insert_space_icon();

            cvjs_loadSpaceImage_Location = ServerUrl + "content/drawings/svg/" + $('#image_sensor_location').val();
            cvjs_loadSpaceImage_ID = $('#image_ID').val();
            cvjs_loadSpaceImage_Type = $('#image_Type').val();
            cvjs_loadSpaceImage_Layer = "cvjs_SpaceLayer";

            cvjs_addFixedSizeImageSpaceObject("floorPlan");
            iconObjectCounter++;

            //window.alert(cvjs_loadSpaceImage_ID);
            //	$('#sensor_to_highlight').val(cvjs_loadSpaceImage_ID)
            //	currentDiv(slideIndex)

        }

        var highlight_colorgrade_C_legend_1 = "#fe50d9";
        var highlight_colorgrade_C_1 = {
            fill: '#fe50d9',
            "fill-opacity": "0.9",
            stroke: '#fe50d9',
            'stroke-width': 1,
            'stroke-opacity': "1",
            'stroke-linejoin': 'round'
        };

        var highlight_colorgrade_C_legend_2 = "#0dff8a";
        var highlight_colorgrade_C_2 = {
            fill: '#0dff8a',
            "fill-opacity": "0.9",
            stroke: '#0dff8a',
            'stroke-width': 1,
            'stroke-opacity': "1",
            'stroke-linejoin': 'round'
        };

        var highlight_colorgrade_C_legend_3 = "#0c8dff";
        var highlight_colorgrade_C_3 = {
            fill: '#0c8dff',
            "fill-opacity": "0.9",
            stroke: '#0c8dff',
            'stroke-width': 1,
            'stroke-opacity': "1",
            'stroke-linejoin': 'round'
        };

        var highlight_colorgrade_C_legend_4 = "#fafa00";
        var highlight_colorgrade_C_4 = {
            fill: '#fafa00',
            "fill-opacity": "0.9",
            stroke: '#fafa00',
            'stroke-width': 1,
            'stroke-opacity': "1",
            'stroke-linejoin': 'round'
        };

        var highlight_colorgrade_C_legend_5 = "#ff00dd";
        var highlight_colorgrade_C_5 = {
            fill: '#ff00dd',
            "fill-opacity": "0.9",
            stroke: '#ff00dd',
            'stroke-width': 1,
            'stroke-opacity': "1",
            'stroke-linejoin': 'round'
        };


        var no_colorgrade_C_reading = {
            fill: '#A2C2A2',
            "fill-opacity": "0.5",
            stroke: '#D2D2D2',
            'stroke-width': 1,
            'stroke-opacity': "1",
            'stroke-linejoin': 'round'
        };




    </script>

    <script id="scriptRedLine">

        function fnRedLineSave() {
            fnSetupSaveAndLoad();  
            cvjs_saveStickyNotesRedlines("floorPlan");
        }

        function fnRedLineLoad() {
            fnSetupSaveAndLoad();
            cvjs_loadStickyNotesRedlines("floorPlan");
        }

        function fnSetupSaveAndLoad() {

            var v1 = $('#HiddenRedLineFileJson').val();
            //var v2 = 'save_url.aspx?v=save';

            if (!v1) return;

            cvjs_setStickyNoteRedlineUrl(v1);
            cvjs_setStickyNoteSaveRedlineUrl(v1);
        }

    </script>

    <style id="styleSlider">
        .slider {
          -webkit-appearance: none;
          width: 100%;
          height: 15px;
          border-radius: 5px;
          background: #d3d3d3;
          outline: none;
          opacity: 0.7;
          -webkit-transition: .2s;
          transition: opacity .2s;
        }

        .slider:hover {
          opacity: 1;
        }

        .slider::-webkit-slider-thumb {
          -webkit-appearance: none;
          appearance: none;
          width: 25px;
          height: 25px;
          border-radius: 50%;
          background: #4CAF50;
          cursor: pointer;
        }

        .slider::-moz-range-thumb {
          width: 25px;
          height: 25px;
          border-radius: 50%;
          background: #4CAF50;
          cursor: pointer;
        }
    </style>

    <style id="styleViewer">

        #myImagesToDrag {
	        position: absolute; 
	        left: 0px; 
	        top: 70px; 
	        width: 100px;
	        height: 680px;
	        border: 0px solid red;
	
        }

        #space_icon_table2 {
	        position: absolute; 
	        left: 10px; 
	        top: 70px; 
	        width: 50px ;
	        border: 2px solid gray;
            
	
        }

        #space_icon_table2 img{
            cursor:pointer;
        }

        #space_icon_table2 tr td{
            border: 2px solid gray;
	        text-align: center; 
            vertical-align: middle;
	        width : 50px;
        }

        #space_icon_table1 {
	        position: absolute; 
	        left: 0px; 
	        top: 10px; 
        }

        .slidecontainer {
	        width: 200px;
	        position: absolute;
	        top: 10px;
	        left: 10px;
	        z-index: 100;
        }

        #cadviewer_table_01 {
	        position: absolute; 
	        left: 80px; 
	        top: 25px; 
        }

        #icon_div_popup {
            
            left:46px;
	        position: absolute;
	        border: 1px solid black;
	        background: #F5F5F5;
	
	        font-family:Verdana;
	        font-size:9pt;
	
	
        }

    </style>

    
</head>
<body style="margin: 0px; padding:0px; overflow:hidden;">
    <form id="form1" runat="server">
        <asp:HiddenField ID="hiddenFileUrl" runat="server" ClientIDMode="Static" />

        <asp:HiddenField ID="hiddenServerUrl" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hiddenServerBackEndUrl" runat="server" ClientIDMode="Static" />

        <asp:HiddenField ID="HiddenRedLineFileJson" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="HiddenHasJsonFile" runat="server" ClientIDMode="Static" />
        
        <span></span>
    </form>

    <div style="position:fixed;right:0px;top:5px;">
        <input type="button" value="Save" onclick=' fnRedLineSave();' />
    </div>

    <table width="100%" height="100%" border="0" cellspacing="0" border-spacing="0" id="mainTable" style="display: none;">
        <tr style="background-color: rgb(255,255,255)" height="100px">
            <td height="10">
                <canvas id="dummy" width="10" height="10"></canvas>
            </td>
            <td width="300" height="40"></td>
            <td>
                <canvas id="dummy" width="10" height="10"></canvas>
            </td>
            <td>
                <h4><b>CADViewer: Space Objects and Canvas Methods Interface</b></h4>
                <p>
                    Check out the: <strong><a href="https://cadviewer.com/cadviewertechdocs/samples/spaceicons/">Tech Docs</a></strong>. Contact us at: <a href="mailto:developer@tailormade.com">developer@tailormade.com</a>. Click on a symbol
                    <img src="../html/index_images/sensor_01.png" width="38" height="33" alt="Tailor Made logo" />
                    to insert. Use Space commands to resize, move, rotate and delete.<br>
                    Select a color:
                    <input id="cvjs_backgroundPickerValue" value="AAAA00" class="cvjs_inputBackgroundColorModal jscolor {width:101, padding:10, shadow:false, borderWidth:0, backgroundColor:'transparent', insetColor:'#AAAA00',closable:true, closeText:'Close Color Picker!', onFineChange:'custom_ColorHex(this)'}">
                    <button class="w3-button demo" onclick="highlight_all_spaces();">Highlight All - Space </button>
                    <button class="w3-button demo" onclick="highlight_all_borders();">Highlight All - Borders</button>
                    <button class="w3-button demo" onclick="highlight_space_type();">Highlight- Space Type</button>
                    <button class="w3-button demo" onclick="highlight_space_id();">Highlight- Space ID</button>
                    <button class="w3-button demo" onclick="clear_space_highlight();">Clear All Space Highlight</button>
                    <br />
                    <strong>Custom Canvas Methods Samples:</strong><canvas id="dummy" width="10" height="10"></canvas>
                    <button class="w3-button demo" onclick="cvjs_executeCustomCanvasMethod_drag(generic_start_method_01, generic_stop_method_01, generic_move_method_01,'');">Canvas - (console trace) - DRAG</button>
                    <button class="w3-button demo" onclick="cvjs_executeCustomCanvasMethod_click(generic_mousemove_method_01, generic_mousedown_method_01, generic_mouseup_method_01, generic_dblclick_method_01,'');">Canvas - (console trace) -CLICK</button>
                    <button class="w3-button demo" onclick="cvjs_executeCustomCanvasMethod_click(generic_make_rect_mousemove_method, generic_make_rect_mousedown_method, generic_make_rect_mouseup_method, '', generic_make_rect_init_method);">Canvas - Make Rect - CLICK</button>
                    <button class="w3-button demo" onclick="cvjs_executeCustomCanvasMethod_drag(generic_drag_rect_start, generic_drag_rect_stop, generic_drag_rect_move,'');">Canvas - Make Rect - DRAG</button>
                    <button class="w3-button demo" onclick="cvjs_executeCustomCanvasMethod_drag(select_drag_rect_start, select_drag_rect_stop, select_drag_rect_move,'');">Canvas - Select Spaces - DRAG</button>
                    <button class="w3-button demo" onclick="cvjs_executeCustomCanvasMethod_click(generic_make_rect_arrow_mousemove_method, generic_make_rect_arrow_mousedown_method, generic_make_rect_arrow_mouseup_method, generic_make_rect_arrow_dblclick_method, generic_make_rect_arrow_init_method);">Canvas - Make Box/Arrow - CLICK</button>
                </p>
            </td>
        </tr>
    </table>
    <div class="slidecontainer">
        <strong><small>Icon Size: <span id="iconsize"></span></small></strong>
        <input type="range" min="1" max="400" value="100" class="slider" id="myRange">
    </div>


    <table id="space_icon_table1" border="0" style="vertical-align: top; display: none;">
        <tr>
            <td>

                <a href="https://cadviewer.com/cadviewertechdocs">
                    <img src="https://cadviewer.com/images/cadviewer/cv-logo.gif" width="120" height="30" alt="Tailor Made logo" /></a>
            </td>
        </tr>

        <tr>
            <td>
                <strong>Space Type:</strong>&nbsp; 
            </td>
            <td>
                <canvas id="dummy" width="5" height="10"></canvas>
            </td>
            <td>
                <input type="text" id="image_Type" value="Wifi" />
            </td>
            <td></td>
        </tr>

        <tr>
            <td>
                <strong>Space ID:</strong>&nbsp; 
            </td>
            <td>
                <canvas id="dummy" width="5" height="10"></canvas>
            </td>
            <td>
                <input type="text" id="image_ID" value="wifi_1" />
            </td>
        </tr>

        <tr>
            <td>
                <strong>Space Image:</strong>&nbsp; 
            </td>
            <td>
                <canvas id="dummy" width="5" height="10"></canvas>
            </td>
            <td>
                <input type="text" id="image_sensor_location" value="wifi_25.svg" />
            </td>
        </tr>
    </table>


    <div id="myImagesToDrag"></div>

    <table id="space_icon_table2">

        <tr border="1px">
            <td border="1px">
                <div id="device_drag">
                    <img src="../html/index_images/device_01.png" width="50px" onclick="selectIconImage(1)">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="wifi_drag">
                    <img src="../html/index_images/wifi_01.png" width="50px" onclick="selectIconImage(2)">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="pin_drag">
                    <img src="../html/index_images/pin_01.png" width="50px" onclick="selectIconImage(3)">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="aircon_drag">
                    <img src="../html/index_images/aircon_01.png" width="50px" onclick="selectIconImage(4)">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="boiler_drag">
                    <img src="../html/index_images/boiler_01.png" width="50px" onclick="selectIconImage(5)">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="vent_drag">
                    <img src="../html/index_images/vent_01.png" width="50px" onclick="selectIconImage(6)">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="temp_drag">
                    <div id="temp_01">
                        <img src="../html/index_images/temp_01.png" width="50px" onclick="selectIconImage(7)">
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="assembly_drag">
                    <img src="../html/index_images/assembly_point.png" width="50px" onclick="selectIconImage(8)">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="danger_drag">
                    <img src="../html/index_images/danger.png" width="50px" onclick="selectIconImage(9)">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="fire_alarm_drag">
                    <img src="../html/index_images/fire_alarm_call_point.png" width="50px" onclick="selectIconImage(10)">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="fire_exit_drag">
                    <img src="../html/index_images/fire_exit.png" width="50px" onclick="selectIconImage(11)">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="fire_extinguisher_drag">
                    <img src="../html/index_images/fire_extinguisher.png" width="50px" onclick="selectIconImage(12)">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="refuge_point_drag">
                    <img src="../html/index_images/refuge_point.png" width="50px" onclick="selectIconImage(13)">
                </div>
            </td>
        </tr>
    </table>

    <div id="icon_div_popup"></div>

    <div id="cadviewer_table_01">
        <!--This is the CADViewer floorplan div declaration -->
        <div id="floorPlan" style="border: 2px none; width: 1800px; height: 80%;">
        </div>
        <!--End of CADViewer declaration -->
    </div>

</body>
</html>
