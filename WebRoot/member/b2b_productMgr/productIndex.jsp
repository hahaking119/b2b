<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.saas.biz.custMgr.Custinfo"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="comm" class="com.saas.biz.commen.ParamethodMgr" scope="page" />
<jsp:useBean id="bean" class="com.saas.biz.commen.commMethodMgr" scope="page" />
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.saas.biz.channelMgr.ChannelInfo"%>
<jsp:useBean id="classBean" class="com.saas.biz.productclassMgr.Productclass" scope="page" />
<jsp:useBean id="proInfo" class="com.saas.biz.addproductMgr.AddProductInfo" scope="page" />
<%
	HttpSession logsession = request.getSession();
	String product_id = "", cust_id = "",user_id="";
	product_id = bean.GenTradeId();
	if (logsession.getAttribute("SESSION_USER_ID") != null) {
		user_id = logsession.getAttribute("SESSION_USER_ID").toString();
	}
	if (logsession.getAttribute("SESSION_CUST_ID") != null) {
		cust_id = logsession.getAttribute("SESSION_CUST_ID").toString();
	}
	String product_type = comm.getSelectItems("84");
	String unit = comm.getSelectItems("91");
	String select = classBean.getSelectedByComm("2", "1");	
	String up_id="000000000000000";
	if(request.getParameter("up_class_id") != null){
		up_id=request.getParameter("up_class_id").toString();
	}
	String class_id = "";
	if (request.getParameter("class_id") != null) {
		class_id = request.getParameter("class_id").toString();
	}
	ArrayList json = proInfo.getproductByUpId(cust_id, up_id);
 
	String ch_id=new ChannelInfo().getChIdByContMod("3");
	
	Calendar cal = Calendar.getInstance();
	cal.add(Calendar.MONTH, 3);
	String end_date = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
	
	String cust_type = "";
	Custinfo custInfo=new Custinfo();
	ArrayList listc=new ArrayList();
	listc =	custInfo.getCustomerByCustId(cust_id);
	if(null!=listc&&listc.size()>0){
	HashMap map=(HashMap)listc.get(0);
	if(null!=map.get("cust_type"))
	 cust_type=map.get("cust_type").toString();
	}
	
	
	
	
