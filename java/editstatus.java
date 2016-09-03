import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class editstatus extends HttpServlet{
	
	Connection con;
	Statement stmt;
	ResultSet rs;
	
	public editstatus(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
			stmt=con.createStatement();
		}catch(Exception e){System.out.println(e);}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		String status=request.getParameter("status");
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
			Calendar c1=new GregorianCalendar();
				int d2=c1.get(Calendar.MONTH)+1;
				String d1=c1.get(Calendar.YEAR)+"-"+d2+"-"+c1.get(Calendar.DAY_OF_MONTH);
			stmt.execute("update user set status='"+status+"',status_date='"+d1+"' where userid="+userid);
			RequestDispatcher view=request.getRequestDispatcher("status.jsp");
			view.forward(request,response);
		}catch(Exception e){System.out.println(e);}
	}
}