<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.saas.biz.enquirytrackMgr.EnquirytrackInfo"%>
<%@ page import="com.saas.biz.commen.ParamethodMgr"%>
<%@ page contentType="text/html;charset=GBK"%>
<jsp:useBean id="tools" class="com.saas.biz.commen.PageTools" scope="page" />
<%
	 request.setCharacterEncoding("gbk");
     String start_time1 ="",end_time1 ="",code="",key_word="";
     Calendar cal = Calendar.getInstance();
     if (request.getParameter("start_time") != null) {
		start_time1 = request.getParameter("start_time");
	}
	if (request.getParameter("end_time") != null) {
		end_time1 = request.getParameter("end_time");
	}
	if (request.getParameter("code") != null) {
		code = request.getParameter("code");
	}
	if (request.getParameter("key_word") != null) {
		key_word = request.getParameter("key_word").trim();
	}
	String start_time = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
	String end_time = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
%>
<%
   HttpSession  logsession = request.getSession(); 
    String user_id = "";
    String iStart ="1";
    String meun_idx="";
    if (request.getParameter("iStart") != null)
    {
        iStart = request.getParameter("iStart");
    }
    if (logsession.getAttribute("SESSION_USER_ID") != null)
    {
        user_id = logsession.getAttribute("SESSION_USER_ID").toString();
    }
    if (request.getParameter("menu_id") != null)
    {
        meun_idx = request.getParameter("menu_id");
        logsession.setAttribute("menu_id",meun_idx);
    }
    if( logsession.getAttribute("menu_id")!= null)
    {
       meun_idx=(String)logsession.getAttribute("menu_id");
    }
  EnquirytrackInfo enquiryObj=new EnquirytrackInfo();
  int counter = 0 ;
  ArrayList newsList = new ArrayList();
  if("1".equals(code)){
  	newsList = enquiryObj.getSaleListBySendKey(Integer.valueOf(iStart).intValue(),user_id,key_word);
    counter=enquiryObj.getSaleNumberBySendKey(user_id,key_word);

  }else if("2".equals(code)){
  	newsList = enquiryObj.getStockListByUserDate(Integer.valueOf(iStart).intValue(),user_id,start_time1,end_time1);
    counter=enquiryObj.getStockNumberByUserDate(user_id,start_time1,end_time1);

  }else {
  	newsList = enquiryObj.getSaleListByUser(Integer.valueOf(iStart).intValue(),user_id);
  	// ParamethodMgr paramObj=new ParamethodMgr();
  	//HashMap typeMap=paramObj.getCompareInfoByCode("CRM","news_type");
    counter=enquiryObj.getSaleNumberByUser(user_id);

   }
