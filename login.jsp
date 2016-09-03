<html><head>
<title>PinggWingg</title>
<link rel="stylesheet" type="text/css" href="register.css">
</head>
<body>
<center>
<script type="text/javascript">
nfl=0,pfl=0;
function chkname(){
	var val=document.querySelector("#cred.name").value;
	if(val=="" || val.length<6){
		document.querySelector("#imagname").src="img/exclaim.png";
		nfl=0;
	}
	else{
		document.querySelector("#imagname").src="img/right.png";
		nfl=1;
	}
}

function chkpass(){
	var val=document.querySelector("#cred.pass").value;
	if(val!="" && val.length>=8){
		document.querySelector("#imagpass").src="img/right.png";
		pfl=1;
	}
	else{
		document.querySelector("#imagpass").src="img/exclaim.png";
		pfl=0;
	}
}

function chk(){
	if(nfl==0){
		alert("Incorrect Username");
		document.querySelector("#cred.name").focus();
		return false;
	}
	else if(pfl==0){
		alert("Incorrect Password");
		document.querySelector("#cred.pass").focus();
		return false;
	}
	else{
		document.f1.action="login";
		return true;
	}
}

</script>
<table border=0 width=100% height=100%>
<form name="f1" method="post">
<tr><td valign="top" height=80><jsp:include page="header.jsp" /></td></tr>
<tr><td align="center" valign="middle"><table border=0>
<tr><td id="headnd">Sign in to PinggWingg</td></tr>
<tr><td id="tagline">Chat and share messages on PinggWingg.<br><br><br></td></tr>
<tr><td><input id="cred" class="name" type="text" name="uname" placeholder="Username" size=45 onchange="chkname()"/><img id="imagname"/></td></tr>
<tr><td><input id="cred" class="pass" type="password" name="pass" placeholder="Password" size=45 onchange="chkpass()"/><img id="imagpass"/></td></tr>
<tr><td><input id="bttn" type="Submit" value="Start Pinggingg" onclick="return chk()"/><br><br></td></tr>
<tr><td align="right"><font size="5px" face="verdana"><a href="frgtpass.jsp" target="_blank">Lost Password?</a></font></td></tr>
</table></td></tr>
</form>
</table>

</center>
</body>
</html>