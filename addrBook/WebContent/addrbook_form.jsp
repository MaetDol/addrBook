<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소록:작성화면</title>
<link href="addrbook.css" rel="stylesheet">
</head>
<body>
	<div>
		<h2>주소록:작성화면</h2>
		<hr>
		<a href="addrbook_list.jsp">주소록 목록으로</a>
		<form name="form1" method="post" action="addrbook_control.jsp">
			<input type="hidden" name="action" value="insert">
		
			<table>
				<tr>
					<th>이름</th>
					<td><input type="text" name="ab_name" maxlength="15"></td>
				</tr>
				<tr>
					<th>email</th>
					<td><input type="text" name="ab_email" maxlength="50"></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input type="text" name="ab_tel" maxlength="20"></td>
				</tr>
				<tr>
					<th>생일</th>
					<td><input type="date" name="ab_birth" maxlength="20"></td>
				</tr>
				<tr>
					<th>회사</th>
					<td><input type="text" name="ab_comdept" maxlength="20"></td>
				</tr>
				<tr>
					<th>메모</th>
					<td><input type="text" name="ab_memo"></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="저장">
						<input type="reset" value="취소">
					</td>
				</tr>
				
			</table>
		</form>
	</div>
</body>
</html>