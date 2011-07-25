<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.saas.biz.custMgr.Custinfo"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URLDecoder"%>
<jsp:useBean id="tools" class="com.saas.biz.commen.PageTools"
	scope="page" />
<%
	String info_id = "";
	String cust_name = "";
	String cust_aim = "";
	String publish_date = "";
	String company_address = "";
	String group_contact_phone = "";
	String website = "";
	String contents = "";
	boolean flag = false;
	String cust_id = "";
	String iStart = "0";
	String code = "";
	String searchCust = "";
	String it = "0";
	if (request.getParameter("i") != null) {
		it = request.getParameter("i");
	}
	if (request.getParameter("iStart") != null) {
		iStart = request.getParameter("iStart");
	}
	Custinfo custInfo = new Custinfo();
	int counter = 0;
	String pageTools = "";
	ArrayList saleList = new ArrayList();
	String custName = "";
	if (request.getParameter("cust_name") != null) {
		custName = request.getParameter("cust_name");
		custName = URLDecoder.decode(custName, "GBK");
		custName = new String(custName.getBytes("ISO-8859-1"), "GBK");
	}
	if (custName.equals("")) {
		saleList = custInfo.getAllCustLinkInfoList(Integer.valueOf(
				iStart).intValue());
		counter = custInfo.getAllCustLinkInfoList();
	} else {
		saleList = custInfo.getAllCustLinkInfoListByKey(Integer
				.valueOf(iStart).intValue(), custName);
		counter = custInfo.getAllCustLinkInfoListByKey(custName);
	}

	int pages = (counter - 1) / 20 + 1;
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
%>
<html>
	<head>
		<title>��Ա�Ƽ�---B2B���������̨����ϵͳ</title>
		<link rel="stylesheet" type="text/css" href="../style/mg.css" />
		<link href="/style/layout.css" rel="stylesheet" type="text/css">
		<style type="text/css">
.chaxun {
	background: url(/admin/images/chaxun.gif) left center no-repeat;
	width: 70px;
	height: 26px;
	border: 0px;
	cursor: hand;
}
</style>
		<script language="javascript" src="/js/Calendar_Ly.js"></script>
		<script language="javascript" src="/js/saleMgr.js"></script>
		<script>
		
  function search(){
						if(document.getElementById('cust_name').value==''){
								alert('�����빫˾����');
								return false;
						}else{ 
						document.indexdateform.submit();
					}
				}
</script>
	</head>
	<body>

		<form action="commendenterp.jsp" method="post" name="indexdateform">
			<!--table width="800" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
			<td height="30" colspan="3"></td>
			</tr>
      <tr>
			   <td background="/admin/images/content_03.gif" height="43" width="156" align="center"><font size="2"><b>��Ա�Ƽ� </b></font></td>
				<td background="/admin/images/content_04.gif" align="right" width="636">&nbsp;</td>
				<td width="8"><img src="/admin/images/content_06.gif"></td>
		  </tr>
	  </table-->
			<table width=100% border="0" cellpadding="1" cellspacing="1"
				align=center bgcolor="#FCB0B0" style="margin-top: 1px">
				<tr bgcolor="white">
					<td align="left" colspan="7">
						<font size="2"><b> �����빫˾����:</b>
						</font>
						<input type="text" name="cust_name" id="cust_name" size="30">
						<img src="/admin/images/chaxun.gif" onclick="return search()"
							style="cursor: hand;">

					</td>
				<tr class="u4" height="25">
					<td align=left width="10%">
						����Ա����
					</td>
					<td align=left width="25%">
						��˾����
					</td>
					<td align=left width="15%">
						��˾��ַ
					</td>
					<td align=left width="15%">
						��ϵ�绰
					</td>
					<td align=left width="10%">
						��˾��վ
					</td>
					<td align=left width="10%">
						ע��ʱ��
					</td>
					<td align=center width="10%">
						�Ƽ�
					</td>
				</tr>
				<%
					if (saleList != null && saleList.size() > 0) {
						int size = saleList.size();
						for (int i = 0; i < saleList.size(); i++) {
							HashMap map = (HashMap) saleList.get(i);
							if (map.get("contents") != null) {
								contents = map.get("contents").toString();
								if (contents.length() > 1
										&& contents.substring(0, 1).equals("1")) {
									flag = true;
								} else {
									flag = false;
								}
							}
							if (map.get("contents") == null) {
								flag = false;
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
								group_contact_phone = map.get("group_contact_phone")
										.toString();
							}

							if (map.get("website") != null) {
								website = map.get("website").toString();
							}

							if (map.get("publish_date") != null) {
								publish_date = map.get("publish_date").toString();
								if (publish_date.length() > 10) {
									publish_date = publish_date.substring(0, 10);
								}
							}
							if (map.get("cust_aim") != null) {
								cust_aim = map.get("cust_aim").toString();
							}
				%>
				<tr class="u2">
					<td align=left>
						<%=cust_name%>
					</td>
					<td align=left>
						<a href="viewCustinfo.jsp?obj_cust_id=<%=info_id%>"> <%=cust_aim%>
						</a>
					</td>
					<td align=left>
						<%=company_address%>
					</td>
					<td align=left>
						<%=group_contact_phone%>
					</td>

					<td align=left>
						<%=website%>
					</td>
					<td align=left>
						<%=publish_date%>
					</td>
					<%
						if (flag) {
					%>
					<td align="center">
						���Ƽ�&nbsp;
						<font color="red">[<a
							href="/doTradeReg.do?contents=00&cust_id=<%=info_id%>&trade_type_code=9007"
							target="_self">ȡ��</a>]</font>
					</td>
					<%
						} else {
					%>
					<td align=center>
						<a href=/doTradeReg.do?cust_id= <%=info_id%>&trade_type_code=2323
							target="_self"><img src=/images/edit.gif width=16 height=16
								border=0 alt="�Ƽ���ҵ"> </a>
					</td>

					<%
						}
					%>
				</tr>
				<%
					}
					}
				%>
				<tr>
					<td align="left" colspan="2"
						style="font-weight: normal; padding: 2px 5px;">
						��<%=counter%>�� &nbsp;��<%=Integer.parseInt(iStart) + 1%>ҳ&nbsp;&nbsp;��<%=pages%>ҳ
					</td>
					<td align="right" colspan="5" style="padding: 2px 5px;">
						<a href="commendenterp.jsp?iStart=0&cust_name=<%=custName%>&i=1">��ҳ
						</a>&nbsp; &nbsp;
						<%
							if (Integer.parseInt(iStart) > 0) {
						%>
						<a
							href="commendenterp.jsp?iStart=<%=pageUp%>&cust_name=<%=custName%>&i=1">��һҳ</a>
						&nbsp;
						<%
							}
							if (Integer.parseInt(iStart) < pages - 1) {
						%>
						<a
							href="commendenterp.jsp?iStart=<%=pageDown%>&cust_name=<%=custName%>&i=1">��һҳ
						</a>&nbsp;
						<%
							}
						%>
						<a
							href="commendenterp.jsp?iStart=<%=pages - 1%>&cust_name=<%=custName%>&i=1">βҳ</a>
					</td>

				</tr>



			</table>
			<input type="hidden" name="trade_type_code" value="8726" />
			<input type="hidden" name="sale_id" value="" id="sale_id">
		</form>
	</body>
</html>


