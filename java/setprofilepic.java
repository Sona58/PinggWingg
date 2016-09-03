import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.oreilly.servlet.MultipartRequest;

public class setprofilepic extends HttpServlet{
	Connection con;
	Statement stmt;
	ResultSet rs;
		
	public setprofilepic(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
			stmt=con.createStatement();
		}catch(Exception e){System.out.println(e);}
	}
	
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
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
			}
		}
		try{
			MultipartRequest m=new MultipartRequest(request,getServletContext().getRealPath("/img") ,10000);
			String fname=m.getParameter("namee");
			Enumeration files = m.getFileNames();
			String filename=null;
			while(files.hasMoreElements()){
				String name = (String)files.nextElement();
				filename = m.getFilesystemName(name);
			}
			stmt.execute("update user set name='"+fname+"',image='"+filename+"' where userid="+userid);
			RequestDispatcher view=request.getRequestDispatcher("main.jsp");
			view.forward(request,response);
		}catch(Exception e){System.out.println(e);}
	}
}