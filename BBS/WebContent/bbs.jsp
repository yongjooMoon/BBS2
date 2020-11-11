<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name ="viewport" content="width=device-width, initail-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<script type="text/javascript">
		var searchRequest= new XMLHttpRequest(); //ajax를 쓰기 위해 인스턴스 생성
		var registerRequest= new XMLHttpRequest();
		function searchFunction(){
		    searchRequest.open("Post","./UserSearchServlet?userID="+ encodeURIComponent(document.getElementById("userID").value),true); //이름을 입력받으면 userName에서 그 값을 검색하기 위해 넘겨줌
		    searchRequest.onreadystatechange =searchProcess; //어떠한 이벤트(변화)가 나타났을 때 바로  알려줌
		    searchRequest.send(null);
		}
		function searchProcess(){
		    var table = document.getElementById("ajaxTable"); //html에 ajaxTable이라는 아이디를 갖는 tbody를 가져옴
		    table.innerHTML =""; //빈공간으로 초기화
		    if(searchRequest.readyState == 4 && searchRequest.status == 200){    //성공적으로 통신이 된다면 
		        var object = eval('('+searchRequest.responseText+')');
		        var result = object.result;        //servlet에서 배열을 담는 result를 받아옴 
		        for(var i=0; i<result.length; i++){        //넘어온 result의 길이까지 반복
		            var row = table.insertRow(0);         //테이블에 행을 추가
		            for(var j=0; j<result[i].length; j++){    //result 배열에는 userNamae,userAge,userGender... 가 들어있으므로 하나씩 접근
		                var cell = row.insertCell(j);    //위에서 만들어진 행에 하나의 셀을 추가
		                cell.innerHTML=result[i][j].value;    //innerHTML에 값을 표시
		            }
		        }
		    }
		}
	</script>
<title>문용주 연대기</title>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
		<%!
		public Integer toInt(String x){
		int a = 0;
		try{
			a = Integer.parseInt(x);
		}catch(Exception e){}
		return a;
		}
		%>
	<%
		String userID =null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = toInt(request.getParameter("pageNumber"));
		if(pageNumber<1){//현재 페이지
			pageNumber = 1;
		}
		Bbs bbs = new Bbs();
		
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
				<li class ="active"><a href="bbs.jsp">방명록</a></li>
				<li><a href="pic.jsp">겔러리</a></li>
			</ul>
			<%
				if(userID ==null){
			%>
				<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
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
	<br>
	<div class="container">
		<div class="form-group row pull-right">
			<div class="col-xs-8">
				<input class="form-control" id="userID" onKeyup="searchFunction()" type="text" size="20">
			</div>
			<div class="col-xs-2">
				<button class="btn btn-primary" onclick="searchFunction();" type="button">검색</button>
			</div>
		</div>
	</div>
	 <div class="container">
	 	<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
	 		<thead>
	 			<tr>
	 				<th style="background-color: #eeeeee; text-align: center;">번호</th>
	 				<th style="background-color: #eeeeee; text-align: center;">제목</th>
	 				<th style="background-color: #eeeeee; text-align: center;">작성자</th>
	 				<th style="background-color: #eeeeee; text-align: center;">작성일</th>
	 			</tr>
	 		</thead>
	 			<tbody id=ajaxTable>
	 			<%
	 				BbsDAO bbsDAO = new BbsDAO();
	 				ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
	 				for(int i = 0; i < list.size(); i++){
	 			%>
	 				<tr>
	 					<td><%= list.get(i).getNUM() %></td>
	 					<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
	 					<td><%= list.get(i).getUserID() %></td>
	 					<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11,13) +"시" + list.get(i).getBbsDate().substring(14, 16) +"분" %></td>
	 				</tr>
	 				<% 
	 				}
	 			%>
	 			</tbody>
	 	</table>
	<%
	int total_record = 754;		   //총 레코드 수
	int group_per_page_cnt =5;     //페이지 당 보여줄 번호 수[1],[2],[3],[4],[5]