%>
<html>
	<head>
		<title>产品管理</title>
		<script type="text/javascript" src="/js/prototype.js"></script>
		<link href="/style/layout1.css" rel="stylesheet" type="text/css">		
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/Productclass.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/AddProductAttrInfo.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/AddProductInfo.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/Productclass.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
		<script type='text/javascript' src='supply.js'></script>

		<script language="JavaScript">
	
	
		function setProductDiv(class_id){
	   	document.getElementById('loading').style.display="block";
			var data=Math.round(Math.random()*10000);
			var myAjax = new Ajax.Updater('loading',
				'/member/addProductattrInfoMgr/modi_del_attr.jsp?class_id='+class_id+"&datas="+data, {
				method : 'post',
				evalScripts : true
			});
		}
	
	
		function clickSel(val,valId){
			if(document.getElementById(valId).checked==true){
				document.getElementById(valId).value = '1';
			}else{
				document.getElementById(valId).value = '0';
			}
		}
		
    	function Check_Value_My(){
			if(document.getElementById('title').value==''){
				alert('请填写产品名称！');
				document.getElementById('title').focus();
				return false;
			}
			if(document.getElementById('class_id').value==''){
				alert('请选择产品分类！');
				return false;
			}
			var str=product_desc.getText();
			str=str.replace(/\s*/g,''); 
			if(str == ''  ){
				alert('请填写商品描述内容！');
				return false;
			}
			if( str.length > 4000){
				 alert( '字数应少于4000字!' );
				 return false;	
			}
			
			document.getElementById('product_name').value = document.getElementById('title').value ;
		  document.getElementById('contents').value = document.getElementById('one').value + document.getElementById('two').value;  //+ document.getElementById('three').value;
	    return true;
		}
		function ShowColor(){
			var fcolor=showModalDialog("/member/custcms/color.htm?ok",false,"dialogWidth:106px;dialogHeight:110px;status:0;dialogTop:"+(window.event.clientY+120)+";dialogLeft:"+(window.event.clientX));
			if(fcolor!=null && fcolor!="undefined") document.newform.title_color.value = fcolor;
		}
   
		function secBoard(n)
		{
			for(i=0;i<2;i++) {
				if (i==n) {
					document.all('d' + n).className="c4";
				} else {
				document.all('d' + i).className="c3";}
			}
			
			for(i=0;i<2;i++) {
				if (i==n) {
					document.all('bo' + n).style.display="";					
				} else {
				document.all('bo' + i).style.display="none";}
			}

	}				
	</script>

	</head>
	<body>		
	<form name="newproductform" action="/doTradeReg.do" method="post" target="_self">
		<input type="hidden" name="product_name" id="product_name" />
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr class="u1">
				<td colspan=3 align="left" class="head">
					<a href="index.jsp">管理产品信息</a>
				</td>
			</tr>
		</table>
		
		
		
		
		
	<table width=100% border="0" cellspacing="0" cellpadding="0" align="center">
		<tr>
		<td>
			
			<%
							if(cust_type.equals("1")){
						%>
						<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
						
							<tr class="u4">
								<td width="76" height="28" align="left" class=c4 id="d0" onclick="javascript:secBoard(0)">
									产品信息
								</td>
								<td width="76" height="28" align="left" class=c3 id="d1" onclick="javascript:secBoard(1)">
									高级设置
								</td>
								<td>&nbsp;
									
								</td>
							</tr>
						</table>
						<%
							}
						%>
						<!--01-->
						<jsp:include  flush="true" page="/member/custcms/infolist.jsp">
							<jsp:param name="cont_mod" value="3"/>
							<jsp:param name="news_id" value="<%=product_id%>"/>
							<jsp:param name="ch_id" value="<%=ch_id%>"/>
							<jsp:param name="class_id" value="<%=class_id%>"/>
						</jsp:include>
						
						
			
			
		<table width="100%" border="0" cellpadding="1" id="bo0" cellspacing="1" align="center" bgcolor="#E6F6E9">
					<tr>					
								<td class="u1">
									产品标题：
								</td>
								<td class="u2" colspan="3">
									<div>
										<input name="title" id="title" type="text" size="30" maxlength="100" >
									</div>
								</td>
						</tr>	
							<tr>
								<td class="u1" >
									产品型号：
								</td>
						<td class="u2"  colspan="3"> 									
						<table width="100%" border="0" cellspacing="1" cellpadding="1" style="margin-top: 1px; margin-bottom: 0px;" bgcolor="#E6F6E9">
							<tr class="u4" height="25">
								<td width="20%" align="center" >选择型号</td>
								<td width="20%" align="left" >型号名称</td>
								<td width="40%" align="left" >型号描述</td>
							</tr>
							<%
								if(json!=null && json.size()>0){
								HashMap map=null;
									for(int i=0;i<json.size();i++){
									String class_name="";
									String class_id_up="";
									String class_desc="";
									String enable_tag="";
									String remark="";
									ArrayList list=null;
					           map=(HashMap)json.get(i);
					           if(map.get("class_name")!=null){
					          	 class_name=map.get("class_name").toString();
					           }
					           if(map.get("class_id")!=null){
					          	 class_id_up=map.get("class_id").toString();
					          	 list = proInfo.getproductByUpId(cust_id, class_id_up);
					           }
					           if(map.get("class_desc")!=null){
					          	 class_desc=map.get("class_desc").toString();
					          	 if(class_desc.equals("")){
					          	 		class_desc="无";
					          	 }
					           }
					           if(map.get("enable_tag")!=null){
					          	 enable_tag=map.get("enable_tag").toString();
					          	 if(enable_tag.equals("0")){
					          	 		enable_tag="有效";
					          	 }else{
					          	 		enable_tag="无效";
					          	 	}
					           }
					           if(map.get("remark")!=null){
					          	 remark=map.get("remark").toString();
					          	 
					           }
					           %>
					           <tr>
					      <td width="20%" align="center" style="background-color: #ffffff; color: #000000;  font-size: 12px;">
			         <input type="radio" name="up_class_id" value="<%=class_id_up%>" title="<%=class_name%>" onclick="document.getElementById('product_class').value='<%=class_id_up%>';setProductDiv('<%=class_id_up%>');"/>
								</td>
								<td width="20%" align="left" style="background-color: #ffffff; color: #000000;  font-size: 12px;">
									<%if(list!=null){%>
									<a href="/member/b2b_productMgr/productIndex.jsp?up_class_id=<%=class_id_up%>" title="查看下级型号"><%=class_name%></a>
									<%}else{%>
									<%=class_name%>
									<%}%>
									
								</td>
								<td width="40%" align="left" style="background-color: #ffffff; color: #000000;  font-size: 12px;">
									<%=class_desc%>
								</td>
								
							</tr>
								<%}
							}else{%>
								<tr>
								<td width="20%" align="center" style="background-color: #ffffff; color: #000000;  font-size: 12px;" colspan="4">暂无型号！</td>
							</tr>
							<%	}
							%>
							<tr>
								<td width="20%" align="center" style="background-color: #f6f6f6; color: #000000; font-weight: bold; font-size: 12px;" colspan="4"></td>
							</tr>
			            </table>
						</td>
							</tr>
							<tr>
								<td class="u1" >
								</td>
								<td colspan="3" align="left" bgcolor="white">
									<div class="ping1">
										<div id="loading" style="display: none">
											<img src="/images/wait.gif" border="0">
											正在获取数据，请稍等...
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td height="30" class="u1" valign="top">
									产品分类
								</td>
								<td class="u2" colspan="3">
									<div class="ping1">
										<table border="0" cellpadding="0" cellspacing="0" style="margin-left: 15px">
											<tr>
												<td>
													<select name="sort1" id="sort1" size="10" style="width: 130px" onChange="setSecondClass(this.value);" onclick="setTypeName(this)">
														<%=select%>
													</select>
												</td>
												<td>
													<select name="sort2" id="sort2" size="10" style="width: 130px; display: none" onChange="setTherdClass(this.value);" onclick="setTypeName(this)">
														<option value="0">
															请选择...
														</option>
													</select>
												</td>
												<td>
													<select name="sort3" id="sort3" size="10" style="width: 130px; display: none" onclick="setTypeName(this)" onchange="cretateSelect('4',this.value)">
														<option value="0">
															请选择...
														</option>
													</select>
												</td>
												<td>
													<div id="nextElement" style="display: none">
														<div id="4" style="width;100px; float:left;display:inline;white-space:nowrap"></div>
														<input type="hidden" name="index_s" id="index_s" value="4">
													</div>
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
							
							<tr>
								<td class="u1" >
									产品生产地：
								</td>
								<td class="u2" >
									<div class="ping1">
										<input type=text name="product_site" id="product_site">(如:山东-东营)
									</div>
								</td>
								<td class="u1" >
									产品有效期：
								</td>
								<td class="u2" >
									<div class="ping1">
										<input type=text name="validity" id="validity" onfocus="setday(this);" value="<%=end_date%>">
										(四位年-二位月-二位日)
									</div>
								</td>
							</tr>			
							
										<input type="hidden" name="product_type" value="1" />
										<input type="hidden" name="product_unit" value="1">
										
							<tr>
								<td class="u1">
									缩略图：
								</td>
								<td class="u2" colspan="3">
									<input name="mini_img" id="mini_img" type="hidden">
									<div style="padding-left: 0px;padding-bottom: 0px;padding-right: 0px;padding-top: 0px;">
										<iframe src="/inc/uploadImg.jsp?root_id=<%=product_id%>" width="100%" height="180px" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
									</div>
								</td>				
							</tr>			
							
							<input name="product_abstract" id="product_abstract" type="hidden" value=""/>

							<tr>
								<td class="u1" >
									产品描述：
								</td>
								<td class="u2"  colspan="3">
									<div class="ping1">
										<textarea name="product_desc" style=display:none></textarea>
										<iframe ID="product_desc" src="/www/ewebeditor/ewebeditor.htm?id=product_desc&style=coolblue&root_id=<%=product_id%>" frameborder=0 scrolling=no width=600 HEIGHT=350></iframe>
									</div>
								</td>
							</tr>
																			
										
		</table>	
		<td>
        <tr>
        	
		 <!--01-->
