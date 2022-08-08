<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page
	import="java.util.Map,java.util.HashMap,java.util.Date,java.time.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
/*行事を日にちとセットで保存*/
Map<String, String> eventList = new HashMap<>();
eventList.put("20220110", "元旦");
eventList.put("20220111", "鏡開き");
eventList.put("20220203", "節分");
eventList.put("20220214", "バレンタイン");
eventList.put("20220303", "ひな祭り");
eventList.put("20220314", "ホワイトデー");
eventList.put("20220505", "端午の節句");
eventList.put("20220621", "夏至");
eventList.put("20220707", "七夕");
eventList.put("20220813", "コミックマーケット100 1日目");
eventList.put("20220814", "コミックマーケット100 2日目");
eventList.put("20220820", "日本ダーツ祭り1日目");
eventList.put("20220821", "日本ダーツ祭り2日目");
eventList.put("20220909", "重陽の節句");
eventList.put("20221031", "ハロウィン");
eventList.put("20221115", "七五三");
eventList.put("20221225", "クリスマス");
eventList.put("20221230", "コミックマーケット101 1日目");
eventList.put("20221231", "コミックマーケット101 2日目");
request.setCharacterEncoding("UTF-8");
/*リクエストパラメーターの取得*/
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
/*行事の内容*/
String event = null;
/*行事の日にち*/
String eventDay = null;
/*例外発生時のコメント*/
String error = null;
if (year != null && month != null && day != null) {
	if (month.length() == 1) {
		month = "0" + month;
	}
	if (day.length() == 1) {
		day = "0" + day;
	}
	eventDay = year + month + day;
	event = eventList.get(eventDay);
	if (event == null) {
		event = "行事はありません";
	}
	try {
		LocalDateTime ldt = LocalDateTime.of(Integer.parseInt(year), Integer.parseInt(month),
    Integer.parseInt(day), 0,0);
		request.setAttribute("eventDate", Date.from(ldt.toInstant(ZoneOffset.UTC)));
	} catch (NumberFormatException | DateTimeException e) {
		error = "日にちを指定してください。";
	}
}
%>
<!DOCTYPE html>
<html lang="ja" dir="ltr">
<head>
<meta charset="utf-8">
<title>簡易カレンダー</title>
</head>
<body>
  <%--日にちの入力フォーム--%>
	<form action="calendar.jsp" method="post">
		<input type="text" name="year">年 <input type="text"
			name="month">月 <input type="text" name="day">日 <input
			type="submit" value="検索">
	</form>
	<c:choose>
    <%--
      -初期値は現時刻
      -指定の日にちに行事がある場合は日にちと行事の出力
      -何も行事がない場合は日にちとその旨を出力
      -入力が数字以外または日にちに変換できない場合は例外発生時のコメントを出力
    --%>
		<c:when test="<%=(event == null)%>">
			<jsp:useBean id="now" class="java.util.Date" />
			<p>
				<fmt:formatDate value="${now}" pattern="yyyy年MM月dd日 EEEE" />
			</p>
		</c:when>
		<c:when test="<%=(event != null)%>">
			<c:choose>
				<c:when test="<%=(error == null)%>">
					<p>
						<fmt:formatDate value="${eventDate}" pattern="yyyy年MM月dd日 EEEE" />
					</p>
					<p><%=event%></p>
				</c:when>
				<c:when test="<%=(error != null)%>">
					<p><%=error%></p>
				</c:when>
			</c:choose>
		</c:when>
	</c:choose>
</body>
</html>