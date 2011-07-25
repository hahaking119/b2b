<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html;charset=GBK"%>
<jsp:useBean id="bean" class="com.saas.biz.organizeMgr.OrganizeInfo" scope="page" />
<jsp:useBean id="comm" class="com.saas.biz.commen.commMethodMgr" scope="page" />
<%
 
	String iStart = "0";
    if (request.getParameter("iStart") != null)
    {
        iStart = request.getParameter("iStart");
    }
    HttpSession htSe=request.getSession();
    String cust_id=(String)htSe.getAttribute("SESSION_CUST_ID");
		String up_orga_id="000000000000000";
		if(request.getParameter("org_id")!=null){
			up_orga_id = request.getParameter("org_id");
		}
		ArrayList list=bean.getOrganizeByUpIdList(Integer.valueOf(iStart).intValue(),cust_id,up_orga_id);
		String org_idx="";
		if(list !=null && list.size()>0){
	  	HashMap map=(HashMap)list.get(0);
	  	org_idx=map.get("org_id").toString();
		}
		String cust_name=bean.getCustNameById(cust_id);
		int counter =0;
		if(null!=list && list.size()>0){
			counter = list.size();
		}
    int pages=(counter-1)/20+1;
	int pageUp=0,pageDown=0;
	int currenPage=Integer.valueOf(iStart).intValue();
	if(pages>currenPage)
	{
	   if(currenPage>0)
	   {
		pageUp=currenPage-1;
	   }
		pageDown=currenPage+1;
	}
    else if(pages==currenPage)
	{
	   pageUp=currenPage-1;
	   pageDown=currenPage;
	}
		
		
