<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.saas.biz.commen.ParamethodMgr"%>
<%@ page import="com.saas.biz.custMgr.Custinfo"%>
<jsp:useBean id="bean" class="com.saas.biz.commen.commMethodMgr" scope="page" />
<jsp:useBean id="proInfo" class="com.saas.biz.productclassMgr.Productclass" scope="page" />
<jsp:useBean id="classBean" class="com.saas.biz.productclassMgr.Productclass" scope="page" />
<%@ page import="java.util.*"%>
<%@ page import="com.saas.biz.channelMgr.ChannelInfo"%>
<%
	String news_id = bean.GenTradeId();	
	String sale_id = bean.GenTradeId();
	String info_id=sale_id;
	ChannelInfo channel = new ChannelInfo();
	ParamethodMgr paramCom = new ParamethodMgr();
	String price_type = paramCom.getSelectItems("3");
	String start_date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	Calendar cal = Calendar.getInstance();
	cal.add(Calendar.MONTH, 3);
	String end_date = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
	String class_id = "";
	if (request.getParameter("class_id") != null) 
	{
		class_id = request.getParameter("class_id").toString();
	}
//	String class_name = channel.getChName(class_id);//proInfo.getClassNameById(class_id);
	String select = classBean.getSelectedByComm("5", "1");
	String ch_id = "0501882650";
	
	
	String cust_id = "",cust_type="";
	if( session.getAttribute( "SESSION_CUST_ID" ) != null )
	{
		cust_id = session.getAttribute("SESSION_CUST_ID").toString();
	}
	Custinfo custInfo=new Custinfo();
	ArrayList listc=new ArrayList();
	listc =	custInfo.getCustomerByCustId(cust_id);
	if( null != listc && listc.size() > 0 )
	{
		HashMap map=(HashMap)listc.get(0);
		if( null != map.get("cust_type") )
	 		cust_type=map.get("cust_type").toString();
	}
	
	
	
	
