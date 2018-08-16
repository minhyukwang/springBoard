<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table width="500" cellpadding="0" cellspacing="0" border="1">
		<tr>
			<td>번호</td>
			<td>이름</td>
			<td>제목</td>
			<td>날짜</td>
			<td>히트</td>
		</tr>
		<c:forEach items="${list}" var="bBean">
			<tr>
				<td>${bBean.bId}</td>
				<td>${bBean.bName}</td>
				
				<td>
					<c:forEach begin="1" end="${bBean.bIndent}">-</c:forEach>
					<a href="content_view?bId=${bBean.bId}">${bBean.bTitle}</a>
				</td>
				
				<td>${bBean.bDate}</td>
				<td>${bBean.bHit}</td>
			</tr>
			</c:forEach>
			<tr>
				<td colspan="5"><a href="write_view">글작성</a></td>
			</tr>
	</table>
</body>
</html>