String pageTools=tools.getPageTools(String.valueOf(counter),"30","receivSaleIndex.jsp?&code="+code+"&key_word="+key_word+"&start_time="+start_time1+"&end_time="+end_time1+"&iStart=",Integer.parseInt(iStart));
%>
<html>
<head>
<title>B2B电子商务后台管理系统</title>
<link href="/style/css.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css"  href="../style/mg.css"/>
<link href="/style/layout.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/js/Calendar_Ly.js"></script>
<style type="text/css">
.line6 {width:72spx; width:70spx!important;border:#ffcb99 1px solid;  background-color:#fff8ee; text-align:left; padding-left: 20px;padding-top: 10px;padding-bottom: 10px; color:#000000; margin-top:13px;}   /*横栏样式6---- 头部提醒1*/
.line6 .img{width:53px; height:53px; float:left; margin-right:20px;}
.line6 .title {font-size:14px; font-weight:bold; color:#ff5400;}
.line1 {border-left:#ff7300 3px solid; background-color:#e2e2e2; color:#333333;text-align:left; font-size:12px;}  /*横栏样式1*/
</style>
<script language="javascript">
	  function Check_Value(){
	       if(document.getElementById("start_time").value ==null || document.getElementById("start_time").value ==""){
	        alert("请选择开始时间！");
	        return false;
	       }
	       if(document.getElementById("end_time").value ==null || document.getElementById("end_time").value ==""){
	        alert("请选择结束时间！");
	        return false;
	       }
	       	document.getElementById("code").value="2";
	    document.indexdateform.submit();
	  }
	  function Change()
	  {
	  	document.getElementById("keyword").value="";
	  	
	  }
	 function search(){
	 	document.getElementById("code").value="1";
	 	document.indexdateform.submit();
	 		
	 }
</script>
</head>
<body>
<center>
	<form action="receivSaleIndex.jsp" method="post" name="indexdateform">
		
		<table width="800" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
					<td height="30"> 
					</td>
			</tr>
		  <tr>
				<td background="/admin/images/content_03.gif" height="43" width="156" align="center"><font size="2"><b>供应留言</b></font></td>
				<td background="/admin/images/content_04.gif" align="right">&nbsp;
				</td>
				<td width="8"><img src="/admin/images/content_06.gif"></td>
		  </tr>
	  </table>
	  
		<table  width="800" border=0 cellpadding=2 cellspacing=1 bgcolor="#dddddd">
			<tr bgcolor="white">
				<td align="left">
					开始时间:<input type="text" id="start_time" name="start_time" onfocus="setday(this);" value="<%=start_time%>">
					结束时间:<input type="text" id="end_time" name="end_time" onfocus="setday(this);" value="<%=end_time%>">
					<img src="/admin/images/chaxun.gif" onclick="Check_Value();" style="cursor:hand;">
	
				</td>
			</tr>
		</table>
		
		<table width="800" border=0 cellpadding=2 cellspacing=1 bgcolor="#dddddd">		
			<tr bgcolor="white">
				<td align="left">
				关键字:<input type="text" id="keyword1" name="key_word"  value="">
					<input type="hidden" name="code" value="">
					<img src="/admin/images/chaxun.gif" onclick="search();" style="cursor:hand;">	
				</td>
			</tr>
		</table>
	
		<%if(null==newsList && ("1".equals(code)||"2".equals(code))) {%>
			很抱歉！没有您要查询的记录。
		<%} else{%>
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td>
		     <table width=800 border=0 cellpadding=2 cellspacing=1 align=center bgcolor="#e7e7e7">
		        <tr>
			        <td style="background-color:#e2e2e2; color:#000000;  font-weight:bold; font-size:13px;"  align=center width="25%">销售主题</td>
					<td style="background-color:#e2e2e2; color:#000000;  font-weight:bold; font-size:13px;" align=center width="30%">留言内容</td>
					<td style="background-color:#e2e2e2; color:#000000;  font-weight:bold; font-size:13px;" align=center width="10%">留言人</td>
					<td style="background-color:#e2e2e2; color:#000000;  font-weight:bold; font-size:13px;" align=center width="10%">留言时间</td>
					<td style="background-color:#e2e2e2; color:#000000;  font-weight:bold; font-size:13px;" align=center width="10%">处理状态</td>
					<td style="background-color:#e2e2e2; color:#000000;  font-weight:bold; font-size:13px;" align=center width="10%" >处理</td>
		        </tr>
		        <%
		            if(newsList != null && newsList.size()>0)
		            {    int i=0;
		              	 for (Iterator it = newsList.iterator(); it.hasNext();)
		                  {
						        HashMap map = (HashMap) it.next();
						        String trade_id=map.get("trade_id").toString();
						        String title="";
						        String user_name="";
						        String enquiry_content="";
						        String enquiry_date="";
						        String deal_tag="";
						        if(map.get("title")!=null)
						        {
						         title=map.get("title").toString();
						        }
						         if(map.get("user_name")!=null)
						        {
						         user_name=map.get("user_name").toString();
						        }
						        if(map.get("enquiry_content")!=null)
						        {
						          enquiry_content=map.get("enquiry_content").toString();
						          if(enquiry_content.length()>30)
						          {
						             enquiry_content=enquiry_content.substring(0,30)+"...";
						          }
						         }
						         if(map.get("enquiry_date")!=null)
						        {
						          enquiry_date=map.get("enquiry_date").toString();
						          if(enquiry_date.length()>10)
						          {
						             enquiry_date=enquiry_date.substring(0,10);
						          }
						         }
						         if(map.get("rsrv_str1")!=null)
						        {
						          deal_tag=map.get("rsrv_str1").toString();
						          deal_tag=deal_tag.equals("0")?"未处理":"已处理";
						        }
						        %>
						        
						        <tr  style="background-color:#f9f9f9; " id="changcolor_tr<%=i%>" onmouseover="MM_changeProp('changcolor_tr<%=i%>','','backgroundColor','#ffffff','DIV')" onmouseout="MM_changeProp('changcolor_tr<%=i%>','','backgroundColor','#f9f9f9','DIV')">
					              <td  style=" color:#000000;" align=left><%=title%></td>
					              <td  style=" color:#000000;" align=left><%=enquiry_content%></td>
					              <td  style=" color:#000000;" align=left><%=user_name%></td>
					              <td  style=" color:#000000;" align=left><%=enquiry_date%></td>
					              <td  style=" color:#000000;" align=left><%=deal_tag%></td>
					              <td  style=" color:#000000;" align=center><a href=trackLevelInfo.jsp?trade_id=<%=trade_id%> target=blank><img src=/images/del.gif width=16 height=16 border=0></a></td>
					            </tr>
					            
						        <%i++;
					     }
					     %>
					     
					     <tr>
							<%=pageTools%>
				         </tr>
					     
					     <%
		            }
		        %>
		    </table>
	     </td>
	  </tr>
	  <tr>
	    <td height="13"></td>
	  </tr>
	</table>
	<%}%>
	
	</form>	
</center>
</body>
</html>



