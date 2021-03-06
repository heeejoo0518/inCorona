<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
	boolean duplicated = (boolean)request.getAttribute("duplicated");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	div#checkId-container {
		text-align:center;
		padding-top:50px;
	}
	
	span#duplicated {
		color:red;
		font-weight:bolder;
	}
</style>
</head>
<body>
	<div id="checkId-container">
		<% if(duplicated) { %>
			[<span id="duplicated"><%= request.getParameter("userNickname") %></span>]는 사용중 입니다.
			
			<br><br>
			
			<!-- 닉네임 재입력창 구성 -->
			<form action="<%= request.getContextPath() %>/member/checkNickname" method="post">
				<input type="text" name="userNickname" id="newNickname" placeholder="닉네임" required>
				<input type="submit" id="checkDuplicate" onclick="return validate();" value="중복검사" >
			</form>		
		<% } else { %>
			[<span><%= request.getParameter("userNickname") %></span>]는 사용 가능합니다.
		
			<br><br>
			
			<input type="button" onclick="setUserNickname()" value="닫기">		
		<% } %>
	</div>
	<script>
		function validate(){
			let nickName = document.getElementById("newNickname").value;
			var checkBlank = /[\s]/;
			
			if(checkBlank.test(nickName.trim())){
				alert("닉네임은 공백을 포함할 수 없습니다.");
				document.getElementById("newNickname").focus();
				return false;
			}
		}
		
		function setUserNickname() {
			// 입력 된 id를 부모창에 대입
			const nickName = "<%= request.getParameter("userNickname") %>";
			
			opener.memberEnrollFrm.Member_NickName.value = nickName;
			opener.memberEnrollFrm.Member_Email.focus();
			
			// 팝업창 닫아주기
			close();			
		}	
	</script>	
</body>
</html>