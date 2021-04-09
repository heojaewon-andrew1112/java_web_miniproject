<%@page import="bean.ReplyDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.ReplyDAO"%>
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
			if(session.getAttribute("id").equals(dto.getWriter())){
		%>
		<a href="delete.jsp?id=<%= dto.getId() %>">
			<button>삭제</button>
		</a>
		<a href="update.jsp?id=<%= dto.getId() %>">
			<button>수정</button>
		</a>
		<% 
			}
		}else{
		%>
			손님 환영합니다.
		<%
		}
		%>
		<hr color="red">
		<table>
			<tr>
				<td>아이디</td>
				<td style="background:pink;"><%= dto.getId() %> </td>
			</tr>
			<tr>
				<td>제 목</td>
				<td style="background:pink;"><%= dto.getTitle() %> </td>
			</tr>
			<tr>
				<td>내 용</td>
				<td style="width:300px; height: 200px;background:pink;"><%= dto.getContent() %> </td>
			</tr>
			
			<tr>
				<td>작성자</td>
				<td style="background:pink;" ><%= dto.getWriter() %></td>
			</tr>
		</table>
		<hr color="red">
		<form action="reply.jsp">
			<input type="hidden" name="oriid" value="<%= dto.getId()%>">
			<input type="hidden" name="writer" value="<%= session.getAttribute("id") %>">
			<input name="content">
			<button type="submit">글쓰기</button>
		</form>
		<hr color="green">
		<%
			ReplyDAO dao2 = new ReplyDAO();
			ArrayList<ReplyDTO> list2 =  dao2.list(id);
			for(ReplyDTO dto2 : list2){
		%>
		<table border="1" bordercolor=red>
		<tr>
	 		<td>내  용 </td>
	 		<td>글쓴이 </td>
	 	</tr>
	 	<tr>
	 		<td>- <%= dto2.getContent() %> </td>
	 		<td><%= dto2.getWriter() %> </td>
	 	</tr>
		 </table><br>	
		 <%}%>
	</div>
</div>
</body>
</html>