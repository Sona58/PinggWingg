<%@ page import="java.sql.*"%>
<%
	String chatid=request.getParameter("cid");
	String i=request.getParameter("i");
	String type=request.getParameter("type");
	String theme=request.getParameter("theme");
	Connection con;
	Statement stmt;
	ResultSet rs;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
		stmt=con.createStatement();
		stmt.execute("update chat set theme='"+theme+"' where cid="+chatid+" and type='"+type+"'");
		if(type.equals("group")){
			response.sendRedirect("chat_g.jsp?i="+i);
		}else{
			response.sendRedirect("chat.jsp?i="+i);
		}
	}catch(Exception e){System.out.println(e);}
%>