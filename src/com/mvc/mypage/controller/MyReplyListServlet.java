package com.mvc.mypage.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.mvc.board.model.vo.Reply;
import com.mvc.common.util.PageInfo;
import com.mvc.member.model.vo.Member;
import com.mvc.mypage.model.service.MypageService;


@WebServlet(urlPatterns={"/mypage/myreply/list","/mypage/myreply"})
public class MyReplyListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MypageService service = new MypageService();
  
    public MyReplyListServlet() {

    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 게시물 리스트 조회
    	// 페이징 처리
    	
    	int page = 0;
    	int listCount = 0;
    	PageInfo pageInfo = null;
    	List<Reply> list = null;
    	HttpSession session = request.getSession();
    	Member loginMember = (Member)session.getAttribute("loginMember");
    	
    	if(loginMember==null) {
    		request.setAttribute("msg", "로그인 해주세요.");
    		request.setAttribute("location", "/member/login");
    		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    		return;
    	}
    	
    	String loginId = loginMember.getMember_Id();
    	String role = loginMember.getMember_role();
    	System.out.println("servlet"+loginId);
 
    	try {
    		page = Integer.parseInt(request.getParameter("page"));
    	} catch (NumberFormatException e) {
    		page = 1;
		}
    	
    	listCount = service.getReplyCount(loginId, role);    
    	pageInfo = new PageInfo(page, 10, listCount, 10);
    	/**
    	 * 
    	 * @param currentPage 현재 페이지
    	 * @param pageLimit 한 페이지에 보여질 페이지의 수 
    	 * @param listCount 전체 리스트의 수
    	 * @param listLimit 한 페이지에 표시될 리스트의 수
    	 */
    	list = service.getReplyList(pageInfo, loginId, role);
    	
    	System.out.println(list);
    	    	
    	request.setAttribute("list", list);
    	request.setAttribute("pageInfo", pageInfo);
    	request.getRequestDispatcher("/views/mypage/myreply.jsp").forward(request, response);
	}

}