%>
<html>
	<head>
		<title>发布信息</title>
		<link href="/style/layout1.css" rel="stylesheet" type="text/css">
		<style type="text/css">
			.c4 {
				CURSOR: hand;background:url(/admin/images/di_03.jpg);COLOR:#0066CC;font-size: 14px; font-weight:bold; line-height:28px; padding-left:26px;
			}
			.c3 {CURSOR: hand; background:url(/admin/images/di_04.jpg); COLOR: #0066CC;font-size: 14px; line-height:28px; padding-left:26px;}
			
		</style>
		<script type="text/javascript" src="/js/public_b2b.js"></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/Productclass.js'></script>
		<script type="text/javascript" src="/js/prototype.js"></script>
		<script language="javascript" src="supply.js"></script>
		<script language="JavaScript">
		function clickSel(val,valId)
		{
			if(val=='0')
			{
				document.getElementById(valId).value = '1';
			}
			else
			{
				document.getElementById(valId).value = '0';
			}
		}
		
    	function Check_Value_My()
		{
			if(document.getElementById('title').value=='' )
			{
				alert('请填写信息的标题！');
				document.getElementById('title').focus();
				return false;
			}
			
			if(document.getElementById('class_id').value=='' )
			{
				alert('请选择供应分类！');
				return false;
			}
			if(document.getElementById('sale_price').value=='' )
			{
				alert('请输入供应产品单价！');
				document.getElementById('sale_price').focus();
				return false;
			}
			
			document.getElementById('ch_id').value='0501882650';


		 	var str=content.getText();
			str=str.replace(/\s*/g,''); 
			if(str == ''  )
			{
				alert('请填写商品描述内容！');
				return false;
			}
			if( str.length > 4000)
			{
				 alert( '字数应少于4000字!' );
				 return false;	
			}
		   document.getElementById('contents').value = document.getElementById('one').value + document.getElementById('two').value;  //+ document.getElementById('three').value;
	       return true;
		}
		function ShowColor(){
			var fcolor=showModalDialog("/admin/cms/color.htm?ok",false,"dialogWidth:106px;dialogHeight:110px;status:0;dialogTop:"+(window.event.clientY+120)+";dialogLeft:"+(window.event.clientX));
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
	function formSub(){
		var sale_price = document.getElementById("sale_price_h").value;
		var sale_price_d = document.getElementById("sale_price_1").value;
		var commodity_price = document.getElementById("commodity_price_h").value;
		var commodity_price_d = document.getElementById("commodity_price_1").value;
		
		document.getElementById("sale_price").value = sale_price+"/"+ sale_price_d;
		document.getElementById("commodity_price").value = commodity_price +"/"+ commodity_price_d;
		
			if(Check_Value_My()){
				alert('提交后等待运营商重新生成页面！');
				return true;
			}else{
				return false;
			}
	}
	</script>
	</head>
	<body>
		<form name="newform" action="/doTradeReg.do" method="post" target="_self">
			
			<table width=100% border="0" cellspacing="1" cellpadding="1" align="center">
				<tr class="u1">
					<td align="left"  class="head">
						<a href="twohandList.jsp">二手信息管理</a>
					</td>
				</tr>
				<tr>
					<td>
						
						<%
							if(cust_type.equals("1")){
						%>
						<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
						
							<tr class="u4">
								<td width="76" height="28" align="left" class=c4 id="d0" onclick="javascript:secBoard(0)">
									二手信息
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
						
						
						<jsp:include  flush="true" page="/member/custcms/infolist.jsp">
							<jsp:param name="cont_mod" value="1" /> 
							<jsp:param name="news_id" value="<%=sale_id%>"/>
							<jsp:param name="class_id" value="<%=class_id%>"/>
							<jsp:param name="ch_id" value="<%=ch_id%>"/>
						</jsp:include>
						<!--02-->
						<table width="100%" border=0 align="center" cellpadding=1 cellspacing=1 bgcolor="#E6F6E9" id="bo0" >
							<tr>					
								<td class="u1"  width="10%">
									二手信息标题：
								</td>
								<td class="u2" colspan="3" width="90%">
									<div>
										<input name="title" id="title" type="text" size="30" maxlength="100" >
									</div>
								</td>
							</tr>
							<tr>
								<td height="30" class="u1" valign="middle">
									请选择分类：
								</td>
								<td class="u2" colspan="3">
									<select name="sort1" size="10" style="width: 130px; float:left;" onChange="setSecondClass(this.value);" onclick="setTypeName(this)">
										<%=select%></select>
										
									<select name="sort2" size="10" style="width: 130px; float:left; display: none" onChange="setTherdClass(this.value);" onclick="setTypeName(this)">
									<option value="0">请选择...</option>
									</select>
									<select name="sort3" size="10" style="width: 130px; float:left; display: none" onclick="setTypeName(this)" onchange="cretateSelect('4',this.value)">
									<option value="0">请选择...</option>
									</select>
									<div id="nextElement" style="display: none"><div id="4" style="width;100px; float:left;display:inline;white-space:nowrap"></div>
										<input type="hidden" name="index_s" id="index_s" value="4">
									</div>
												</td>
											</tr>
							
							<tr>
								<td class="u1">
									开始时间：
								</td>
								<td class="u2">
									<div>
										<input name="start_date" type="text" id="start_date" value="<%=start_date%>" onfocus="setday(this);" size="10" />
										(四位年-二位月-二位日)
									</div>
								</td>
								<td class="u1">
									结束时间：
								</td>
								<td class="u2">
									<div>
										<input name="end_date" type="text" id="end_date" value="<%=end_date%>" onfocus="setday(this);" size="10" />
										(四位年-二位月-二位日)
									</div>
								</td>
							</tr>
							<tr>
								<td class="u1">
									单价：
								</td>
								<td class="u2"">
									<div>
										<input name="sale_price_h" id="sale_price_h" type="text" size="6" maxlength="10" onkeyup="if(isNaN(value))execCommand('undo')">
										(只能输入数字)
									</div>
								</td>
								<td class="u1">
									单位：
								</td>
								<td class="u2"">
									<div>
										<input name="sale_price_1" id="sale_price_1" type="text" size="6" maxlength="10">
									</div>
								</td>
							</tr>
							<tr>
								<td class="u1">批发价：</td>
								<td class="u2">
									<div>
										<input name="commodity_price_h" id="commodity_price_h" type="text" size="6" maxlength="10" onkeyup="if(isNaN(value))execCommand('undo')">
										(只能输入数字)
									</div>
								</td>
								<td class="u1">单位：</td>
								<td class="u2">
									<div>
										<input name="commodity_price_1" id="commodity_price_1" type="text" size="6" maxlength="10">
									</div>
								</td>
								
				<tr>
					<input name="price_type" type="hidden" value="1">
					<td class="u1">
						销售地址：
					</td>
					<td class="u2" colspan="3">
						<div>
							<input name="sale_addr" id="sale_addr" type="text" size="25">
							(如:山东-东营)
						</div>
					</td>
				</tr>		
				<tr>
					<td class="u1">
						上传图片：
					</td>
					<td align=left style="background-color:#ffffff; color:#000000;  font-size:12px;" colspan="3">
						<div class="ping1">
							<iframe src="/inc/uploadImg.jsp?root_id=<%=sale_id%>" width="100%" height="180px" marginwidth="0"  frameborder=0 marginheight="0" scrolling="no"></iframe>
						</div>
					</td>
				</tr>	
				<tr>
					<td class="u1">
						商品描述：
					</td>
					<td class="u2" colspan="3">
						<div>
							<textarea name="content" style=display:none></textarea>
							<iframe ID="content" src="/www/ewebeditor/ewebeditor.htm?id=content&style=coolblue&root_id=<%=sale_id%>" frameborder=0 scrolling=no width=600 HEIGHT=350></iframe>
						</div>
					</td>
				</tr>
			</table>
			<table width="100%" border=0 align="center" cellpadding=1 cellspacing=1 bgcolor="#E6F6E9">
				<tr>
					<td colspan=4 class="u3">
						<input name="sale_price" id="sale_price" type="hidden" size="6" maxlength="10">
						<input name="commodity_price" id="commodity_price" type="hidden" size="6" maxlength="10" >
						<input type="hidden" name="web_id" value="000000000000000">
						<input type="hidden" name="sale_id" value="<%=sale_id%>">
						<input type="hidden" name="sale_num" value="">
						<input type="hidden" name="carriage_pay" value="">
						<input type="hidden" name="class_id" id="class_id" value="">
						<input type="hidden" name="trade_type_code" value="0213">
						<input type="hidden" name="rsrv_str1" id="rsrv_str1" value="0">
						<input type="hidden" name="sale_type" id="sale_type" value="1"> <!--1:二手 0：供应-->
						<input type="hidden" name="info_type" id="info_type" value="3">	
						<input type="hidden" name="info_id" id="info_id" value=<%=sale_id%>>		
						<input class="tjan" name="bnt" type="submit" value="" onclick="return formSub()">
					</td>
				</tr>
			</table>
			</td>
			</tr>
			</table>
		</form>
	</body>
</html>


