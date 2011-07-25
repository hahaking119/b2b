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
    HttpSession htSe=request.getSession();
    String cust_id=(String)htSe.getAttribute("SESSION_CUST_ID");
		String up_orga_id="000000000000000";
		if(request.getParameter("org_id")!=null){
			up_orga_id = request.getParameter("org_id");
		}
		ArrayList list=bean.getOrganizeByUpIdList(cust_id,up_orga_id);
		String org_idx="";
		if(list !=null && list.size()>0){
	  	HashMap map=(HashMap)list.get(0);
	  	org_idx=map.get("org_id").toString();
		}
		String cust_name=bean.getCustNameById(cust_id);
		
		
		
%>
<html>
	<head>
		<title>��λ����</title>
		<link href="/style/layout.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="/ext/resources/css/ext-all.css" />
		<script type="text/javascript" src="/ext/adapter/ext/ext-base.js"></script>
		<script type="text/javascript" src="/ext/ext-all.js"></script>
		<script language="JavaScript" src="/js/organizeMgr.js"></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/OrganizeInfo.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
		<script type="text/javascript">
		function delOrUpdatedelet(formobj){
  	    if(window.confirm('��ȷ��Ҫɾ����')) {  	    
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
       alert("����ɾ������֯�����Ҫɾ��������ɾ���¼���֯��");
       return false;
     }
   }function selAllNews(){
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
						alert('������ѡ��һ��!');
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
					<a href="orgIndex.jsp">���Ӳ���</a>
				</td>
			</tr>
		</table>				
				<table border="0" cellspacing="1" cellpadding="1" bgcolor="#DEEDFD" width="100%" align="center">
						
					<tr class="u4" height="25">
							<td width="30%">
								��������
							</td>
							<td>
								��������
							</td>
							<td>
								¼������
							</td>
							<td>
								�޸�
							</td>
							<!--td>
								ɾ��
							</td-->
							
				<td width="15%" align="center">
						<input type="button" name="reload" value="ɾ��" onclick="reloadNews(2)"/>
						<input type="button" name="selAll" value="ȫѡ" onclick="selAllNews()"/>
						<input type="button" name="delAll" value="��ѡ" onclick="delAllNews()"/>
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
									<td align="left">
										<%
											if(downlist!=null && downlist.size()>0){
										%>
											<a href="delOrUpdate.jsp?org_id=<%=org_id%>&menu_id=<%=top_menu_id%>" title="��������Ӳ��ţ�"><%=org_name%></a>
										<%
											}else{
										%>
											<font color="black"><%=org_name%></font>
										<%
											}
										%>
									</td>
									<td align="left">
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
										<input type="hidden" name="re_news<%=i%>" id="re_news<%=i%>" value="" />
										<a href="delOrUpdate.jsp?org_id=<%=org_id%>&menu_id=<%=top_menu_id%>" title="��������Ӳ���,����ɾ��������">
											<img src=/images/next.png width=16 height=16 border=0 style="cursor:hand;">
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
							}else{
						%>
							<tr>
									<td align="center" bgcolor="white" colspan="5">
										���Ӳ��ţ�
									</td>
							</tr>
						<%		
							}
						%><tr>
          	<td height="30" colspan="5" align="center" style="background-color:#ffffff; color:#000000;  font-size:12px;">
          	 <a href="javascript:history.go(-1)">
          	 	<img src="/admin/images/comeback.JPG"  style=" border: 0;cursor: hand; text-align: center;">
          	 	</a>
          </td>
          </tr>
				</table>	
						<input type="hidden" id="org_id" name="org_id"  value="">
						<input type="hidden" id="trade_type_code" name="trade_type_code"  value="">
			</form>		
	</body>
</html>



