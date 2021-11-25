<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="redis.clients.jedis.Jedis" %>
<%@ page import="com.video.model.*"%>
<%@ page import="com.videoAction.model.*"%>

<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache");        //HTTP 1.0
	response.setDateHeader ("Expires", 0);
	
	VideoVO videoVO = (VideoVO) request.getAttribute("VideoVO");
	
	Jedis jedis = new Jedis("localhost", 6379);
	pageContext.setAttribute("jedis", jedis);

	String userID = null;
	try{
		userID = session.getAttribute("userID").toString();
	}catch(Exception e){
		userID = null;
	}
	
	long cartCount = 0;
	try{
		cartCount = jedis.hlen(userID);
	}catch(Exception e){
		cartCount = 0;
	}
			
	pageContext.setAttribute("cartCount", cartCount);
	
	List<String> errorMsgs = (List<String>) request.getAttribute("errorMsgs");
%>

<jsp:useBean id="videoSvc" scope="page" class="com.video.model.VideoService"/>
<jsp:useBean id="videoActionSvc" scope="page" class="com.videoAction.model.VideoActionService"/>

<!DOCTYPE html>
<html lang="en">
<head>
<style>
#menu {
	margin: auto;
	float: right;
}

.main {
	background-color:#5C37A1;
	color: white;
	font-size: 14px;
	cursor: pointer;
	text-align: center;
	height: 40px;
	line-height: 40px;
	width: 70px;
}

.main a {
	color: #fff;
	text-decoration: none;
	line-height: 40px;
	margin: auto;
}

#logout{
	width: 100%;
}

.url {
	margin: auto;
}

.main:hover {
	background-color: #4d4949;
}

.sub {
	position:fixed;
	cursor: pointer;
	background-color: #4d4949;
	color: white;
	font-size: 12px;
	font-family: �L�n������;
	text-align: center;
	width: 70px;
}

.sub li {
	list-style-type: none;
	line-height: 40px;
}

.sub a {
	list-style-type: none;
	line-height: 40px;
	margin: auto;
}

.item {
	float: left;
}

#menu li {
	list-style-type: none;
}

/****************** bar css end ******************/
</style>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>�нm�s��v��</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/reset.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/buildVideo.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body>
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script>
		$("#menu").css("width", $(".main").length * 200)
		$(document).ready(function() {
			//  �@�i�J�e���ɦ��X���
			$(".sub").slideUp(0);

			for (i = 0; i < $(".main").length; i++) {
				//  �I�����ɦ��X�ήi�}���
				$(".main:eq(" + i + ")").on("click", {
					id : i
				}, function(e) {
					n = e.data.id
					$(".sub:eq(" + n + ")").slideToggle()
					$(".sub:not(:eq(" + n + "))").slideUp()
				})
				$(".main:eq(" + i + ")").on("mouseleave", {
					id : i
				}, function(e) {
					n = e.data.id
					$(".sub").stop();
				})
			}
		})
	</script>

	<!-- bar begining -->
<!-- bar���� begining -->
    <div id="bar">
        <div id="title">
            <ul>
                <li class="bar_li">
                    <img src="<%=request.getContextPath()%>/img/logo.png" alt="" for="#CloudGYM">
                </li>
                <li class="bar_li">
                    <a href="<%=request.getContextPath()%>/html/main_page.jsp" id="CloudGYM">CloudGYM</a>
                </li>
            </ul>
        </div>
        <div id="option">
           <ul>
				<li class="option"><a
					href="<%=request.getContextPath()%>/html/video/all_video_page.jsp">�B������</a></li>
				<li class="option"><a
					href="<%=request.getContextPath()%>/html/coach/all_coach_page.jsp">�нm</a></li>
				<li class="option"><c:if test="${not empty userID}">
						<a
							href="<%=request.getContextPath()%>/html/user/protected_user/userMainPage.jsp?userID=${userID}">�ӤH�M��</a>
					</c:if> <c:if test="${ empty userID}">�ӤH�M��</c:if></li>
				<li class="option"><a
					href="<%=request.getContextPath()%>/html/article/ArticleList.jsp">�Q�װ�</a></li>
				<c:if test="${empty userID}">
					<div class="item">
						<div class="main">���U/�n�J</div>
						<div class="sub">
							<ul>
								<li><a
									href="${pageContext.request.contextPath}/html/login/sign_up_page.jsp">�|�����U</a></li>
								<li><a
									href="${pageContext.request.contextPath}/html/login/login_user.jsp">�|���n�J</a></li>
								<li><a
									href="${pageContext.request.contextPath}/html/login/login_coach.jsp">�нm�n�J</a></li>
								<li><a
									href="${pageContext.request.contextPath}/html/login/login_admin.jsp"
									target="_blank">��x�޲z</a></li>
							</ul>
						</div>
					</div>
				</c:if>
				<c:if test="${not empty userID}">
				<div class="item">
					<div class="main" id="logout"><a href="javascript:if (confirm('�T�{�n�X?')) location.href='<%=request.getContextPath()%>/LogoutHandler'">${name} �n�X</a></div>
						<div class="sub"></div>
					</div>
				</c:if>
				<li class="option"><a
					href="<%=request.getContextPath()%>/html/order/pay_page.jsp">
						<i class="bi bi-cart-fill"> <c:if test="${hlen != 0}">
								<span>${hlen}</span>
							</c:if> <c:if test="${hlen == 0}">
								<span>${cartCount}</span>
							</c:if> <span>${cartCount}</span>
					</i>
				</a></li>
			</ul>
        </div>
    </div>
