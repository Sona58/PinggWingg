import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class group extends HttpServlet{
	
	Connection con;
	Statement stmt;
	ResultSet rs;
	
	public group(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost/pinggwingg","root","");
			stmt=con.createStatement();
		}catch(Exception e){System.out.println(e);}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		String gname=request.getParameter("gname");
		String[] parti=request.getParameterValues("parti");
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
			stmt.execute("insert into groups(ddate,group_name) values('"+d1+"','"+gname+"')");
			rs=stmt.executeQuery("select * from groups order by gid desc limit 1");
			if(rs.next()){
				String gid=rs.getString("gid");
				stmt.execute("insert into group_member(gid,userid,ddate) values("+gid+","+userid+",'"+d1+"')");
				for(String n:parti){
					stmt.execute("insert into group_member(gid,userid,ddate) values("+gid+","+n+",'"+d1+"')");
				}
				stmt.execute("insert into chat(name,theme,name2,type,ddate) values("+userid+",'chat1.jpg',"+gid+",'group','"+d1+"')");
			}
			RequestDispatcher view=request.getRequestDispatcher("main.jsp");
			view.forward(request,response);
		}catch(Exception e){System.out.println(e);}
	}
}