//					  									  [6],[7],[8],[9],[10]											

	int result = bbsDAO.count();
	int div = 10;
	int count = 0;
	count = (int)Math.ceil((double)result/(double)div);

// 	현재 페이지(정수) / 한페이지 당 보여줄 페지 번호 수(정수) + (그룹 번호는 현제 페이지(정수) % 한페이지 당 보여줄 페지 번호 수(정수)>0 ? 1 : 0)
	int group_no = pageNumber/group_per_page_cnt+( pageNumber%group_per_page_cnt>0 ? 1:0);
//		현재 그룹번호 = 현재페이지 / 페이지당 보여줄 번호수 (현재 페이지 % 페이지당 보여줄 번호 수 >0 ? 1:0)	
//	ex) 	14		=	13(몫)		=	 (66 / 5)		1	(1(나머지) =66 % 5)			  
	
	int page_eno = group_no*group_per_page_cnt;		
//		현재 그룹 끝 번호 = 현재 그룹번호 * 페이지당 보여줄 번호 
//	ex) 	70		=	14	*	5
	int page_sno = page_eno-(group_per_page_cnt-1);	
// 		현재 그룹 시작 번호 = 현재 그룹 끝 번호 - (페이지당 보여줄 번호 수 -1)
//	ex) 	66	=	70 - 	4 (5 -1)
	
	if(page_eno>count){
//	   현재 그룹 끝 번호가 전체페이지 수 보다 클 경우		
		page_eno=count;
//	   현재 그룹 끝 번호와 = 전체페이지 수를 같게
	}
	
	int prev_pageNumber = page_sno-group_per_page_cnt;  // <<  *[이전]* [21],[22],[23]... [30] [다음]  >>
//		이전 페이지 번호	= 현재 그룹 시작 번호 - 페이지당 보여줄 번호수	
//	ex)		46		=	51 - 5				
	int next_pageNumber = page_sno+group_per_page_cnt;	// <<  [이전] [21],[22],[23]... [30] *[다음]*  >>
//		다음 페이지 번호 = 현재 그룹 시작 번호 + 페이지당 보여줄 번호수
//	ex)		56		=	51 - 5
	if(prev_pageNumber<1){
//		이전 페이지 번호가 1보다 작을 경우		
		prev_pageNumber=1;
//		이전 페이지를 1로
	}
	if(next_pageNumber>count){
//		다음 페이지보다 전체페이지 수보가 클경우		
		next_pageNumber=count;
//		next_pageNumber=total_page
//		다음 페이지 = 전체페이지수 / 페이지당 보여줄 번호수 * 페이지당 보여줄 번호수 + 1 
//	ex)			   = 	76 / 5 * 5 + 1	???????? 		
	}
	
	// [1][2][3].[10]
	// [11][12]
%>
		<a href="bbs.jsp?pageNumber=1" class="btn btn-success btn-arraw-center">맨앞으로</a>
		<a href="bbs.jsp?pageNumber=<%=prev_pageNumber%>" class="btn btn-success btn-arraw-center">이전</a>
		<%
		for(int i =page_sno;i<=count;i++){
		%>
			<a href="bbs.jsp?pageNumber=<%=i %>">
				<%if(pageNumber == i){ %>
					[<%=i %>]
				<%}else{ %>
					<%=i %>
				<%} %>
			</a> 
		<%--	콤마	 --%>	
			<%if(i<count){ %>
				,
			<%} %>
		<%} %>
		<a href="bbs.jsp?pageNumber=<%=next_pageNumber%>" class="btn btn-success btn-arraw-center">다음</a>
		<a href="bbs.jsp?pageNumber=<%=count %>" class="btn btn-success btn-arraw-center">맨뒤로</a>
</div>
	<%
	 	if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		 %>
		 		<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		 <%
			}
	     %>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>