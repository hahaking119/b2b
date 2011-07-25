<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.saas.biz.saleMgr.SaleInfo"%>
<jsp:useBean id="tools" class="com.saas.biz.commen.PageTools" scope="page" />
<%
	 request.setCharacterEncoding("gbk");
	 		String info_id ="";
			String cust_name = "";
			String company_address = "";
			String group_contact_phone = "";
			String website = "";
			String contents="";
			boolean flag=false;
	HttpSession logsession = request.getSession();
	String cust_id = "";
	String iStart = "1";
	if (request.getParameter("iStart") != null) {
		iStart = request.getParameter("iStart");
	}
	if (logsession.getAttribute("SESSION_CUST_ID") != null) {
		cust_id = logsession.getAttribute("SESSION_CUST_ID").toString();
	}
	SaleInfo saleObj = new SaleInfo();
	int counter = 0 ;
	ArrayList saleList = new ArrayList();

		saleList = saleObj.enterpCommend(Integer.valueOf(iStart).intValue(), 10);
		counter = saleObj.enterpCommend();

	String pageTools=tools.getPageTools(String.valueOf(counter),"10","commendenterp.jsp?iStart=",Integer.parseInt(iStart));
%>
<html>
	<head>
		<title>B2B电子商务后台管理系统</title>
		<link rel="stylesheet" type="text/css"  href="../style/mg.css"/>
		<link href="/style/layout.css" rel="stylesheet" type="text/css">
		<style type="text/css">
	.chaxun{
			background:url(/admin/images/chaxun.gif) left center no-repeat;
			width:70px;
		 	height:26px;
			border:0px; 
		 	cursor:hand;
		}
</style>
		<script language="javascript" src="/js/Calendar_Ly.js"></script>
	<script language="javascript" src="/js/saleMgr.js"></script>
		
	</head>
	<body>

	<form action="modifyIndex.jsp" method="post" name="indexdateform">
	  	 <table width="800" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
			<td height="30"> 
			</td>
			</tr>
      <tr>
			  <td background="/admin/images/content_03.gif" height="43" width="156" align="center"><font size="2"><b>企业推荐</b></font></td>
				<td background="/admin/images/content_04.gif" align="right">&nbsp;</td>						
				<td background="/admin/images/content_04.gif" align="right">&nbsp;</td>
				<td width="8"><img src="/admin/images/content_06.gif"></td>				

		  </tr>
	  </table>
		<table width=800 border="0" cellpadding="1" cellspacing="1" align=center bgcolor="#DEEDFD" style="margin-top:13px">
			<tr class="u4" height="25">
				<td  align=center width="20%">
					公司名称
				</td>

				<td align=center width="20%">
					公司地址
				</td>
				<td  align=center width="20%">
					联系电话
				</td>
				<td   align=center width="10%">
				  公司网站
				</td>
				<td  align=center width="10%">
					推荐
				</td>
			</tr>
			<%
					if (saleList != null && saleList.size() > 0) {
					int size = saleList.size();
					for (int i=0;i<saleList.size();i++) {
						HashMap map = (HashMap)saleList.get(i);
						if (map.get("contents") != null) {
					      contents = map.get("contents").toString();
					      if(contents.length()>1&&contents.substring(0,1).equals("1"))
					      flag=true;
					    else
					    	 flag=false;
						}					
						if (map.get("info_id") != null) {
					      info_id = map.get("info_id").toString();
						}
						if (map.get("cust_name") != null) {
					      cust_name = map.get("cust_name").toString();
						}
						if (map.get("company_address") != null) {
					        company_address = map.get("company_address").toString();
						}
						if (map.get("group_contact_phone") != null) {
					    group_contact_phone=map.get("group_contact_phone").toString();
						}
						
						if (map.get("website") != null) {
					      website=map.get("website").toString();
						}
			%>
			<tr class="u2">
				<td  align=left>
					<a href=viewCustinfo.jsp?obj_cust_id=<%=info_id%> TARGET=_blank>
						<%=cust_name%>
					</a>
					
				</td>
				<td  align=left>
					<%=company_address%>
				</td>

				<td  align=left>
					<%=group_contact_phone%>
				</td>
					<td  align=left>
					<%=website%>
				</td>
				<%if(flag){%>
				<td  align=center>
					已推荐
				</td>
       <%}else{%>
	      <td  align=center>
					<a href=/doTradeReg.do?cust_id=<%=info_id%>&trade_type_code=2323 TARGET=_blank><img src=/images/edit.gif width=16 height=16 border=0 alt="推荐企业">
					</a>
				</td>

    <%}%>
			</tr>
			<%}
				}
			%>
			<tr class="u1">
				<%=pageTools%>
			</tr>
		</table>
	<input type="hidden" name="trade_type_code" value="8726" />
	<input type="hidden" name="sale_id" value="" id="sale_id">
</form>
	</body>
</html>




