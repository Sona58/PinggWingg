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
#main td{
	font-size:25px;
	font-family:Arial;
}
#profile{
	border-radius:20px;
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
#online{
    background:green;
    border-radius:20px;
    font-size:10px;
	vertical-align:middle;
	text-align:center;
}
</style>
<script>
function chngpic(){
	document.querySelector("#imag").click();
}
function imags(){
	var reader = new FileReader();
            
            reader.onload = function (e) {
                document.querySelector("#edit").src=e.target.result;
            }
            
            reader.readAsDataURL(document.querySelector("#imag").files[0]);
}
</script>
</head>
<body>
<%@ page import="java.sql.*" %>
<center>
<table border="0" width="100%" height="100%">
<tr><td height="90"><jsp:include page="header.jsp" /></td></tr>
<tr><td align="center">
<table border="0" cellspacing="0" cellpadding="10" width="75%" height="100%" id="main">
<tr><td valign="top" colspan="2"><table width="100%" cellspacing="0" cellpadding="15" border="0"><form action="editimg" method="post" enctype="multipart/form-data">
<%
Connection con;
Statement stmt;
ResultSet rs;
try{
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
	stmt=con.createStatement();
	rs=stmt.executeQuery("select * from user where userid="+userid);
	if(rs.next()){
		String username=rs.getString("username");
		String name=rs.getString("name");
		String imge=rs.getString("image");
		String gender=rs.getString("gender");
		String email=rs.getString("email");
	%>
	<tr></tr>
<tr><td align="center"><img src="img/<%= imge%>" alt="edit" id="edit" width="350" height="350"/><img style="cursor:hand" src="img/edit.png" width="20" height="20" onclick="chngpic()"/><input id="imag" type="file" accept="image/*" name="imagee" style="display:none;" onchange="imags()"/></td></tr>
<tr><td align="center"><input type="submit" value="Upload"/></td></tr>
<%
}
}catch(Exception e){System.out.println(e);}%>
</form></table>
</td></tr>
</table>
</td></tr>
</table>
</center></body>
</html>
<%
}%>