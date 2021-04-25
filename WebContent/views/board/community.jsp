<%@page import="com.mvc.board.model.vo.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.mvc.common.util.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    
<%@ include file="/views/common/header.jsp" %>

<%
	List<Post> list = (List<Post>) request.getAttribute("list");
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
%>

<section>
<h1 style="display:inline">&nbsp;정보공유 </h1>&nbsp;&nbsp;&nbsp;
<form method="GET" action="<%=request.getContextPath()%>/board/community">
    <input type='submit' value="전체"/>
</form>
<form method="GET" action="<%=request.getContextPath()%>/board/community">
	<input type="hidden" name="country" value="서울">
    <input type='submit' value="서울"/>
</form>
<form method="GET" action="<%=request.getContextPath()%>/board/community">
	<input type="hidden" name="country" value="경기">
    <input type='submit' value="경기"/>
</form>
<form method="GET" action="<%=request.getContextPath()%>/board/community">
	<input type="hidden" name="country" value="충청">
    <input type='submit' value="충청"/>
</form>
<form method="GET" action="<%=request.getContextPath()%>/board/community">
	<input type="hidden" name="country" value="경상">
    <input type='submit' value="경상"/>
</form>
<form method="GET" action="<%=request.getContextPath()%>/board/community">
	<input type="hidden" name="country" value="전라">
    <input type='submit' value="전라"/>
</form>
<form method="GET" action="<%=request.getContextPath()%>/board/community">
	<input type="hidden" name="country" value="강원">
    <input type='submit' value="강원"/>
</form>


	<br><br>
	<div id="board-list-container">
		<table class = "table">
			<tr>
				<th>&nbsp;&nbsp;&nbsp;번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
				<th>첨부파일</th>
				<th>조회수</th>
			</tr>
	<% if(list.isEmpty()){ %>
			<tr>
				<td colspan="6">
					조회된 게시글이 없습니다.
				</td>
			</tr>	
			
	<%} else { 
				for(Post post : list) {
	%>
		<tr>
			<td><%= post.getRowNum() %></td>
			<td><%= post.getPost_MemberId() %></td>
			<td>
			<a href = "<%= request.getContextPath()%>/board/communityview?boardNo=<%=post.getPost_Num() %>">
			<%= post.getPost_Title() %></a>
			</td>
			<td><%= post.getEnrollTime() %></td>
			<td>
				<span> - </span>
			</td>
			<td><%= post.getPost_Views() %></td>
		</tr>
		<%
				}
			}
		%>
		</table>
		<%if(loginMember!=null){%>
			<div align="right"><button type = "button" id ="btn-add" onclick="location.href='<%=request.getContextPath()%>/board/communitywrite'">글쓰기</button></div>
		<%}%>
		
	</div>
		<div id="pageBar" align="center">
			<!-- 맨 처음으로 -->
			<button onclick = "location.href=' <%=request.getContextPath()%>/board/community?page=1'">&lt;&lt;</button>

			<!-- 이전 페이지로 -->
			<button onclick = "location.href = ' <%= request.getContextPath()%>/board/community?page=<%=pageInfo.getPrvePage()%>''">&lt;</button>

			<!--  10개 페이지 목록 -->
			
			<% for (int p = pageInfo.getStartPage(); p<=pageInfo.getEndPage() ; p++) {%>
				<%if(p == pageInfo.getCurrentPage()) { %>
					<button disabled><%= p%></button>
				<% } else {%>
						<button onclick="location.href='<%= request.getContextPath() %>/board/community?page=<%=p%>' " ><%=p %></button>
				<% } %>
			<%} %>

			<!-- 다음 페이지로 -->
			<button onClick="location.href=' <%= request.getContextPath()%>/board/community?page=<%=pageInfo.getNextPage()%>'" >&gt;</button>

			<!-- 맨 끝으로 -->
			<button onClick = "location.href=' <%= request.getContextPath() %>/board/community?page=<%=pageInfo.getMaxPage() %>'" >&gt;&gt;</button>
		</div>
</section>

<br><br><br>
<%@ include file="/views/common/footer.jsp" %>