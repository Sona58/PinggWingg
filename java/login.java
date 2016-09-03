import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class login extends HttpServlet{
	
	Connection con;
	Statement stmt;
	ResultSet rs;
	
	public login(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
			stmt=con.createStatement();
		}catch(Exception e){System.out.println(e);}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		String uname=request.getParameter("uname");
		String password=request.getParameter("pass");
		try{
			rs=stmt.executeQuery("select * from user where username='"+uname+"' and password='"+password+"'");
			if(rs.next()){
				HttpSession session=request.getSession();
				String userid=(String)rs.getString("userid");
				session.setAttribute("userid",userid);
				Cookie ch=new Cookie("userid",userid);
				ch.setMaxAge(24*60*60*365);
				response.addCookie(ch);
				Calendar c1=new GregorianCalendar();
				int d2=c1.get(Calendar.MONTH)+1;
				String d1=c1.get(Calendar.YEAR)+"-"+d2+"-"+c1.get(Calendar.DAY_OF_MONTH);
				String t1=c1.get(Calendar.HOUR_OF_DAY)+":"+c1.get(Calendar.MINUTE);
				stmt.execute("update user set last_login='"+d1+"', last_seen='"+t1+"' where userid="+userid);
				stmt.execute("insert into login values("+userid+")");
				RequestDispatcher view=request.getRequestDispatcher("main.jsp");
				view.forward(request,response);
			}
		}catch(Exception e){System.out.println(e);}
	}
}