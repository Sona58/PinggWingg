<html>
<head><title>PinggWingg</title>
<style>
#block1{
	background:linear-gradient(orange,white);
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
	color:#EB214A;
	cursor:hand;
}
#skip{
	background:Transparent;
	outline:none;
	font-size:25px;
	font-weight:bold;
	border:none;
	color:#EB214A;
	cursor:hand;
	padding-right:50px;
}
#name{
	font-size:25px;
	background:Transparent;
	border:0px;
	border-bottom:1px solid #008000;
	padding:5px;
	outline:none;
}
#edit{
	width:350;
	height:350;
	border:10px solid #cdcdcd;
}
</style>
<%@ page import="java.io.*" %>
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

function subm(){
	f4.action="setprofilepic";
	f4.submit();
}
</script>
</head>
<% String userid=null;
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
}else{%>
<body style="background:linear-gradient(green,white)">
<%@ page import="java.sql.*" %>
<table border="0" width="100%" height="100%"><form name="f4" method="post" enctype="multipart/form-data">
<tr><td width="80" height="90" valign="top"><jsp:include page="header.jsp" /></td></tr>
<tr><td align="center" valign="middle">
<table border="0" id="block1" cellpadding="10px">
<tr><td align="right" height="10" colspan="3"><a href="main.jsp" target="_parent"><input id="skip" type="button" value="Skip"/></a><input id="next" type="button" value="Next" onclick="subm()"/></td></tr>
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
			String imag=rs.getString("image");
			String namem=rs.getString("name");
	%>
<tr><td align="center" id="pic"><img src="img/<%= imag%>" alt="edit" id="edit"/><img style="cursor:hand" src="img/edit.png" width="20" height="20" onclick="chngpic()"/><input id="imag" type="file" accept="image/*" name="imagee" style="display:none;" onchange="imags()"/></td></tr>
<tr><td align="center"><input id="name" type="text" name="namee" value="<%= namem%>" size="27"/></td></tr>
<% }
	}catch(Exception e){System.out.println(e);}%>
</table>
</td></tr>
</form></table>
</body><% } %>
</html>