<html>
<head><title>PinggWingg</title>
<style>
#block1{
	background:linear-gradient(#ffffff,#ededed);
	border-radius:8px;
	padding:10px;
	width:1000;
	height:500;
}
#next{
	background:Transparent;
	outline:none;
	font-size:25px;
	font-weight:bold;
	border:none;
}
#pic{
	width:200;
	height:200;
	-webkit-filter: blur(10px);
}
#cover{
	font-size:25px;
	font-weight:bold;
	font-family:verdana;
}
</style>
<script type="text/javascript">
var gen=null;
function clk(a){
	if(a=="Male"){
		document.querySelector(".Male").style.webkitFilter = "none";
		document.querySelector(".Female").style.webkitFilter = "blur(10px)";
		gen="Male";
		document.querySelector("#next").disabled=false;
		document.querySelector("#next").style.color="#EB214A";
	}
	else{
		document.querySelector(".Female").style.webkitFilter = "none";
		document.querySelector(".Male").style.webkitFilter = "blur(10px)";
		gen="Female";
		document.querySelector("#next").disabled=false;
		document.querySelector("#next").style.color="#EB214A";
	}
}
function subm(){
	if(gen!=null){
		document.querySelector("#gender").value=gen;
		document.f3.action="setprofile";
		document.f3.submit();
	}
}
</script>
</head>
<%  String userid=null;
userid =(String)session.getAttribute("userid");
if(userid==null){
	Cookie[] ch=request.getCookies();

for(int i=0;i<ch.length;i++){
	String c=ch[i].getName();
	if(c.equals("userid")){
		userid=ch[i].getValue();
		break;
	}
}}
if(userid==null){
	RequestDispatcher view=request.getRequestDispatcher("login.jsp");
	view.include(request,response);
}else{%>
<body style="background:linear-gradient(green,white)">
<table border="0" width="100%" height="100%"><form name="f3" method="post">
<tr><td width="80" height="90" valign="top"><jsp:include page="header.jsp" /></td></tr>
<tr><td align="center" valign="middle">
<table border="0" id="block1" cellpadding="5px">
<tr><td colspan="3" align="right" height="10"><input id="next" type="button" value="Next" onclick="subm()" disabled/><input type="hidden" name="gender" id="gender"/></td></tr>
<tr><td align="center" id="cover" onclick="clk('Male')"><img id="pic" class="Male" src="img/boy.gif" alt="Male"/><br><br><font color="#79bdff">I am a<br>Male</font></td>
<td><hr width="1" size="350" color="#dfdfdf"></td>
<td align="center" id="cover" onclick="clk('Female')"><img id="pic" class="Female" src="img/girl.gif" alt="Female"/><br><br><font color="#ffa2d0">I am a<br>Female</font></td></tr>
</table>
</td></tr>
</form></table>
</body>
<%}%>
</html>