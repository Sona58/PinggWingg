import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class setprofile extends HttpServlet{
	
	Connection con;
	Statement stmt;
	
	public setprofile(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
			stmt=con.createStatement();
		}catch(Exception e){System.out.println(e);}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		try{
			String userid=null;
			HttpSession ses=request.getSession();
			userid=(String)ses.getAttribute("userid");
			if(userid==null){
			Cookie[] ch=request.getCookies();
			for(int i=0;i<ch.length;i++){
				String c=ch[i].getName();
				if(c.equals("userid")){
					userid=ch[i].getValue();
					break;
				}
			}}
			String gen=request.getParameter("gender");
			
			String pic;
			if(gen.equals("Male")){
				pic="boy.png";
			}
			else{
				pic="girl.png";
			}
			stmt.execute("update user set gender='"+gen+"',image='"+pic+"' where userid="+userid);
			RequestDispatcher view=request.getRequestDispatcher("setprofilepic.jsp");
			view.forward(request,response);
		}catch(Exception e){System.out.println(e);}
	}
}