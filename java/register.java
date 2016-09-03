import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class register extends HttpServlet{
	
	Connection con;
	Statement stmt,stmt1;
	ResultSet rs;

	public register(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
			stmt=con.createStatement();
		}catch(Exception e){System.out.println(e);}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		String uname,pass,email,doj;
		uname=request.getParameter("uname");
		pass=request.getParameter("pass");
		email=request.getParameter("email");
		Calendar c1=new GregorianCalendar();
		int d2=c1.get(Calendar.MONTH)+1;
		String d1=c1.get(Calendar.YEAR)+"-"+d2+"-"+c1.get(Calendar.DAY_OF_MONTH);
		String t1=c1.get(Calendar.HOUR_OF_DAY)+":"+c1.get(Calendar.MINUTE);
		try{
			stmt.execute("insert into user(username,name,email,password,doj,last_login,last_seen,usertype,status,status_date) values('"+uname+"','"+uname+"','"+email+"','"+pass+"','"+d1+"','"+d1+"','"+t1+"','Customer','Available','"+d1+"')");
			rs=stmt.executeQuery("select userid from user where username='"+uname+"' and password='"+pass+"'");
			if(rs.next()){
				HttpSession session=request.getSession(true);
				String userid=(String)rs.getString("userid");
				session.setAttribute("userid",userid);
				Cookie c=new Cookie("userid",userid);
				c.setMaxAge(24*60*60*365);
				response.addCookie(c);
				stmt1=con.createStatement();
				stmt1.execute("insert into login values("+userid+")");
				RequestDispatcher view=request.getRequestDispatcher("setprofile.jsp");
				view.forward(request,response);
			}
		}catch(Exception e){System.out.println(e);}
	}
}