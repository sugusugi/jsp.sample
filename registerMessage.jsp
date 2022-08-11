<%@ page contentType="text/html; charset=UTF-8" import="java.net.URLEncoder,java.net.URLDecoder" %>
<%
  session.setMaxInactiveInterval(180);
  request.setCharacterEncoding("UTF-8");
  String msg = request.getParameter("msg");
  if(msg != null){
    msg = URLEncoder.encode(msg,"UTF-8");
    session.setAttribute("msg",msg);
  }
  String sessionMsg = (String)session.getAttribute("msg");
  if(sessionMsg == null){
    sessionMsg = "";
  }else {
    sessionMsg = URLDecoder.decode(sessionMsg);
  }
%>
<!DOCTYPE html>
<html lang="ja" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>リクエストの送信</title>
  </head>
  <body>
    <form action="registerMessage.jsp">
      <input type="text" name="msg" value="<%= sessionMsg%>"><input type="submit" value="送信">
    </form>
    <%
      if(!(sessionMsg.equals(""))){
    %>
      <a href="removeMessage.jsp">セッションの削除</a>
    <%
      }
    %>
  </body>
</html>
