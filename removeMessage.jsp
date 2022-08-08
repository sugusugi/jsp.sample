<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ja" dir="ltr">
<head>
<meta charset="utf-8">
<title>セッションを削除しました。</title>
</head>
<body>
	<%
	session.invalidate();
	%>
	<p>セッションが削除されました。</p>
	<a href="registerMessage.jsp">戻る</a>
</body>
</html>