%>
<html>
	<head>
		<title>单位管理</title>
		<link href="/style/layout1.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="/ext/resources/css/ext-all.css" />
		<script type="text/javascript" src="/ext/adapter/ext/ext-base.js"></script>
		<script type="text/javascript" src="/ext/ext-all.js"></script>
		<script language="JavaScript" src="/js/organizeMgr.js"></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/OrganizeInfo.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
		<script type="text/javascript">
		function delOrUpdatedelet(formobj){
  	    if(window.confirm('你确定要删除吗？')) {  	    
  	       if(Check_Value()){
    	        if(checkChildren()){
    	        }
  	        }
  	    }
    	    else{
    	        return;
    	    }
    	}
    function checkChildren(){
	     var cust=document.getElementById("cust_id").value;
	     var org_id=document.getElementById("org_id").value;
	     OrganizeInfo.checkChildren(cust,org_id,hasChildren);
   }
   function hasChildren(data){
    	document.getElementById("del").value=data;
	 		if(document.getElementById("del").value=="0"){
        	document.getElementById("trade_type_code").value="1037";
	   			document.resumeForm.submit();   	
     	}else{
       alert("不能删除该组织，如果要删除，请先删除下级组织！");
       return false;
     }
   }
			function selAllNews(){
					var size = document.getElementById('size').value;
					for(var i=0;i<size;i++){
							document.getElementById('re_news'+i).checked = true;
					}
			}
			function delAllNews(){
					var size = document.getElementById('size').value;
					for(var i=0;i<size;i++){
							if(document.getElementById('re_news'+i).checked==true){
								document.getElementById('re_news'+i).checked = false;	
							}else{
								document.getElementById('re_news'+i).checked = true;		
							}
					}
			}
			function reloadNews(val){
					var size = document.getElementById('size').value;
					var all_news_id='';
					for(var i=0;i<size;i++){
						if(document.getElementById('re_news'+i).checked==true){
								all_news_id += document.getElementById('re_news'+i).value+'|';
						}
					}
					document.getElementById('org_id').value = all_news_id;
					//document.write(all_news_id);
					if(all_news_id==''){
						alert('请至少选择一条!');
						return false;
					}else {
								document.indexdateform.action='/doTradeReg.do';
								document.getElementById("trade_type_code").value="1699";
								document.indexdateform.submit();
					}
			}
		</script>
	</head>
	<body>
		<form action="" method="post" name="indexdateform">
			<%
				String top_menu_id="";
				if (request.getParameter("menu_id") != null){
		        top_menu_id = request.getParameter("menu_id");
		    }
			%>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr class="u1">
				<td colspan=3 align="left" class="head">
					<a href="orgIndex.jsp">添加部门</a>
				</td>
			</tr>
		</table>
				<table border="0" cellspacing="1" cellpadding="1" bgcolor="#98D9A2" width="100%" align="center">
					
					<tr class="u4" height="25">
							<td width="30%" align="left">
								部门名称
							</td>
							<td width="30%" align="left">
								部门描述
							</td>
							<td width="15%" align="left">
								录入日期
							</td>
							<td width="10%" align="center">
								修改
							</td>
							<!--td width="10%" align="center">
								删除
							</td-->
				<td width="15%" align="center">
						<input type="button" name="reload" value="删除" onclick="reloadNews(2)"/>
						<input type="button" name="selAll" value="全选" onclick="selAllNews()"/>
						<input type="button" name="delAll" value="反选" onclick="delAllNews()"/>
				</td>
					</tr>
						<%
							String org_id="",org_name="",org_desc="",in_date="";
							if(list!=null && list.size()>0){
							int size = list.size();
								for(int i=0;i<list.size();i++){
									HashMap orgMap = (HashMap)list.get(i);
									if(orgMap.get("org_id")!=null){
										org_id = orgMap.get("org_id").toString();
									}
									if(orgMap.get("org_name")!=null){
										org_name = orgMap.get("org_name").toString();
									}
									if(orgMap.get("org_desc")!=null){
										org_desc = orgMap.get("org_desc").toString();
									}
									if(orgMap.get("in_date")!=null){
										in_date = orgMap.get("in_date").toString();
									}
									ArrayList downlist=bean.getOrganizeByUpIdList(cust_id,org_id);
						%>
							<tr class="u2">
									<td>
										<%
											if(downlist!=null && downlist.size()>0){
										%>
											<a href="delOrUpdate.jsp?org_id=<%=org_id%>&menu_id=<%=top_menu_id%>" title="点击进入子部门！"><%=org_name%></a>
										<%
											}else{
										%>
											<font color="black"><%=org_name%></font>
										<%
											}
										%>
									</td>
									<td>
											<%=org_desc%>
									</td>
									<td align="left">
											<%=in_date%>
									</td>
									<td align="center">
											<a href="updateOrg.jsp?org_id=<%=org_id%>" ><img src=/images/edit.gif width=16 height=16 border=0></a>
									</td>
									<td align="center">
										
										<%
											if(downlist!=null && downlist.size()>0){
										%>
											<!--img src=/images/del.gif width=16 height=16 border=0 style="cursor:hand;" onclick="javascript:alert('此分类有子分类，不能删除！');"/-->
											<a href="delOrUpdate.jsp?org_id=<%=org_id%>&menu_id=<%=top_menu_id%>" title="点击进入子部门,进行删除操作！">
											<img src=/images/next.png width=16 height=16 border=0 style="cursor:hand;">
											</a>
												<input type="hidden" name="re_news<%=i%>" id="re_news<%=i%>" value="" />
										<%
											}else{
										%>
											<!--a href="/doTradeReg.do?org_id=<%=org_id%>&trade_type_code=1037" target="_self"><img src=/images/del.gif width=16 height=16 border=0></a-->
												<input type="checkbox" name="re_news<%=i%>" id="re_news<%=i%>" value="<%=org_id%>" />
												<input type="hidden" name="size" value="<%=size%>" id="size" />
										<%
											}
										%>
									</td>
							</tr>
						<%
								}
							}%>
							
        <tr class="u1">
          <td  align="left" colspan="3" style="font-weight:normal; padding:2px 5px;">共<%=counter%>条 &nbsp;第<%=Integer.parseInt(iStart)+1 %>页&nbsp;&nbsp;共<%=pages%>页</td>
          <td  align="right" colspan="4"  style=" padding:2px 5px;">
		  			<a href="index.jsp?iStart=0">首页 </a>&nbsp; &nbsp;
            <% 
							if(Integer.parseInt(iStart)>0){
						%>
            <a href="index.jsp?iStart=<%=pageUp%>">上一页</a> &nbsp;
            <%
							}
							if(Integer.parseInt(iStart)<pages-1){
						%>
            <a href="index.jsp?iStart=<%=pageDown%>">下一页 </a>&nbsp;
            <%
							}
						%>
            <a  href="index.jsp?iStart=<%=pages-1%>">尾页</a></td>
			        </tr>
							
							
							<%if(list==null || list.size()<=0){
						%>
							<tr>
									<td align="center" bgcolor="white" colspan="5">
										无子部门！
									</td>
							</tr>
						<%		
							}
						%> 
						<input type="hidden" id="org_id" name="org_id"  value="">
						<input type="hidden" id="trade_type_code" name="trade_type_code"  value="">
				</table>
			</form>						
	</body>
</html>




