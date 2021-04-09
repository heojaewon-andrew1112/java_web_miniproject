<%@page import="bean.MemberDAO"%>
<%@page import="bean.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="dto" class="bean.MemberDTO"></jsp:useBean>
    <jsp:setProperty property="*" name="dto"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<div id="total">
	<div id="top">
		<jsp:include page="top.jsp"></jsp:include>
	</div>
	<div id="top2">
		<jsp:include page="top2.jsp"></jsp:include>
	</div>
	<div id="center">
		<%
		//DAO객체를 생성해서
		MemberDAO dao = new MemberDAO();
		//login메서드를 호출
		boolean result = dao.login(dto);
		if(result){
			session.setAttribute("id", dto.getId());
			response.sendRedirect("member.jsp");
			//세션 잡혀있는 상태
		}else{
		%>
			<h3>로그인이 실패했습니다. 재로그인해주세요.</h3>
			<a href="member.jsp">
				<button style="background:lime;">로그인 화면으로</button>
			</a><br>
		<%	}
		%>
	</div>
</div>
</body>
</html>