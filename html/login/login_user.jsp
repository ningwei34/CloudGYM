<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.user.model.*"%>

<%
  response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  response.setHeader("Pragma","no-cache");        //HTTP 1.0
  response.setDateHeader ("Expires", 0);
%>

<%
  UserVO userVO = (UserVO) request.getAttribute("userVO");
%>

<%
	Object newUserLogin = session.getAttribute("newUserLogin");              // �q session�����X (key) newUserLogin����
	if (newUserLogin != null) {                                              // �Y�D null, �N��Onew user����U���\,�~���X���U���\alert
		out.println("<script type=\"text/javascript\">");
		out.println("alert('���U���\! �Э��s�n�J!');");
		out.println("</script>");
		session.removeAttribute("newUserLogin");                             // ����new user�лx
	}
%>

<html>
<head>
<meta charset="BIG5">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>login_user</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reset.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/login_user.css">
</head>
<body>

	<div id="login">
		<form method="post" action="<%=request.getContextPath()%>/loginhandler">
			<h2>�|���n�J</h2>
			<input type="text" name="account" placeholder="�п�J�b��" id="email"
			value="<%=(userVO == null) ? "1001@cloudgym.com" : userVO.getUserAccount()%>"> 
			<br> 
			<input type="password" name="password" placeholder="�п�J�K�X" id="password"
			value="<%=(userVO == null) ? "123456" : userVO.getUserPassword()%>"> 
			<br> 
			
			<%-- ���~��C --%>
				<c:if test="${not empty errorMsgs}">
					<c:forEach var="message" items="${errorMsgs}">
						<a id="errormsg">${message}</a>
					</c:forEach>
				</c:if>
			
			<a id="forget" href="<%=request.getContextPath()%>/html/login/forget_password.jsp">�ѰO�K�X</a>
			
			
			
			 
			<input type="hidden" name="action" value="login">
			<button type="submit">Login</button>
			<br> 
			<a href="<%=request.getContextPath()%>/html/login/sign_up_page.jsp" id="sign_up">�s�Ӫ�?���U�b��</a>
		</form>
	</div>



</body>
</html>