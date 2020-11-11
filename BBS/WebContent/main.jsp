<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name ="viewport" content="width=device-width", initail-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/carousel.css">
<title>문용주 연대기</title>
</head>
<body>
	<%
		String userID =null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
	%>
	<nav class ="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">문용주 연대기</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class ="nav navbar-nav">
				<li><a href="bbs.jsp">방명록</a></li>
				<li><a href="pic.jsp">겔러리</a></li>
			</ul>
			<%
				if(userID ==null){
			%>
				<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false"><span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="login.jsp">로그인</a></li>
					<li><a href="join.jsp">회원가입</a></li>
				</ul>
			</ul>
			<%
				} else{
			%>
				<ul class="nav navbar-nav navbar-right">
				<li><a href="logoutAction.jsp">로그아웃</a></li>
			</ul>
			<%
				}
			%>
		</div>
	 </nav>
	 <div class = "container">
	 	<div class ="jumbotron">
	 		<div class ="container">
	 			<h1>사이트 소개</h1>
	 			<p>나의 일생 연대기를 담은 페이지 입니다.</p>
	 			<p><a class = "btn btn-primary btn-pull" href="bbs.jsp" role ="button">방명록 남기기(필수)</a></p>
	 		</div>
	 	</div>
	 </div>
	 <script>
	 $('.carousel').carousel({

		interval: 2000

	})
	</script>
	 <div class ="container">
	 	<div id="myCarousel" class="carousel slide" data-ride="carausel">
	 		<ol class="carousel-indicators">
		 		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		 		<li data-target="#myCarousel" data-slide-to="1"></li>
		 		<li data-target="#myCarousel" data-slide-to="2"></li>
	 		</ol>
	 		<div class="carousel-inner">
	 			<div class="item active">
	 				<img src="images/1.jpg">
	 			</div>
	 			<div class="item">
	 				<img src="images/2.jpg">
	 			</div>
	 			<div class="item">
	 				<img src="images/3.jpg">
	 			</div>
	 		</div>
	 		<a class="left carousel-control" href="#myCarousel" data-slide="prev">
	 			<span class ="glyphicon glyphicon-chevron-left"></span>
	 		</a>
	 		<a class="right carousel-control" href="#myCarousel" data-slide="next">
	 			<span class ="glyphicon glyphicon-chevron-right"></span>
	 		</a>
	 	</div>
	 </div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>