<html>
<%@ page import="java.sql.*,java.util.*"%>
<%
String userid=(String)session.getAttribute("userid");
session.invalidate();
Cookie ch=new Cookie("userid",null);
ch.setMaxAge(0);
response.addCookie(ch);
Connection con=null;
Statement stmt=null;
try{
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
	stmt=con.createStatement();
	stmt.execute("delete from login where uid="+userid);
	Calendar c1=new GregorianCalendar();
	int d2=c1.get(Calendar.MONTH)+1;
	String d1=c1.get(Calendar.YEAR)+"-"+d2+"-"+c1.get(Calendar.DAY_OF_MONTH);
	String t1=c1.get(Calendar.HOUR_OF_DAY)+":"+c1.get(Calendar.MINUTE);
	stmt.execute("update user set last_login='"+d1+"', last_seen='"+t1+"' where userid="+userid);
}catch(Exception e){System.out.println(e);}
RequestDispatcher view=request.getRequestDispatcher("login.jsp");
view.forward(request,response);
%>
</html>