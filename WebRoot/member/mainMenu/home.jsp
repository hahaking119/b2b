<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.saas.biz.organizeMgr.OrganizeInfo"%>
<jsp:useBean id="classinfo" class="com.saas.biz.custMgr.CustClass" scope="page" />
<%@ page import="com.saas.biz.enquirytrackMgr.EnquirytrackInfo"%>
<%@ page import="com.saas.biz.leavewordsMgr.LeavewordsInfo"%>
<%@ page import="com.saas.biz.saleMgr.SaleInfo"%>
<%@ page import="com.saas.biz.stockorderMgr.Stockorderinfo"%>
<%@ page import="com.saas.biz.enquirydealMgr.EnquirydInfo"%>
<%@ page import="com.saas.biz.saleMgr.SaleInfo"%>
 
<jsp:useBean id="property" class="com.saas.biz.propertyuMgr.PropertyuInfo" scope="page" />
<%
	String user_id = "", cust_id = "";
	HttpSession index_session = request.getSession();
	if (index_session.getAttribute("SESSION_USER_NAME") != null) {
		cust_id = index_session.getAttribute("SESSION_CUST_ID").toString();
		user_id = index_session.getAttribute("SESSION_USER_ID").toString();
	}
	//ȡ��Ա����
	
	String cust_class = classinfo.getCustClassById(cust_id);

	//ȡ�û�����
	OrganizeInfo organ = new OrganizeInfo();
	EnquirydInfo enquirydInfo = new EnquirydInfo();
	String cust_name = organ.getCustNameById(cust_id);

	//ȡ�û��Ƹ�
	String money = property.getUserPropertyValue(user_id, "0");

	//ȡ�û��Ƹ��ȼ�
	int moneys = Integer.parseInt(money);

	//ȡ����
	EnquirytrackInfo enquiryObj = new EnquirytrackInfo();
	int counter1 = enquirydInfo.getEnquriyInfoByTag(user_id, "0", "0");
	LeavewordsInfo enquiryObjs = new LeavewordsInfo();
	int counter2 = enquirydInfo.getEnquiryList(cust_id);
	int counter3 = enquiryObj.getSaleNumberByUser(user_id);

	//ȡ�����Ĺ�Ӧ��Ϣ
	SaleInfo processObj = new SaleInfo();
	int pro_counter1 = processObj.getSaleListNum(cust_id);
	int pro_counter2 = processObj.getOffSaleListNum(cust_id);

	//ȡ�����Ĳɹ���Ϣ
	Stockorderinfo stockObj = new Stockorderinfo();
	int st_counter1 = stockObj.getStockListNumber(cust_id);
	int st_counter2 = stockObj.getOffStockListNumber(cust_id);

 
%>
<HTML>
	<HEAD>
		<title>B2B���������̨����ϵͳ</title>
		<META http-equiv="Content-Type" content="text/html; charset=gb2312">
		<LINK href="images/member.css" type="text/css" rel="stylesheet">
		<link href="css/vip.css" rel="stylesheet" type="text/css">
		<link href="/style/new_layout.css" rel="stylesheet" type="text/css" />
		<link rel="shortcut icon" href="/images/favicon.ico" />
		<link rel="Bookmark" href="/images/favicon.ico" />
		<script type="text/javascript" src="/js/prototype.js"></script>
		<script type="text/JavaScript">
		<!--
		function MM_preloadImages() { //v3.0
		  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
		    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
		    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
		}
		//-->
		window.onload=function()
		{
			
			setCustWeb('web_div');
		}
		function setCustWeb( web_div )
		{  
		 	var data = Math.round(Math.random() * 10000);
			
			var myAjax = new Ajax.Updater(web_div,
					'/member/mainMenu/custweb.jsp?data=' + data, {
						method : 'get',
						evalScripts : true
					});
		 
		}
		</script>
		<style type="text/css">
BODY {
	MARGIN: 20px 5px 10px 5px
}

A {
	text-decoration: underline;
}

