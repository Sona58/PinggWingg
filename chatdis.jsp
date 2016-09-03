<table border="0" cellspacing="0" cellpadding="10" width="100%" id="main">
<%@ page import="java.sql.*,java.util.*,java.util.Date,java.text.*"%>
<style>
a{
	color:#000000;
	font-size:15px;
	font-family:Arial;
}
#main{
	padding:5px;
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
}
#profile{
	border-radius:20px;
}
</style>
<%
String userid=null;
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
Connection con;
Statement stmt,stmt1,stmt2;
ResultSet rs,rs1,rs2;
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
		String ll=null;
		stmt1=con.createStatement();
		rs1=stmt1.executeQuery("select * from user where userid="+uid);
		if(rs1.next()){
			String name=rs1.getString("name");
			String imge=rs1.getString("image");
			ll=rs1.getString("last_login")+" "+rs1.getString("last_seen");
			%>
			<tr><td width="40"><img src="img/<%= imge%>" width="40" height="40" id="profile"/></td>
			<td valign="middle"><a href="chat.jsp?i=<%= uid%>" target="_parent"><%= name%></a> </td>
			<td valign="middle" align="right">
			<%
		}
		
		stmt2=con.createStatement();
		rs2=stmt2.executeQuery("select * from login where uid="+uid);
		if(rs2.next()){%>
				<span id="online">&nbsp;&nbsp;&nbsp;&nbsp;</span>
		<%}else{
			
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
		%>
		</td></tr>
		<%
	}
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
}catch(Exception e){System.out.println(e);}
%>

</table>