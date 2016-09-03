import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class message1 extends HttpServlet{
	
	Connection con;
	Statement stmt,stmt1;
	ResultSet rs,rs1;
	
	public message1(){
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
				}
			}
			String n2=request.getParameter("i");
			String msg=request.getParameter("msg");
			msg=msg.trim();
			msg=msg.replaceAll("(\\s*<[Bb][Rr]\\s*/?>)+\\s*$", "");
			Calendar c1=new GregorianCalendar();
			int d2=c1.get(Calendar.MONTH)+1;
			String chatid=null;
			String d1=c1.get(Calendar.YEAR)+"-"+d2+"-"+c1.get(Calendar.DAY_OF_MONTH);
			String t1=c1.get(Calendar.HOUR_OF_DAY)+":"+c1.get(Calendar.MINUTE);
			rs=stmt.executeQuery("select * from chat where (name="+userid+" and name2="+n2+") or (name="+n2+" and name2="+userid+") and type='group'");
			if(rs.next()){
				chatid=rs.getString("cid");
			}
			else{
				
				stmt1=con.createStatement();
				stmt1.execute("insert into chat(name,name2,theme,ddate,type) values("+userid+","+n2+",'chat1.jpg','"+d1+"','group')");
				rs1=stmt1.executeQuery("select * from chat where name="+userid+" and name2="+n2+" and type='group'");
				if(rs1.next()){
					chatid=rs1.getString("cid");
				}
				stmt1.execute("insert into message(personid,chatid,ddate,dtime,message,delivered,read_flag,type,chat_type) values("+userid+","+chatid+",'"+d1+"','"+t1+"','"+d1+"','1','1','date','group')");
			}
			int cmp=t1.compareTo("00:00");
			if(cmp>=0){
				rs=stmt.executeQuery("select * from message where message='"+d1+"'");
				if(!rs.next()){
					stmt.execute("insert into message(personid,chatid,ddate,dtime,message,delivered,read_flag,type,chat_type) values("+userid+","+chatid+",'"+d1+"','"+t1+"','"+d1+"','1','1','date','group')");
				}
			}

			stmt.execute("insert into message(personid,chatid,ddate,dtime,message,delivered,read_flag,type,chat_type) values("+userid+","+chatid+",'"+d1+"','"+t1+"','"+msg+"','0','0','text','group')");
			RequestDispatcher view=request.getRequestDispatcher("chat_g.jsp?i="+n2);
			view.forward(request,response);
		}catch(Exception e){System.out.println(e);}
	}
}