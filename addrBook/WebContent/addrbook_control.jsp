<%@page import="addrbook.DaoBean"%>
<%@page import="addrbook.AddrBean"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% request.setCharacterEncoding( "UTF-8" ); %>

<jsp:useBean id="gb" scope="page" class="addrbook.DaoBean" />
<jsp:useBean id="addrbook" class="addrbook.AddrBean" />
<jsp:setProperty name="addrbook" property="*" />

<%
	String action = request.getParameter( "action" );
	DaoBean db = new DaoBean();

	if( action.equals( "list" ) ) {
		
		request.setAttribute( "datas", db.getDBList() );
		pageContext.forward( "addrbook_list.jsp" );
		
	} else if( action.equals( "insert" ) ) {
		if( gb.insertDB( addrbook ) ) {
			response.sendRedirect( "addrbook_control.jsp?action=list" );
		} else {
			out.print( "<script>alret('DB 입력 오류')</script>" );
			System.out.println( "DB 입력 오류" );
		}
		
	} else if( action.equals( "edit" ) ) {
		AddrBean ab = db.getDB( addrbook.getAb_id() );
		
		String pswd = request.getParameter( "pswd" );
		if( pswd.equals( "1234" ) ) {
			request.setAttribute( "ab", ab );
			pageContext.forward( "addrbook_edit_form.jsp" );
		} else {
			out.println( "<script>alert( '비밀번호가 틀렸습니다!' ); history.go( -1 )</script>" );
		}
		
	} else if( action.equals( "update" ) ) {
		int 	 ab_id 			= Integer.parseInt( request.getParameter( "ab_id" ) );
		String ab_name		= request.getParameter( "ab_name" );
		String ab_email		= request.getParameter( "ab_email" );
		String ab_tel			= request.getParameter( "ab_tel" );
		String ab_birth		= request.getParameter( "ab_birth" );
		String ab_comdept	= request.getParameter( "ab_comdept" );
		String ab_memo		= request.getParameter( "ab_memo" );
		
		AddrBean ab = new AddrBean();
		
		ab.setAb_id(			ab_id );
		ab.setAb_name(		ab_name );
		ab.setAb_email(		ab_email );
		ab.setAb_tel(			ab_tel );
		ab.setAb_birth(		ab_birth );
		ab.setAb_comdept(	ab_comdept );
		ab.setAb_memo(		ab_memo );
		
		db.updateDB( ab );
		
		out.print( "<script>alert( '수정이 완료되었습니다!' )</script>" );
		response.sendRedirect( "addrbook_control.jsp?action=list" );
		
	} else if( action.equals( "delete" ) ) {
		int ab_id = Integer.parseInt( request.getParameter( "ab_id" ) );
		if( db.deleteDB( ab_id ) ) {
			response.sendRedirect( "addrbook_control.jsp?action=list" );
		} else {
			System.out.println( "DB삭제 오류" );
		}
		
	} else {
		
	}
%>
