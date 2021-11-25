<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.coach.model.*"%>
<%
  response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  response.setHeader("Pragma","no-cache");        //HTTP 1.0
  response.setDateHeader ("Expires", 0);
%>
<%
  CoachVO coachVO = (CoachVO) request.getAttribute("coachVO");
%>

<html>
<head>
<meta charset="BIG5">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>login_coach</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reset.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/login_coach.css">
</head>
<body>

	<div id="login">
		<form method="post" action="<%=request.getContextPath()%>/html/coachloginhandler">
			<h2>�нm�n�J</h2>
			<input type="text" name="account" placeholder="�п�J�b��" id="email"
			value="<%=(coachVO == null) ? "LH44@gmail.com" : coachVO.getCoachAccount()%>"> 
			<br> 
			<input type="password" name="password" placeholder="�п�J�K�X" id="password"
			value="<%=(coachVO == null) ? "Hamilton44" : coachVO.getCoachPassword()%>"> 
			<br> 
			
			<%-- ���~��C --%>
				<c:if test="${not empty errorMsgs}">
					<c:forEach var="message" items="${errorMsgs}">
						<a id="errormsg">${message}</a>
					</c:forEach>
				</c:if>
			
			<a id="forget" href="./forget_password.jsp">�ѰO�K�X�F?���A</a>
			
			
			
			 
			<input type="hidden" name="action" value="login">
			<button type="submit">Login</button>
			<br> 
			<a href="./sign_up_page.jsp" id="sign_up">�s�Ӫ�?���U�b��</a>
		</form>
	</div>



</body>
</html>