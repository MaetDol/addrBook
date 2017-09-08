<%@page import="java.util.ArrayList"%>
<%@page import="addrbook.AddrBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="datas" scope="request" class="java.util.ArrayList"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소록:목록화면</title>
<link rel="stylesheet" href="addrbook.css" type="text/css">
</head>
<body>
	<div>
		<h2>주소록:목록화면</h2>
		<hr>
		<form>
			<a href="addrbook_form.jsp">주소록 등록</a>
			
			<table>
				<tr>
					<th>번호</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>생일</th>
					<th>회사</th>
					<th>메모</th>
				</tr>
					<%
						int i = 1;
						for( AddrBean ab : ( ArrayList<AddrBean> )datas ) {
					%>
				<tr>
					<td><a href="Javascript:check( <%= ab.getAb_id() %> )"><%= i++ %></a></td>
					<td><%= ab.getAb_name() %></td>
					<td><%= ab.getAb_tel() %></td>
					<td><%= ab.getAb_birth() %></td>
					<td><%= ab.getAb_comdept() %></td>
					<td><%= ab.getAb_memo() %></td>
				</tr>
					<%
						}
					%>
			</table>
		</form>
	</div>
	
	<script>
		function check( ab_id ) {
			pswd = prompt( '수정/삭제를 하시려면 비밀번호를 넣으세요.' );
			document.location.href = "addrbook_control.jsp?action=edit&ab_id=" + ab_id + "&pswd=" + pswd;
		}
	</script>
	
</body>
</html>