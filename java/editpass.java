import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class editpass extends HttpServlet{
	
	Connection con;
	Statement stmt;
	ResultSet rs;
	
	public editpass(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
			stmt=con.createStatement();
		}catch(Exception e){System.out.println(e);}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		String current=request.getParameter("current");
		String newpas=request.getParameter("new");
		String confirm=request.getParameter("confirm");
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
			
			stmt.execute("update user set password='"+newpas+"' where userid="+userid);
			RequestDispatcher view=request.getRequestDispatcher("account.jsp");
			view.forward(request,response);
		}catch(Exception e){System.out.println(e);}
	}
}