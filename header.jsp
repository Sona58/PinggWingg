<html>
<head><title>Header</title>
</head>
<body>
<%@ page import="java.sql.*" %>
<style>
a{
	text-decoration:none;
	color:#000000;
}
.btn {
  border-radius: 4px;
  background-color:rgba(255,255,255,0.4);
  font-family: Arial;
  font-size: 14px;
  padding: 10px 20px 10px 20px;
  border: thin solid #FFFFFF ;
  color:#000000;
  font-weight:bold;
  box-shadow: 0 0 15px 5px #808080;
 }

.btn:hover{
background-color:rgba(255,255,255,0.7);
}

#mine{
	border-radius:25px;
	width:50;
	height:50;
	background:white;
	cursor:hand;
}
#account{
	background:#cdcdcd;
	display:none;
	border-color:#cdcdcd;
	border-radius:10px;
	color:#808080;
	font-size:25px;
	font-family:Arial;
	padding:10px;
	position:absolute;
	top:70px;
	right:150px;
}
#account div{
	padding:10px;
	border-radius:10px;
	cursor:hand;
	text-align:center;
}
#account div:hover{
	background:#808080;
	color:#ededed;
	padding:10px;
	border-radius:10px;
}
</style>
<script>
function show_acc(){
	document.querySelector("#account").style.display="block";
}
function hide_acc(){
	document.querySelector("#account").style.display="none";
}
</script>
<%
String userid=null;
userid=(String)session.getAttribute("userid");
if(userid==null){
Cookie[] ch=request.getCookies();

for(int i=0;i<ch.length;i++){
	String c=ch[i].getName();
	if(c.equals("userid")){
		userid=ch[i].getValue();
		break;
	}
}}
%>
<table border="0" width="100%" height="80">
<tr><td valign="top" width="200" style="padding-left:100px"><a href="main.jsp" target="_parent"><img src="img/logo.png" alt="logo" width="200" height="80"/></a></td>
<% if(userid==null){ 
String uri = request.getRequestURI();
String pageName = uri.substring(uri.lastIndexOf("/")+1);
%>
	<td style="padding-right:150px;padding-top:10px" align="right" valign="top">
	<% if(pageName.equals("register.jsp")){ %>
		<a href="login.jsp" target="_parent">
	<% }else{ %>
		<a href="register.jsp" target="_parent">
	<% }%>
	<input class="btn" type="button" value="<% if(pageName.equals("register.jsp")){ %>Login<% }else{ %>Sign Up<% }%>"/>
	</a></td>
<% }else{
	Connection con;
	Statement stmt;
	ResultSet rs;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
		stmt=con.createStatement();
		rs=stmt.executeQuery("select * from user where userid="+userid);
		if(rs.next()){		
			String imag=rs.getString("image");
	%>
	<td style="padding-right:150px;padding-top:10px" align="right" valign="top">
	<div="open_acc" onmouseover="show_acc()" onmouseout="hide_acc()">
		<img id="mine" src="img/<%= imag%>" alt="myaccount"/>
		<div id="account">
			<div><a href="account.jsp" target="_blank">My Account</a></div>
			<div><a href="notifications.jsp" target="_blank">Notifications</a></div>
			<div><a href="status.jsp" target="_blank">Status</a></div>
			<div><a href="logout.jsp" target="_parent">Sign Out</a></div>
		</div>
	</div></td>
<% }
	}catch(Exception e){System.out.println(e);}}%>

</tr>
</table>

</body>
</html>