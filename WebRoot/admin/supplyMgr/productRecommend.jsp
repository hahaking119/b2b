<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.saas.biz.saleMgr.SaleInfo"%>
<%@ page import="com.saas.biz.infoListMgr.InfoList"%>
<%@ page import="com.saas.biz.productMgr.*"%>
<jsp:useBean id="tools" class="com.saas.biz.commen.PageTools" scope="page" />
<%
	    request.setCharacterEncoding("gbk");
	 		String info_id ="";
			String title = "";
			String sale_addr = "";
			String product_name="";
			String product_desc="";
			String product_site="";
			String publish_date="";
			String content = "";
			String sale_price = "";
			String contents="";
			boolean flag=false;
	HttpSession logsession = request.getSession();
	String cust_id = "";
	String iStart = "0";
	String pro_name="";
	ProductInfo product = new ProductInfo();
	if (request.getParameter("iStart") != null) {
		iStart = request.getParameter("iStart");
	}
	if (logsession.getAttribute("SESSION_CUST_ID") != null) {
		cust_id = logsession.getAttribute("SESSION_CUST_ID").toString();
	}
	SaleInfo saleObj = new SaleInfo();
	int counter = 0 ;
	ArrayList saleList = new ArrayList();

		//saleList = saleObj.productCommend(Integer.valueOf(iStart).intValue(), 10);
		//counter = saleObj.productCommend();
		saleList = product.getAllProductInfoById(Integer.parseInt(iStart));
		counter = product.getAllProductInfoById();
		
		int pages = (counter-1) / 20 + 1;
		int pageUp = 0, pageDown = 0;
		int currenPage = Integer.valueOf(iStart).intValue();
		if (pages > currenPage) {
			if (currenPage > 0) {
				pageUp = currenPage - 1;
			}
			pageDown = currenPage + 1;
		} else if (pages == currenPage) {
			pageUp = currenPage - 1;
			pageDown = currenPage;
		}
	//String pageTools=tools.getPageTools(String.valueOf(counter),"30","productRecommend.jsp?iStart=",Integer.parseInt(iStart));
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
	  	 <!--table width="800" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
			<td height="30"> 
			</td>
			</tr>
      <tr>
			  <td background="/admin/images/content_03.gif" height="43" width="156" align="center"><font size="2"><b>产品推荐</b></font></td>
				<td background="/admin/images/content_04.gif" align="right">&nbsp;</td>						
				<td background="/admin/images/content_04.gif" align="right">&nbsp;</td>
				<td width="8"><img src="/admin/images/content_06.gif"></td>				

		  </tr>
	  </table-->
		<table width=100% border="0" cellpadding="1" cellspacing="1" align=center bgcolor="#FCB0B0" style="margin-top:13px">
			<tr class="u4" height="25">
				<td  align=center width="20%">
					产品名称
				</td>

				<td align=center width="15%">
					产品说明
				</td>
				<td  align=center width="15%">
					供应地
				</td>
				<td   align=center width="10%">
				  发布日期
				</td>
				<td  align=center width="10%">
					推荐
				</td>
				<td  align=center width="10%">
					热门产品
				</td>
			</tr>
			<%
				InfoList infoList = new InfoList();				
				String address = "",addr = "",product_type="";
			%>
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
						if (map.get("product_type") != null) {
					      product_type = map.get("product_type").toString();
						}					
						if (map.get("info_id") != null) {
					      info_id = map.get("info_id").toString();
					      address = infoList.getChannelSaveDirByInfoId(info_id);
						}
						if (map.get("product_name") != null) {
					      product_name = map.get("product_name").toString();
					      if(product_name.length()>15){
					        	product_name = product_name.substring(0,15)+"..";
					       }
						}
						if (map.get("product_desc") != null) {
					        product_desc = map.get("product_desc").toString();
					       if(product_desc.length()>19){
					        	product_desc = product_desc.substring(0,19)+"..";
					        }
						}
						if (map.get("product_site") != null) {
					    product_site=map.get("product_site").toString();
						}
						
						if (map.get("publish_date") != null) {
					      publish_date=map.get("publish_date").toString();
					      publish_date=publish_date.substring(0,10);
						}
						addr = "/" + address + "/d/content-" + info_id +".html";
			%>
			<tr class="u2">
				<td  align=left>
					<a href="/admin/productMgr/modi_product_attr.jsp?product_id=<%=info_id%>" TARGET="">
						<%=product_name%>
					</a>
					
				</td>
				<td  align=left>
					<%=product_desc%>
				</td>

				<td  align=left>
					<%=product_site%>
				</td>
					<td  align=left>
					<%=publish_date%>
				</td>
				<%if(flag){%>
					<td  align="center">已推荐&nbsp;<font color="red">[<a href="/doTradeReg.do?contents=00&cust_id=<%=info_id%>&trade_type_code=9007" target="_self">取消</a>]</font></td>
       <%}else{%>
	      <td  align=center>
					<a href=/doTradeReg.do?cust_id=<%=info_id%>&trade_type_code=2323 TARGET=_self><img src=/images/edit.gif width=16 height=16 border=0 alt="产品推荐">
					</a>
				</td>
    <%}%>
				<td align="center">
					<%if(product_type.equals("1") || product_type.equals("0") || product_type.equals("2")){%>
					<a href=/doTradeReg.do?product_id=<%=info_id%>&trade_type_code=6458&product_type=3 TARGET=_self><img src=/images/bj.gif width=16 height=16 border=0 alt="热门产品">
					<%}else if(product_type.equals("3")){%>
					<font color="red">[<a href=/doTradeReg.do?product_id=<%=info_id%>&trade_type_code=6458&product_type=0 TARGET=_self>取消</a>]</font></td>
					<%}%>
			</tr>
			<%}
				}
			%>
			<tr>
							<td  align="left" colspan="3" style="font-weight:normal; padding:2px 5px;">共<%=counter%>条 &nbsp;第<%=Integer.parseInt(iStart)+1 %>页&nbsp;&nbsp;共<%=pages%>页</td>
							<td  align="right" colspan="5"  style=" padding:2px 5px;">
							<a href="productRecommend.jsp?iStart=0">首页 </a>&nbsp; &nbsp;
							<% 
								if(Integer.parseInt(iStart)>0){
							%>
								<a href="productRecommend.jsp?iStart=<%=pageUp%>">上一页</a> &nbsp;
							<%
								}
								if(Integer.parseInt(iStart)<pages-1){
							%>
								<a href="productRecommend.jsp?iStart=<%=pageDown%>">下一页 </a>&nbsp; 
							<%
								}
							%>
							<a  href="productRecommend.jsp?iStart=<%=pages-1%>">尾页</a></td>

				  </tr>
		</table>
	<input type="hidden" name="trade_type_code" value="8726" />
	<input type="hidden" name="sale_id" value="" id="sale_id">
</form>
	</body>
</html>




