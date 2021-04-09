<%@page import="bean.BbsDTO"%>
<%@page import="bean.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	//넘어온 id를 받아주어야 함.
    	String id = request.getParameter("id");
    	BbsDAO dao = new BbsDAO();
    	BbsDTO dto = dao.one(id);
    %>
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
			if(session.getAttribute("id") != null){
		%>
			<%= session.getAttribute("id") %>님 환영합니다.
		<%
			}else{
		%>
			손님 환영합니다.
		<%		
			}
		%>
		게시판 정보 처리가 들어갈 부분...
		<hr color="red">
		<form action="update2.jsp">
		<input type="hidden" name="id" value="<%= dto.getId() %>">
		<table>
			<tr>
				<td>제 목</td>
				<td style="background:pink;">
					<input name="title" value="<%= dto.getTitle()%>">
				</td>
			</tr>
			<tr>
				<td>내 용</td>
				<td style="width:300px; height: 200px;background:pink;">
				<textarea rows="5" cols="20" name="content" style="font-size: 40px">
					<%= dto.getContent() %>
				</textarea>
				</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td style="background:pink;" >
				<%= session.getAttribute("id") %>
				<input name="writer" type="hidden" value="<%= session.getAttribute("id") %>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">게시글 수정</button>
				</td>
			</tr>
		</table>
		</form>	
	</div>
</div>
</body>
</html>