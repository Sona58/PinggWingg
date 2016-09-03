<html>
<body>
<%
String userid=null;
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
RequestDispatcher view;
if(userid==null){
	view=request.getRequestDispatcher("login.jsp");
	view.include(request,response);
}
else{
	view=request.getRequestDispatcher("main.jsp");
	view.include(request,response);
}
%>
</body>
</html>