<!-- bar���� end -->
	<div id="main">
		<div id="form">
			<form action="<%=request.getContextPath()%>/video/video.do" method="post" enctype="multipart/form-data">
				<div id="box1">
					<ul>
						<h3 id="form_title">��s�нm�v��</h3>
					</ul>
				</div>
				<div id="box2">
					<ul>
						<li id="video_name">�Q��諸�v���G
  	                    <select name="videoID">
	                        <option selected disabled></option>
	                        <c:forEach var="videoVO" items="${videoSvc.getByUserID(userID)}">
	                        <option value="${videoVO.videoID}">${videoVO.title}</option>
	                        </c:forEach>
	                    </select><br><br>
					
	                    <li>���᪺�W�١G
	                    <input id="name_input" type="text" placeholder="��J�v���W��" aria-label="default input example" 
                    	name="title" value="<%=(videoVO == null) ? "" : videoVO.getTitle()%>"><br><br>
                    	<%if(errorMsgs != null){if(errorMsgs.contains("�п�J�v���W��")) {%>
                        <span style="color:red; margin-left:10px; font-size:10px">�п�J���W��</span>
                    <%}} %>
						<br>

						<li id="video_intro">�v��²��:</li>
						<br>
						<textarea id="intro_input" rows="3" name="intro"></textarea>
						<div id="post_box">
							<li id="post_name">�ʧ@�W��:<br>
							<br> <input id="post_input" type="text" placeholder="��J�ʧ@�W��"
								aria-label="default input example" name="actionname1">
								<input name="times1" placeholder="����">
								<input id="set"
								type="number" placeholder="�X��" name="set1"
								aria-label="default input example">
							</li>
							<li id="post_name">�ʧ@�W��:<br>
							<br> <input id="post_input" type="text" placeholder="��J�ʧ@�W��"
								aria-label="default input example" name="actionname2">
								<input name="times2" placeholder="����">
								<input id="set"
								type="number" placeholder="�X��" name="set2"
								aria-label="default input example">
							</li>
							<li id="post_name">�ʧ@�W��:<br>
							<br> <input id="post_input" type="text" placeholder="��J�ʧ@�W��"
								aria-label="default input example" name="actionname3">
								<input name="times3" placeholder="����">
								<input id="set" type="number" placeholder="�X��" name="set3"
								aria-label="default input example">
							</li>
							<div id="button_area">
								<button type="submit" id="button" class="btn btn-primary btn-lg">�T�{</button>
								<button type="button" id="button" class="btn btn-primary btn-lg">����</button>
							</div>
						</div>
					</ul>
				</div>
				<div id="box3">
					<img src="../img/work_out_1.jpg" alt="" class="video_pic">
					<div id="public_box">
						<h3>
							����:
                    <input id="price" type="number" placeholder="��J����" aria-label="default input example" 
                    	name="price" value="<%=(videoVO == null) ? "" : videoVO.getPrice()%>"><br><br>
                    	 <%if(errorMsgs != null){if(errorMsgs.contains("�п�J�v������")) {%>
                        <span style="color:red; margin-left:10px; font-size:10px">�п�J����</span>
                    <%}} %>
						</h3>
						<br>
						<h3>
							�j��:
							<select name="level">
								<option value="�z">�z</option>
								<option value="��">��</option>
								<option value="�j">�j</option>
							</select>
	                   <%if(errorMsgs != null){if(errorMsgs.contains("�п�ܱj��")) {%>
                        <span style="color:red; margin-left:10px; font-size:10px">�п�ܱj��</span>
                   		 <%}} %>
						</h3>
						<br>
						<h3>
							����:
							<jsp:useBean id="position" scope="page" class="com.thePosition.model.ThePositionService"/>
							<select name="thePosition">
							<c:forEach var="thePosition" items="${position.all}">
								<option value="${thePosition.positionNo}">${thePosition.positionName}</option>
							</c:forEach>
							</select>
						</h3>
						<br>
						<h3>
							<input type="file" id="file-uploader" name="video">
						</h3>
					</div>
				</div>
				<input type="hidden" name="action" value="update">
				<input type="hidden" name="userID" value="${userID}">
			</form>
		</div>
	</div>
</body>
</html>