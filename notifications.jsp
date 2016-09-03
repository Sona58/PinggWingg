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
if(userid==null){
	RequestDispatcher view=request.getRequestDispatcher("login.jsp");
	view.include(request,response);
}else{
	%>
<html>
<head><title>PinggWingg</title>
<style>
body{
	background:linear-gradient(orange,white);
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
input[type=button]{
	font-size:15px;
	background:white;
	color:black;
	outline:none;
	border-radius:10px;
	padding:5px;
	border:thin solid purple;
	cursor:hand;
}
#notif{
	background:yellow;
	border-radius:20px;
}
</style>
<script>
function accreq(){
	document.f10.action="accreq";
	document.f10.submit();
}
function decreq(){
	document.f10.action="decreq";
	document.f10.submit();
}
</script>
</head>
<body>
<%@ page import="java.sql.*"%>
<center>
<table border="0" width="100%" height="100%">
<tr><td height="90"><jsp:include page="header.jsp" /></td></tr>
<tr><td align="center">
<table border="0" cellspacing="0" cellpadding="10" width="75%" height="100%" id="notif">
<tr><td align="center" valign="top"><table width="100%"><form name="f10" method="post">
<%
Connection con;
Statement stmt=null,stmt1=null;
ResultSet rs=null,rs1=null;
String uid=null;
try{
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
	stmt=con.createStatement();
	rs=stmt.executeQuery("select * from frequest where receiver="+userid+" order by fid desc");
	while(rs.next()){
		uid=rs.getString("sender");
		stmt1=con.createStatement();
		rs1=stmt1.executeQuery("select * from user where userid="+uid);
		if(rs1.next()){
			String imge=rs1.getString("image");
			String name=rs1.getString("name");
			name=name.substring(0,1).toUpperCase()+name.substring(1).toLowerCase();
		%>
	<tr><td width="40" valign="top"><img src="img/<%= imge%>" width="40" height="40" style="border-radius:20px"/></td><td valign="top" style="padding-top:10px;"><font size="5"><%= name%> send you a friend request</font></td><td align="right" style="padding-top:10px;"><input type="button" value="Accept" onclick="accreq()"/> <input type="button" value="Decline" onclick="decreq()"/><input type="hidden" name="id" value="<%= uid%>"/></td></tr>	
	
	<%}
	}
	if(uid==null){%>
		<tr><td align="center"><font size="5">No Notification</font></td></tr>
	<%}
}catch(Exception e){System.out.println(e);}
%></form>
</table>
</td></tr>
</table>
</td></tr>
</table>
</center></body>
</html>
<%
}%>