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
#main{
	background:#ffff00;
	box-shadow:0 0 15px 5px #ffff00;
	border-radius:10px;
	overflow:auto;
}
#main table td{
	font-size:25px;
	font-family:Arial;
}
input[type=text]{
	font-size:25px;
	outline:none;
	border:none;
	border-bottom:thin solid green;
	background:yellow;
}
input[type=checkbox]{
	width:30px;
	height:30px;
}
input[type=submit]{
	padding:5px;
	font-size:15px;
	background:#ffff00;
	color:red;
	border:thin solid red;
	outline:none;
	cursor:hand;
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

</script>
</head>
<body>
<%@ page import="java.sql.*" %>
<center>
<table border="0" width="100%" height="100%">
<tr><td height="90"><jsp:include page="header.jsp" /></td></tr>
<tr><td align="center">
<table border="0" cellspacing="0" cellpadding="10" width="50%" height="100%" id="main">
<tr><td valign="top"><table width="100%" cellpadding="10px"><form action="group" method="post">
<tr><td><input type="text" name="gname" placeholder="Group Name" size="45" id="gname"/></td><td><input id="next" type="submit" value="Next"></td></tr>
<tr><td><br>Select Members:</td></tr>

<%
Connection con;
Statement stmt,stmt1;
ResultSet rs,rs1;
try{
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
	stmt=con.createStatement();
	rs=stmt.executeQuery("select * from friends where person1="+userid+" or person2="+userid);
	while(rs.next()){
		String uid;
		String person1=rs.getString("person1");
		String person2=rs.getString("person2");
		if(person1.equals(userid)){
			uid=person2;
		}else{
			uid=person1;
		}
		stmt1=con.createStatement();
		rs1=stmt1.executeQuery("select * from user where userid="+uid);
		if(rs1.next()){
			String name=rs1.getString("name");
			name=name.substring(0,1).toUpperCase()+name.substring(1).toLowerCase();
			String imge=rs1.getString("image");%>
			<tr><td valign="middle">
			<input type="checkbox" name="parti" value="<%= uid%>" id="parti"/> <img src="img/<%= imge%>" width="40" height="40" style="border-radius:20px;"/> <%= name%>
			</td></tr>
		<%}
	}
}catch(Exception e){System.out.println(e);}
%></form>
</table></td></tr>
</table>
</td></tr>
</table>
</center></body>
</html>
<%
}%>