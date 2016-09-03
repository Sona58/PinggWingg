<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Calendar,java.util.GregorianCalendar,java.util.*" %>
<style>

a{
	text-decoration:none;
	color:#FFFFFF;
}

#details{
	display:none;
	position:absolute;
	transform: translate(-50%, -50%);
	top:50%;
	left:50%;
	background:#ededed;
	overflow-y:auto;
	width:600px;
	height:600px;
	box-shadow:0 0 15px 5px #808080;
}
#chat_name1{
	padding:10px;
	color:#FFFFFF;
	font-size:40px;
	font-family:Arial;
	text-shadow:1px 2px #808080;
}
#chat_name2{
	border-radius:5px;
	border-collapse:collapse;
	box-shadow:0 0 15px 5px #cdcdcd;
	padding:10px;
	color:#000000;
	background:#FFFFFF;
	font-size:25px;
	font-family:Arial;
}
#chat_message{
	overflow-y:auto;
	overflow-x:hidden;
	height:380px;
	padding:10px;
}
#message{
	font-size:20px;
	font-family:Arial;
	outline:none;
	border:thin solid #cdcdcd;
	border-radius:10px;
	appearance: textfield;
   	background-color: white;
    width: 750px; 
	display:inline-block;
	padding:5px;
}
input[type=submit]{
	background:#ededed;
	border-radius:20px;
	border:thin solid #cdcdcd;
	color:#000000;
	width:80px;
	height:35px;
	padding:5px;
	font-size:20px;
	display:inline-block;
	cursor:hand;
	outline:none;
}
#ddate{
	padding:5px;
	font-size:15px;
	border-radius:10px;
	margin: 20px;
	width:95%;
	position:relative;
	float:left;
	background:#8db1f2;
	font-family:Arial;
	text-align:center;
	color:#000000;
}
#dtime{
	font-size:10px;
	color:#cdcdcd;
}
#me{
	background:#e1ffb3;
	border-color:#e1ffb3;
    margin: 10px;
    padding: 5px;
    position: relative;
	float:right;
	clear:both;
	font-size:20px;
	font-family:Arial;
	border-radius:5px;
}
#me:after {
   content: "";
   position: absolute;
   top: 0px;
   right: -18px;
   border-top: 10px solid blue;
   border-top-color: inherit; 
   border-right: 20px solid transparent;
}
#you{
	background:#FFFFFF;
	border-color:#FFFFFF;
    margin: 10px;
    padding: 5px;
    position: relative;
	float:left;
	clear:both;
	font-size:20px;
	font-family:Arial;
	border-radius:5px;
}
#you:after {
   content: "";
   position: absolute;
   top: 0px;
   left: -18px;
   border-top: 10px solid blue;
   border-top-color: inherit; 
   border-left: 20px solid transparent;
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
window.onload=function(){
	var out = document.getElementById("chat_message");
    var isScrolledToBottom = out.scrollHeight - out.clientHeight;
    if(isScrolledToBottom)
      out.scrollTop = out.scrollHeight - out.clientHeight;
	var out = document.getElementById("body");
    var isScrolledToBottom = out.scrollHeight - out.clientHeight;
    if(isScrolledToBottom)
      out.scrollTop = out.scrollHeight - out.clientHeight;
}
function shown(){
	document.querySelector("#details").style.display="block";
}
function hiden(){
	document.querySelector("#details").style.display="none";
}
function div_show(){
	var div_text=document.querySelector("#message").innerHTML;
	document.querySelector("#msg").value=div_text;
	document.f7.action="message1";
	return true;
}
function addf(a,b){
	window.location="sendrequest?u="+a+"&i="+b;
}
</script>