A:hover {
	COLOR: orange;
	text-decoration: none;
}
html { overflow-x: hidden; overflow-y: auto; }  dfasdf
</style>
	</HEAD>
	<body  >
		<table cellspacing="0" cellpadding="0" width="95%" border="0">
			<tbody>
				<tr>
					<td class="mtitle">
						�ҵ�״̬
					</td>
				</tr>
			</tbody>
		</table>
		<TABLE cellSpacing="0" cellPadding="0" width="95%" border="0" vAlign="top">
			<TBODY>
				<TR>
					<TD vAlign="top" bgcolor="#ffffff">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0" class="zhuangtai">
										<tr>
											<td>
												&nbsp;&nbsp;&nbsp;�𾴵�
												<span class="title14red"> <%=cust_name%> </span> �û� &nbsp;
												<br>
												&nbsp;&nbsp;&nbsp;���л���:
												<span class="shuzi"><%=money%>
												</span>��
												<a href="/huodong/jingbi/default.html" target=_blank> <img src="/admin/images/ask.gif" width="14" height="14" alt="�Ƹ�˵��" border="0"></img> </a> &nbsp;�ȼ�:
												<%
												 if (moneys > 0 && moneys < 300) {
												 %>
												<img src="/admin/images/star1.gif" width="14" height="12" alt="һ��" />
												<%
												} else if (moneys > 301 && moneys < 1500) {
												%>
												<img src="/admin/images/star2.gif" width="28" height="12" alt="����" />
												<%
												} else if (moneys > 1501 && moneys < 3000) {
												%>
												<img src="/admin/images/star3.gif" width="42" height="12" alt="����" />
												<%
												} else if (moneys > 3001 && moneys < 10000) {
												%>
												<img src="/admin/images/star4.gif" width="56" height="12" alt="����" />
												<%
												} else if (moneys > 10000) {
												%>
												<img src="/admin/images/star5.gif" width="70" height="12" alt="����" />
												<%
												}
												%>
												&nbsp;&nbsp;&nbsp;׬ȡ����Ļ��֣�
												<A href="/member/saleMgr/addSale.jsp" target="_self">���Ϸ�����Ϣ!</A>
												<br>
												<TABLE cellSpacing="0" cellPadding="5" width="100%" border="0">
													<TR>
														<TD>
															<span style="float:left;line-height:17px; height:17px;">&nbsp;&nbsp;�ҵ���ҵվ: </span>
															<div id="web_div"><img src="/images/wait.gif" border="0">&nbsp;<font color="#996666" style="height:17">����,��ҵվ��������...</font></div>
														</TD>
													</TR>
												</TABLE>
											</td>
										</tr>
									</table>
									<TABLE cellSpacing="1" cellPadding="0" width="100%" align="center" bgColor="#85aad6" border="0">
										<TBODY>
											<TR>
												<TD width="15%" height="24" noWrap bgColor="#ffffff">
													&nbsp;&nbsp;
													<IMG height="8" alt="" src="/images/icon_01.gif" width="4" align="middle">
													&nbsp;
													������Ϣ
												</TD>
												<TD align="left" width="63%" bgColor="#ffffff" colspan="2">
													&nbsp;&nbsp; �������յ�:
													<A href="/member/stockQuotedMgr/index.jsp?menu_id=3CL6681y73wON8e23&info_type=2" target=""><FONT color="#ff6600"><B> <%=counter1%> </B> </FONT>���ɹ����ԣ�</A>
													
													<A href="/member/saleInquiryMgr/index.jsp?menu_id=3CL6681y73wON8e0" target=""><FONT color="#ff6600"><B> <%=counter3%> </B> </FONT>����Ӧ���ԣ�</A>
												</TD>
											</TR>
											<TR>
												<TD noWrap bgColor="#ffffff" height="24">
													&nbsp;&nbsp;
													<IMG height="8" alt="" src="/images/icon_01.gif" width="4" align="Middle">
													&nbsp;
													<a href="/member/saleMgr/modifyIndex.jsp?menu_id=8R6G2735406gtBi">��Ӧ��Ϣ</a>
												</TD>
												<TD align="left" width="63%" bgColor="#ffffff">
													&nbsp;&nbsp; ���ѷ���
													<FONT color="#ff6600"><B> <%=pro_counter1%> </B> </FONT>����Ӧ��Ϣ��
													<FONT color="#ff6600"><B> <%=pro_counter2%> </B> </FONT>�����ڣ�
												</TD>
												<TD class="t14line" align="center" width="22%" bgColor="#ffffff">
													<A class="f" href="/member/saleMgr/addSale.jsp" target="">������Ӧ��Ϣ</A>
												</TD>
											</TR>
											<TR>
												<TD noWrap bgColor="#ffffff" height="24">
													&nbsp;&nbsp;
													<IMG height="8" alt="" src="/images/icon_01.gif" width="4" align="Middle">
													&nbsp;
													<a href="/member/stockMgr/modifyIndex.jsp?menu_id=MtBJR5fo7654ib8">����Ϣ</a>
												</TD>
												<TD class="t14line" align="left" width="63%" bgColor="#ffffff">
													&nbsp;&nbsp; ���ѷ���
													<FONT color="#ff6600"> <B> <%=st_counter1%> </B> </FONT>���ɹ���Ϣ��
													<FONT color="#ff6600"><B> <%=st_counter2%> </B> </FONT>�����ڣ�
												</TD>
												<TD class="t14line" align="center" width="22%" bgColor="#ffffff">
													<A class="f" href="/member/stockMgr/addstockindex.jsp" target="">�����ɹ���Ϣ</A>
												</TD>
											</TR>
										</TBODY>
									</TABLE>  
									<table width="100%"><tr><td height="10"></td></tr></table>
									<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
										<TBODY>
											<TR>
												<TD vAlign="top" bgcolor="#ffffff">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td>
																<table cellspacing="0" cellpadding="0" width="100%" border="0" style="display:none"> 
																	<tr>
																		<td class="mtitle">
																			��������
																		</td>
																	</tr>
																</table>
																<TABLE style="BORDER: #85aad6 1px solid;display:none" cellSpacing="0" cellPadding="8" width="100%" align="center" border="0">
																	<TR>
																		<TD class="t14" noWrap bgColor="#ffffff" height="24">
																			<table width="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td>
																						<a href="/service/vip.html" target="_blank"><img src="images/192x96_070719_anquan.gif" width="171" height="93" border="0"> </a>
																					</td>
																					<td>
																						<a href="/service/keyword.html" target="_blank"><img src="images/192x96_070719_jingjiapaimin.gif" width="171" height="93" border="0"> </a>
																					</td>
																					<td>
																						<a href="/service/webad.html" target="_blank"><img src="images/192x96_070719_mingqi.gif" width="171" height="93" border="0"> </a>
																					</td>
																					<td>
																						<a href="/service/website.html" target="_blank"><img src="images/192x96_070719_shangbiao.gif" width="171" height="93" border="0"> </a>
																					</td>
																				</tr>
																			</table>
																		</TD>
																	</TR>
																</TABLE>
																<table width="100%"><tr><td height="10"></td></tr></table>
																<table cellspacing="0" cellpadding="0" width="100%" border="0">
																	<tbody>
																		<tr>
																			<td class="mtitle">
																				��ϵ����
																			</td>
																		</tr>
																	</tbody>
																</table>
																<TABLE style="BORDER: #85aad6 1px solid;" cellSpacing="0" cellPadding="8" width="100%" align="center" border="0">
																	<TBODY>
																		<TR>
																			<TD class="t14" noWrap bgColor="#ffffff" height="24">
																				<TABLE cellSpacing="0" cellPadding="0" width="98%" align="center" border="0">
																					<TBODY>
																						<TR>
																							<TD align="right" width="3%" height="20">
																								��&nbsp;
																							</TD>
																							<TD class="eng" width="97%" height="18">
																								���˽����������ݣ�����ϵ���ǡ��绰��0551-5310317 
																								<img src="images/ppc.gif">
																							</TD>
																						</TR>
																						<TR>
																							<TD align="right" width="3%" height="20">
																								��&nbsp;
																							</TD>
																							<TD class="t12line" height="18">
																								���ڱ���վ������������⣬����ϵ
																								<A href="mailto:wrcwang@gmail.com">wrcwang@gmail.com</A>
																							</TD>
																						</TR>
																						<TR>
																							<TD align="right" height="20">
																								��&nbsp;
																							</TD>
																							<TD class="eng" height="18">
																								���߿ͷ���
																								<a href="tencent://message/?uin=923462250&Site=bizoss&Menu=yes"><img border="0" SRC="/images/qq.gif" alt="ϵͳ�ͷ�QQ"> </a>
																							</TD>
																						</TR>
																					</TBODY>
																				</TABLE>
																			</TD>
																		</TR>
																	</TBODY>
																</TABLE>
															</td>
														</tr>
													</table>
												</TD>
											</TR>
										</TBODY>
									</TABLE>
								</td>
							</tr>
						</table>
					</TD>

				</TR>
			</TBODY>
		</TABLE>
        <!--�ײ�-->
    
 
 
	</body>
</HTML>


