<html>
<%
session.invalidate();
Cookie ch=new Cookie("userid",null);
ch.setMaxAge(0);
response.addCookie(ch);
%>
</html>