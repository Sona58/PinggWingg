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
	document.f7.action="message";
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
	ResultSet rs1=null,rs2=null,rs3=null;
	
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
	rs1=stmt.executeQuery("select * from user where userid="+ui);
	if(rs1.next()){
		String gender=rs1.getString("gender");
		String imag=rs1.getString("image");
		String name=rs1.getString("name");
		String status=rs1.getString("status");
		String last_login=rs1.getString("last_login");
		String status_date=rs1.getString("status_date");
		String last_seen=rs1.getString("last_seen");
		SimpleDateFormat fromUser = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat myFormat = new SimpleDateFormat("dd/MM/yyyy");
		last_login = myFormat.format(fromUser.parse(last_login));
		myFormat = new SimpleDateFormat("dd MMMMM");
		status_date = myFormat.format(fromUser.parse(status_date));
		fromUser = new SimpleDateFormat("k:m");
		myFormat = new SimpleDateFormat("h:m a");
		last_seen = myFormat.format(fromUser.parse(last_seen));
		Calendar c1=new GregorianCalendar();
		String t1=c1.get(Calendar.HOUR_OF_DAY)+":"+c1.get(Calendar.MINUTE);
		t1 = myFormat.format(fromUser.parse(t1));
		stmt1=con.createStatement();
		rs2=stmt1.executeQuery("select * from login where uid="+ui);
		String userid2=null;
		if(rs2.next()){
		userid2=rs2.getString("uid");}
		int friends=0;
		stmt2=con.createStatement();
		rs3=stmt2.executeQuery("select * from friends where (person1="+userid+" and person2="+ui+") or (person1="+ui+" and person2="+userid+")");
		if(rs3.next()){friends=1;}
		else{friends=0;}
		rs3=stmt2.executeQuery("select * from frequest where sender="+userid+" and receiver="+ui);
		int freq=0;
		if(rs3.next()){freq=1;}else{freq=0;}
	%>	
	
<table width="100%" height="100%" cellspacing="0" border="0" cellpadding="10" style="border-radius:20px;"><form name="f7" method="post">
<tr><td height="40" width="40" style="background:rgba(0,0,0,0.4)"><img src="img/<%if(friends==1){%><%= imag%><%}else{if(gender=="Male"){%>boy.png<%}else{%>2.jpg<%}}%>" height="40" width="40" style="border-radius:20px"/></td>
<td style="background:rgba(0,0,0,0.4);color:#FFFFFF;font-family:Arial;cursor:hand;" valign="middle"><span onclick="shown()"><font size="6px"><%= name%></font></span>
<% 
			if(friends==1){%>
	<br><font size="3px">
	<%if(userid2==null){%>
last seen <%= last_login%> at <%= last_seen%>
<%}else{%>
Online
<%}%>
</font>
<%}else{
	
	if(freq==0){
	
	%>
	<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/add1.png" height="20" width="20" style="cursor:hand" onclick="addf(<%= userid%>,<%= ui%>)"/></span>
	<%}
}%>
</td></tr>
<tr><td colspan="2" style="padding:0"><div id="chat_message">
<%
if(friends==1){
rs2=stmt1.executeQuery("select * from chat where (name="+userid+" and name2="+ui+") or (name="+ui+" and name2="+userid+")");
String chatid=null;
if(rs2.next()){
	chatid=rs2.getString("cid");
}
rs2=stmt1.executeQuery("select * from message where chatid="+chatid+" and chat_type='personal'");
while(rs2.next()){
	String msge=rs2.getString("message");
	String ddate=rs2.getString("ddate");
	String dtime=rs2.getString("dtime");
	fromUser = new SimpleDateFormat("yyyy-MM-dd");
	myFormat = new SimpleDateFormat("dd MMMM yyyy");
	ddate = myFormat.format(fromUser.parse(ddate));
	fromUser = new SimpleDateFormat("k:m");
	myFormat = new SimpleDateFormat("hh:mm a");
	dtime = myFormat.format(fromUser.parse(dtime));
	String n1=rs2.getString("personid");
	String d_fl=rs2.getString("delivered");
	String r_fl=rs2.getString("read_flag");
	String ty=rs2.getString("type");
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
		<div id="<%= flag%>"><%= msge%> <span id="dtime"><%= dtime%></span></div>
	<%}
}}
else{%>
	<center><font size="5">You need to be friends to start Pinggingg.</a></center>
<%}
%>
</div></td></tr>
<%if(friends==1){%>
<tr><td colspan="2" style="padding:5px" height="60" valign="bottom"><div id="message" contenteditable></div> <input type="hidden" name="msg" id="msg"/><input type="hidden" name="i" value="<%= ui%>"/><input type="hidden" name="type" value="personal"/><input type="submit" value="Send" onclick="return div_show()"/></td></tr><%}%></form>
</table>

<div id="details">
<table cellspacing="0" width="100%" border="0">
<tr><td colspan="2" align="right"><img src="img/cross.png" width="20" height="20" onclick="hiden()" style="cursor:hand;"/></td></tr>
<tr><td id="chat_name1" valign="bottom" height="400" width="350" style="background:url(img/<%if(friends==1){%><%= imag%><%}else{if(gender=="Male"){%>boy.png<%}else{%>2.jpg<%}}%>) no-repeat center center;background-size:cover"><%= name%>
<% if(friends==1){%>
	<br><font size="3px">
	<%if(userid2==null){%>
last seen <%= last_login%> at <%= last_seen%>
<%}else{%>
Online
<%}%>
</font>
<%}else{
	if(freq==0){%>
	<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/add1.png" height="20" width="20" style="cursor:hand" onclick="addf(<%= userid%>,<%= ui%>)"/></span>
	<%}
}%></td></tr>
<%if(friends==1){%>
<tr><td style="padding:10px;"><table border="0" cellpadding="10" id="chat_name2" width="100%"><tr><td style="color:#238f23;border-bottom:1px solid #cdcdcd;">Status</td><td align="right" style="color:#cdcdcd;border-bottom:1px solid #cdcdcd;"><%= status_date%></td></tr><tr><td colspan="2"><%= status%></td></tr></table></td></tr><%}%>
</table> 
</div>
<%
	}
}catch(Exception e){System.out.println(e);}
%>