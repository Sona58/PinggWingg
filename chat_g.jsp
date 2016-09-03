<html>
<head><title>PinggWingg</title>
<style>
body{
	background:linear-gradient(orange,white);
}
#chat_main{
	background:#ededed;
	border-top-left-radius:20px;
	border-top-right-radius:20px;
}
#chat_window{
	box-shadow:0 0 15px 5px #cdcdcd;
}
#setting{
	background:#cdcdcd;
	display:none;
	float:right;
	margin-top:-550px;
	margin-left:1050px;
	position:absolute;
}
#setting.horizontal{
	display:inline-block;
	z-index:1000;
}
</style>
<script>
function show_theme(){
	document.querySelector("#setting").style.display="block";
}
function hide_theme(){
	document.querySelector("#setting").style.display="none";
}
</script>
</head>
<%@ page import="java.sql.*" %>
<% String userid=null;
userid=(String)session.getAttribute("userid");
if(userid==null){
	Cookie[] ch=request.getCookies();

for(int j=0;j<ch.length;j++){
	String c=ch[j].getName();
	if(c.equals("userid")){
		userid=ch[j].getValue();
		break;
	}
}}
if(userid==null){
	RequestDispatcher view=request.getRequestDispatcher("login.jsp");
	view.include(request,response);
}else{
	String i=request.getParameter("i");
	
	Connection con;
	Statement stmt;
	ResultSet rs;
	String chat=null;
	String chatid=null;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
		stmt=con.createStatement();
		rs=stmt.executeQuery("select * from chat where (name="+userid+" and name2="+i+") or (name="+i+" and name2="+userid+")");
		if(rs.next()){
			chat=rs.getString("theme");
			chatid=rs.getString("cid");
		}
		rs=stmt.executeQuery("select * from user where userid="+i);
		if(rs.next()){
			String name=rs.getString("name");
			String imag=rs.getString("image");
	%>
<body><center>
<table border="0" width="100%" height="100%">
<tr><td height="90"><jsp:include page="header.jsp" /></td></tr>
<tr><td align="center">
<table id="chat_main" border="0" width="90%" height="100%" cellpadding="0" cellspacing="0">
<tr><td colspan="2" height="50" align="right" valign="middle" style="padding-right:10px;"><%if(chat!=null){%><img src="img/brush.png" width="30" height="30" style="cursor:hand" onclick="show_theme()"/><%}%></td></tr>
<tr><td id="chat_window" style="background:url(img/<% if(chat==null){%>chat1.jpg<%}else{%><%= chat%><%}%>);background-size:cover;"><jsp:include page="chatmain_g.jsp" /></td>
<td style="background:#ededed;box-shadow:0 0 15px 5px #cdcdcd;" width="250" valign="top"><jsp:include page="chatdis.jsp" /></td></tr>
</table>
</td>
</tr>
</table></td></tr>
</table>

<div id="setting">
<div align="center"><img src="img/cross.png" width="20" height="20" onclick="hide_theme()"/></div>
	<div class="horizontal">
		<a href="themechange.jsp?i=<%= i%>&cid=<%= chatid%>&type=group&theme=chat1.jpg" target="_parent"><img src="img/chat1.jpg" width="50" height="50"/></a>
		<a href="themechange.jsp?i=<%= i%>&cid=<%= chatid%>&type=group&theme=chat2.jpg" target="_parent"><img src="img/chat2.jpg" width="50" height="50"/></a>
		<a href="themechange.jsp?i=<%= i%>&cid=<%= chatid%>&type=group&theme=chat3.jpg" target="_parent"><img src="img/chat3.jpg" width="50" height="50"/></a>
		<a href="themechange.jsp?i=<%= i%>&cid=<%= chatid%>&type=group&theme=chat4.png" target="_parent"><img src="img/chat4.png" width="50" height="50"/></a>
	</div>
	<div class="horizontal">
		<a href="themechange.jsp?i=<%= i%>&cid=<%= chatid%>&type=group&theme=chat5.jpg" target="_parent"><img src="img/chat5.jpg" width="50" height="50"/></a>
		<a href="themechange.jsp?i=<%= i%>&cid=<%= chatid%>&type=group&theme=chat6.jpg" target="_parent"><img src="img/chat6.jpg" width="50" height="50"/></a>
		<a href="themechange.jsp?i=<%= i%>&cid=<%= chatid%>&type=group&theme=chat7.jpg" target="_parent"><img src="img/chat7.jpg" width="50" height="50"/></a>
		<a href="themechange.jsp?i=<%= i%>&cid=<%= chatid%>&type=group&theme=chat8.jpg" target="_parent"><img src="img/chat8.jpg" width="50" height="50"/></a>
	</div>
	<div class="horizontal">
		<a href="themechange.jsp?i=<%= i%>&cid=<%= chatid%>&type=group&theme=chat9.jpg" target="_parent"><img src="img/chat9.jpg" width="50" height="50"/></a>
		<a href="themechange.jsp?i=<%= i%>&cid=<%= chatid%>&type=group&theme=chat10.jpg" target="_parent"><img src="img/chat10.jpg" width="50" height="50"/></a>
		<a href="themechange.jsp?i=<%= i%>&cid=<%= chatid%>&type=group&theme=chat11.jpg" target="_parent"><img src="img/chat11.jpg" width="50" height="50"/></a>
		<a href="themechange.jsp?i=<%= i%>&cid=<%= chatid%>&type=group&theme=chat12.jpg" target="_parent"><img src="img/chat12.jpg" width="50" height="50"/></a>
	</div>
	<div class="horizontal">
		<a href="themechange.jsp?i=<%= i%>&cid=<%= chatid%>&type=group&theme=chat13.jpg" target="_parent"><img src="img/chat13.jpg" width="50" height="50"/></a>
		<a href="themechange.jsp?i=<%= i%>&cid=<%= chatid%>&type=group&theme=chat14.jpg" target="_parent"><img src="img/chat14.jpg" width="50" height="50"/></a>
		<a href="themechange.jsp?i=<%= i%>&cid=<%= chatid%>&type=group&theme=chat15.png" target="_parent"><img src="img/chat15.png" width="50" height="50"/></a>
		<a href="themechange.jsp?i=<%= i%>&cid=<%= chatid%>&type=group&theme=chat16.jpg" target="_parent"><img src="img/chat16.jpg" width="50" height="50"/></a>
	</div>
</div>
</center></body>
<%
		}
	}catch(Exception e){System.out.println(e);}
}%>
</html>