<html>
<head><title>PinggWingg</title>
<link rel="stylesheet" type="text/css" href="register.css">
</head>
<body>
<script type="text/javascript">
nfl=0,efl=0,pfl=0,cpfl=0;
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

function chkemail(){
	var val=document.querySelector("#cred.email").value;
	if(val!="" && val.match(/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/)){
		document.querySelector("#imagemail").src="img/right.png";
		efl=1;
	}
	else{
		document.querySelector("#imagemail").src="img/exclaim.png";
		efl=0;
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

function chkcpass(){
	var val=document.querySelector("#cred.cpass").value;
	var val1=document.querySelector("#cred.pass").value;
	if(val=="" || val!=val1){
		document.querySelector("#imagcpass").src="img/exclaim.png";
		cpfl=0;
	}
	else{
		document.querySelector("#imagcpass").src="img/right.png";
		cpfl=1;
	}
}

function chk(){
	if(nfl==0){
		alert("Incorrect Username");
		document.querySelector("#cred.name").focus();
		return false;
	}
	else if(efl==0){
		alert("Incorrect Email ID");
		document.querySelector("#cred.email").focus();
		return false;
	}
	else if(pfl==0){
		alert("Incorrect Password");
		document.querySelector("#cred.pass").focus();
		return false;
	}
	else if(cpfl==0){
		alert("Password don't match");
		document.querySelector("#cred.cpass").focus();
		return false;
	}
	else{
		document.f2.action="register"
		return true;
	}
}

</script>
<table border="0" width="100%" height="100%">
<form name="f2" method="post">
<tr><td valign="top" height="80"><jsp:include page="header.jsp" /></td></tr>
<tr><td align="center" valign="middle"><table border="0">
<tr><td id="headnd" colspan="2">Sign up to PinggWingg</td></tr>
<tr><td id="tagline" colspan="2">Chat and share messages on PinggWingg.<br><br><br></td></tr>
<tr><td><input id="cred" class="name" type="text" name="uname" placeholder="Username" size="45" onchange="chkname()"/><img id="imagname"/></td></tr>
<tr><td><input id="cred" class="email" type="text" name="email" placeholder="Email" size="45" onchange="chkemail()"/><img id="imagemail"/></td></tr>
<tr><td><input id="cred" class="pass" type="password" name="pass" placeholder="Password" size="45" onchange="chkpass()"/><img id="imagpass"/></td></tr>
<tr><td><input id="cred" class="cpass" type="password" name="cpass" placeholder="Confirm Password" size="45" onchange="chkcpass()"/><img id="imagcpass"/></td></tr>
<tr><td><input id="bttn" type="submit" value="Start Pinggingg" onclick="return chk()"/></td></tr>
</table></td></tr>
</form>
</table>
</body>
</html>