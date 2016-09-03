import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class decreq extends HttpServlet{

	Connection con;
	Statement stmt;
	
	public decreq(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
			stmt=con.createStatement();
		}catch(Exception e){System.out.println(e);}
	}
	
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		try{
			String userid=null;
			HttpSession session=request.getSession();
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
			String id=request.getParameter("id");
			stmt.execute("delete from frequest where sender="+id+" and receiver="+userid);
			RequestDispatcher view=request.getRequestDispatcher("main.jsp");
			view.forward(request,response);
		}catch(Exception e){System.out.println(e);}
	}
}