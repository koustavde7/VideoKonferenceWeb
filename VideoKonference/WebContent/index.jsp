<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URL, java.net.HttpURLConnection, java.io.IOException, java.io.InputStream, java.util.Scanner, com.VideoKonference.RegexClass.ExtractRemoveString" %>
<html>
  <head>
    <title>VideoKonference</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <style></style>
  </head>
  <body>
  	<script type="text/javascript">
  		var vidyoConnector;
  		function onVidyoClientLoaded(status) {
  			console.log("VidyoClient load state - " + status.state);
  			if (status.state == "READY") {
  				VC.CreateVidyoConnector({
					viewId: "renderer", //Div ID where the composited video will be rendered, see VidyoConnector.html;
					viewStyle: "VIDYO_CONNECTORVIEWSTYLE_Default", // Visual style of the composited renderer
					remoteParticipants : 16,	//Maximum number of participants to render
					logFileFilter: "warning info@VidyoClient info@VidyoConnector",
					logFileName:"",
					userData:""
				}).then(function (vc) {
					console.log("Create Success");
					vidyoConnector = vc;
				}).catch(function(error) {
					console.error("Create failed + " + error);
				})
  			}
  		}

  		function joinCall(){
  			<%
				String url = "http://videod.ddns.net:6002/generateRandomToken/";
  				String receivedToken = null;
				URL obj = new URL(url);
				HttpURLConnection con = (HttpURLConnection) obj.openConnection();
				con.setRequestMethod("GET");
				int responseCode = con.getResponseCode();
				InputStream in = null;
				if(responseCode == HttpURLConnection.HTTP_OK) {
					in = con.getInputStream();
				}
				Scanner sc = new Scanner(in);
				try {
					
					StringBuffer sb = new StringBuffer();
					while(sc.hasNext()) {
						sb.append(sc.nextLine());
					}
					receivedToken = sb.toString();
					
					// a potentially time consuming task
		            receivedToken = receivedToken.replaceAll("\"", "");
		            receivedToken = ExtractRemoveString.removeStringfromOrg(receivedToken, "<title>[a-zA-Z0-9\\p{Punct}\\s]*</title>");
		            String extractTokenPattern = "[<][!]?[/]?[a-zA-Z0-9\\s=-]*[>]";
		            receivedToken = ExtractRemoveString.ExtractToken(receivedToken, extractTokenPattern);
		            //Log.v("ReceivedTokenString", receivedToken);
		            sc.close();
		        }catch(Exception e)
		        {
		            e.printStackTrace();
		        }

		        //out.print("Received Token :- " + receivedToken);
		        //return receivedToken;
				sc.close();
				//out.print("Received Token :- " + receivedToken);
			%>
  			vidyoConnector.Connect({
  				host:"prod.vidyo.io",
  				token:"<%=receivedToken%>",
  				displayName:"Koustav",
  				resourceId:"CSE_Class",
  				onSuccess: function() {
  					console.log("Successfully Connected !");
  				},
  				onFailure: function(reason) {
  					console.error("Connection Failed !!!");
  				},
  				onDisconnected: function(reason) {
  					console.log("Got Disconnected - " + reason);
  				}
  			})
  		}

      function DisconnectCall(){
        vidyoConnector.Disconnect();
      }
  	</script>
  	<script type="text/javascript" src = "https://static.vidyo.io/latest/javascript/VidyoClient/VidyoClient.js?onload=onVidyoClientLoaded"></script>
  	<h3>Hello to this Video Conference Portal</h3>
  	<button onclick="joinCall()">Connect</button>
    <button onclick="DisconnectCall()">Hang Up</button>
  	<div id="renderer"></div>
  </body>
</html>