<%
String ui=request.getParameter("i");
try{
	Connection con;
	Statement stmt=null,stmt1=null,stmt2=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;
	
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
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
	stmt=con.createStatement();
	rs=stmt.executeQuery("select * from groups join group_member on groups.gid="+ui+" and groups.gid=group_member.gid");
	if(rs.next()){
		String imag=rs.getString("image");
		String gname=rs.getString("group_name");		
		
	%>	
	
		<table width="100%" height="100%" cellspacing="0" border="0" cellpadding="10" style="border-radius:20px;"><form name="f7" method="post">
		<tr><td height="40" width="40" style="background:rgba(0,0,0,0.4)"><img src="img/<%= imag%>" height="40" width="40" style="border-radius:20px"/></td>
		<td style="background:rgba(0,0,0,0.4);color:#FFFFFF;font-family:Arial;cursor:hand;" valign="middle"><span onclick="shown()"><font size="6px"><%= gname%></font></span></td></tr>
		<tr><td colspan="2" style="padding:0"><div id="chat_message">
<%
		stmt1=con.createStatement();
		rs1=stmt1.executeQuery("select * from chat where type='group' and name2="+ui);
		String chatid=null;
		String admin=null;
		if(rs1.next()){
			chatid=rs1.getString("cid");
			admin=rs1.getString("name");
		}
		
		rs1=stmt1.executeQuery("select * from message where chatid="+chatid+" and chat_type='group'");
		while(rs1.next()){
			String msge=rs1.getString("message");
			String ddate=rs1.getString("ddate");
			String dtime=rs1.getString("dtime");
			SimpleDateFormat fromUser;
			SimpleDateFormat myFormat;
			fromUser = new SimpleDateFormat("yyyy-MM-dd");
			myFormat = new SimpleDateFormat("dd MMMM yyyy");
			ddate = myFormat.format(fromUser.parse(ddate));
			fromUser = new SimpleDateFormat("k:m");
			myFormat = new SimpleDateFormat("hh:mm a");
			dtime = myFormat.format(fromUser.parse(dtime));
			String n1=rs1.getString("personid");
			String d_fl=rs1.getString("delivered");
			String r_fl=rs1.getString("read_flag");
			String ty=rs1.getString("type");
			String udid=null;
			stmt2=con.createStatement();
			rs2=stmt2.executeQuery("select * from user where userid="+n1);
			if(rs2.next()){udid=rs2.getString("name");}
			if(ty.equals("date")){
				
			%>
			<div id="ddate"><%= ddate%></div>
			<%
			}else if(ty.equals("text")){
				String flag=null;
				if(n1.equals(userid)){
					flag="me";
				}else{
					flag="you";
				}
				%>
				<div id="<%= flag%>"><%if(flag.equals("you")){%><font color="red" size="2"><%= udid%></font><br><%}%><%= msge%> <span id="dtime"><%= dtime%></span></div>
			<%}
		}
		
%>		</div></td></tr>
		<tr><td colspan="2" style="padding:5px" height="60" valign="bottom"><div id="message" contenteditable></div> <input type="hidden" name="msg" id="msg"/><input type="hidden" name="type" value="group"/><input type="hidden" name="i" value="<%= ui%>"/><input type="submit" value="Send" onclick="return div_show()"/></td></tr></form>
		</table>

		<div id="details">
		<table cellspacing="0" width="100%" border="0">
		<tr><td colspan="2" align="right"><img src="img/cross.png" width="20" height="20" onclick="hiden()" style="cursor:hand;"/></td></tr>
		<tr><td id="chat_name1" valign="bottom" height="400" width="350" style="background:url(img/<%= imag%>) no-repeat center center;background-size:cover"><%= gname%>
		</font>
		</td></tr>
		<tr><td style="padding:10px;"><table border="0" cellpadding="10" id="chat_name2" width="100%"><tr><td style="color:#238f23;border-bottom:1px solid #cdcdcd;">Members</td></tr>
<%

		rs1=stmt1.executeQuery("select * from group_member where gid="+ui);
		while(rs1.next()){
			
			String id=rs1.getString("userid");
			stmt2=con.createStatement();
			rs2=stmt2.executeQuery("select * from user where userid="+id);
			
			if(rs2.next()){
				
				String imge=rs2.getString("image");
				String name=rs2.getString("name");
			%>
				<tr><td><img src="img/<%= imge%>" width="40" height="40" style="border-radius:20px"/> <%= name%> <%if(id.equals(admin)){%><font color="#cdcdcd">(Admin)</font><%}%></td></tr>
<%			}
		}

%>
		</table></td></tr>
		</table> 
		</div>
<%	}

}catch(Exception e){System.out.println(e);}
%>