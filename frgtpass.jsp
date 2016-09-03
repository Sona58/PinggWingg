<html>
<head><title>PinggWingg</title>
<style>
body{
	background:linear-gradient(orange,white);
}
#main{
	background:#ffff00;
	box-shadow:0 0 15px 5px #ffff00;
	border-radius:10px;
	overflow:auto;
}
#main td{
	font-size:25px;
	font-family:Arial;
}
#main input[type=text]{
	border:none;
	font-size:25px;
	border-bottom:thin solid green;
	background:yellow;
	outline:none;
}
#main input[type=submit]{
	padding:5px;
	border-radius:5px;
	background:orange;
	color:#ffffff;
	font-size:25px;
	outline:none;
	border:none;
}
::-webkit-scrollbar {
    width: 12px;
}
 
/* Track */
::-webkit-scrollbar-track {
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
    -webkit-border-radius: 10px;
    border-radius: 10px;
}
 
/* Handle */
::-webkit-scrollbar-thumb {
    -webkit-border-radius: 10px;
    border-radius: 10px;
    background: rgba(0,0,0,0.6); 
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5); 
}
::-webkit-scrollbar-thumb:window-inactive {
	background: rgba(0,0,0,0.4); 
}
</style>
<script>
efl=0;
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
function chk(){
	if(efl==0){
		alert("Incorrect Email ID");
		document.querySelector("#cred.email").focus();
		return false;
	}
	else{
		document.f2.action="frgt"
		return true;
	}
}
</script>
</head>
<body>
<center>
<table border="0" width="100%" height="100%">
<tr><td height="90"><jsp:include page="header.jsp" /></td></tr>
<tr><td align="center">
<table border="0" cellspacing="0" cellpadding="10" width="50%" height="100%" id="main">
<tr><td valign="top" colspan="2"><table width="100%" cellspacing="0" cellpadding="15" border="0"><form name="f2" method="post">
<tr><td>Enter Email Id:</td></tr>
<tr><td><input id="cred" class="email" type="text" name="email" placeholder="Email" size="35" onblur="chkemail()"/><img id="imagemail"/></td></tr>
<tr><td align="center"><input id="bttn" type="submit" value="Submit" onclick="return chk()"/></td></tr>
</form>
</table>
</td></tr>
</table>
</td></tr>
</table>
</center></body>
</html>