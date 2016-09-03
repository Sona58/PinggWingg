import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import com.oreilly.servlet.MultipartRequest;

public class editimg extends HttpServlet{
	
	Connection con;
	Statement stmt;
	ResultSet rs;
	
	public editimg(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
			stmt=con.createStatement();
		}catch(Exception e){System.out.println(e);}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		String img=request.getParameter("imagee");
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
			MultipartRequest m=new MultipartRequest(request,getServletContext().getRealPath("/img") ,10000);
			Enumeration files = m.getFileNames();
			String filename=null;
			while(files.hasMoreElements()){
				String name = (String)files.nextElement();
				filename = m.getFilesystemName(name);
			}
			stmt.execute("update user set image='"+filename+"' where userid="+userid);
			
			RequestDispatcher view=request.getRequestDispatcher("account.jsp");
			view.forward(request,response);
		}catch(Exception e){System.out.println(e);}
	}
}