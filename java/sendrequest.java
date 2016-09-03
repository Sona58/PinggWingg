import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class sendrequest extends HttpServlet{

	Connection con;
	Statement stmt;
	ResultSet rs;
	
	public sendrequest(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
			stmt=con.createStatement();
		}catch(Exception e){System.out.println(e);}
	}
	
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		try{
			String u=request.getParameter("u");
			String i=request.getParameter("i");
			stmt.execute("insert into frequest(sender,receiver) values("+u+","+i+")");
			RequestDispatcher view=request.getRequestDispatcher("main.jsp");
			view.forward(request,response);
		}catch(Exception e){System.out.println(e);}
	}
}