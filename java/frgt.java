import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class frgt extends HttpServlet{

	Connection con;
	Statement stmt;
	ResultSet rs;
	
	public frgt(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
			stmt=con.createStatement();
		}catch(Exception e){System.out.println(e);}
	}
	
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		try{
			String email=request.getParameter("email");
			response.setContentType("text/html");
			PrintWriter out=response.getWriter();
			rs=stmt.executeQuery("select * from user where email='"+email+"'");
			if(rs.next()){
				String name=rs.getString("username");
				String pass=rs.getString("password");
				String subject="PinggWingg: Password Reset Code";  
				String msg="UserName: "+name+"\nPassword: "+pass;  
					  
				Mailer.send(email, subject, msg);  
				out.print("<center><h2>Password has been sent to your email id</h2></center>");  
			}else{
				out.println("Email id not registered with us.");
				RequestDispatcher view=request.getRequestDispatcher("frgtpass.jsp");
				view.include(request,response);
			}
		}catch(Exception e){System.out.println(e);}
	}
}