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
function addf(a,b){
	window.location="sendrequest?u="+a+"&i="+b;
}
</script>
</head>
<body>
<%@ page import="java.sql.*,java.util.*,java.text.*,java.util.Date" %>
<center>
<table border="0" width="100%" height="100%">
<tr><td height="90"><jsp:include page="header.jsp" /></td></tr>
<tr><td align="center">
<table border="0" cellspacing="0" cellpadding="10" width="50%" height="100%" id="main">
<tr><td align="center" valign="top" height="80"><b>Tap on the name to start Pinggingg</b></td><td valign="top"><a href="group.jsp" target="_blank"><img src="img/group.png" width="40" height="40"/></a></td></tr>
<tr><td valign="top" colspan="2"><table width="100%" cellspacing="0" cellpadding="15" border="0">
<%
Connection con;
Statement stmt=null,stmt1=null,stmt2=null;
ResultSet rs=null,rs1=null,rs2=null;
String userid2=null;
try{
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
	stmt=con.createStatement();
	rs=stmt.executeQuery("select * from group_member join groups on group_member.gid=groups.gid and group_member.userid="+userid);
	while(rs.next()){
		String gname=rs.getString("group_name");
		String imge=rs.getString("image");
		String gid=rs.getString("gid");
		%>
		<tr><td width="40" valign="top"><img src="img/<%= imge%>" width="40" height="40" id="profile"/></td>
		<td valign="top" style="padding-top:10px"><a href="chat_g.jsp?i=<%= gid%>" target="_parent"><%= gname%></a></td>
		<td valign="top" align="right"></td></tr>
		<%
	}
	rs=stmt.executeQuery("select * from user where userid!="+userid);
	while(rs.next()){
		String imge=rs.getString("image");
		String uname=rs.getString("name");
		String uid=rs.getString("userid");
		String ll=rs.getString("last_login")+" "+rs.getString("last_seen");
		stmt1=con.createStatement();
		rs1=stmt1.executeQuery("select * from chat join message where chat.cid=message.chatid and (message.personid="+userid+" or message.personid="+uid+") and ((chat.name="+userid+" and chat.name2="+uid+") or (chat.name="+uid+" and chat.name2="+userid+")) order by messageid desc limit 1");
		String msg=null;
		if(rs1.next()){
			msg=rs1.getString("message");
		}
		%>
			<tr><td width="40" valign="top"><img src="img/<%= imge%>" width="40" height="40" id="profile"/></td>
			<td valign="top" style="padding-top:10px"><a href="chat.jsp?i=<%= uid%>" target="_parent"><%= uname%></a><%if(msg!=null){%><br><font size="3"><%= msg%></font><%}%></td>
			<td valign="top" align="right">
		<%
		rs1=stmt1.executeQuery("select * from friends where (person1="+userid+" and person2="+uid+") or (person1="+uid+" and person2="+userid+")");
		if(rs1.next()){
			stmt2=con.createStatement();
			rs2=stmt2.executeQuery("select * from login where uid="+uid);
			if(rs2.next()){%>
				<span id="online">&nbsp;&nbsp;&nbsp;&nbsp;</span>
		<%	}else{
				Calendar c1=new GregorianCalendar();
				int d2=c1.get(Calendar.MONTH)+1;
				String d1=c1.get(Calendar.YEAR)+"-"+d2+"-"+c1.get(Calendar.DAY_OF_MONTH)+" "+c1.get(Calendar.HOUR_OF_DAY)+":"+c1.get(Calendar.MINUTE);
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				Date d_d1=df.parse(d1);
				Date d_ll=df.parse(ll);
				long diff1=d_d1.getTime()-d_ll.getTime();
				
				int diff = ((int)diff1)/(1000 * 60 * 60 * 24);
				if(diff<=1){
					int diff2 = ((int)diff1)/(1000 * 60 * 60);
					if(diff2<1){
						int diff3 = ((int)diff1)/(1000 * 60);
						%>
					<font size="4"><%= diff3%>m</font>
					<%
					}else{
					%>
					<font size="4"><%= diff2%>h</font>
					<%}
				}else if(diff<7){
					%>
					<font size="4"><%= diff%>h</font>
					<%
				}
			}
		}
		else{
			rs2=stmt2.executeQuery("select * from frequest where sender="+userid+" and receiver="+uid);
			if(rs2.next()){%>
			<font size="3">Request Sent</font>
				<%
			}else{
			%>
				<img src="img/add.png" width="25" height="25" style="cursor:hand" onclick="addf(<%= userid%>,<%= uid%>)"/>
		<%	}}
%>
</td></tr>
<%
	}
	
}catch(Exception e){System.out.println(e);}
%>
</table>
</td></tr>
</table>
</td></tr>
</table>
</center></body>
</html>
<%
}%>