</table>			
<table width="100%" border=0 align="center" cellpadding=1 cellspacing=1 bgcolor="#E6F6E9">
							<tr>
								<td class="u3" colspan=4>
									<input class="tjan" name=submit1 type=submit value="" onclick="return Check_Value_My();">
									&nbsp;&nbsp;&nbsp;
									<img src="/admin/images/comeback.JPG" onClick="location.href='/admin/productMgr/index.jsp'" style="cursor:hand;" align="absmiddle">
									<input type=hidden name="remark" id="remark" size="50">
									<input type=hidden name="trade_type_code" value="1226" />
									<input type=hidden name="cust_id" id="cust_id" value="<%=cust_id%>">
									<input type=hidden name="info_id" id="info_id" value="<%=product_id%>">
									<input type=hidden name="product_id" id="product_id" value="<%=product_id%>" />
									<input type=hidden name="product_class" id="product_class" />
									<input type=hidden name="publish_user_id" id="publish_user_id" value="<%=user_id%>" />
									<input type=hidden name="publish_date" id="publish_date" />
									<input type=hidden name="audit_date" id="audit_date" value="" />
									<input type=hidden name="class_id" id="class_id" />
									<input name="root_id" id="root_id" type="hidden" value="<%=product_id%>">
									<input name="rsrv_str1" id="rsrv_str1" type="hidden" value="0">
									<input name="web_id" id="web_id" type="hidden" value="000000000000000">
								</td>
							</tr>
</table>				
</form>
</body>
</html>




