<%@page import="bean.ProductDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%	
		//넘어온 상품id를 받아주어야함.
			String id = request.getParameter("id");
			ProductDAO dao = new ProductDAO();
			ProductDTO dto = dao.one(id);
		%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
<script type="text/javascript" src="js/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(function() { //익명함수
	//콜백함수
	$('input').click(function() {
		//basket.jsp에 장바구니에 담고 싶은 제품에 대한 정보를 넘겨서
		//장바구니에 넣으라고 요청
		$.ajax({
			url: "basket.jsp",
			data :{
				id: '<%= dto.getId() %>',
				price: <%= dto.getPrice() %>,
				name : '<%= dto.getName() %>'
			},
			success: function() {
				alert(<%= dto.getId() %> + '번 연결 성공.!')
				choice = confirm('장바구니 화면으로 넘어가시겠습니까?')
				if(choice){ //true이면
					location.href="basket.jsp"
				}
			}
		})
	})
})

</script>
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
			<h3>손님 환영합니다.<h3>
		<%		
			}
		%>		
		<hr color="silver">
		
		<table>
			<tr>
				<td>아이디</td>
				<td><%= dto.getId() %> </td>
			</tr>
			<tr>
				<td>상품명</td>
				<td><%= dto.getName() %> </td>
			</tr>
			<tr>
				<td>상품 설명</td>
				<td><%= dto.getContent() %> </td>
			</tr>
			<tr>
				<td>제 조 사</td>
				<td><%= dto.getCompany() %> </td>
			</tr>
			<tr>
				<td>상품 가격</td>
				<td><%= dto.getPrice() %>원 </td>
			</tr>
			<tr>
				<td>상품 이미지</td>
				<td>
					<img alt="" src="img/<%= dto.getImg() %>" width=250 height="250">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input class="" type="image" src="img/bag.png" width="100" height="100">
				</td>
			</tr>
		</table>
	</div>
</div>
</body>
</html>