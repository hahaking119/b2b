<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.saas.biz.channelColumnMgr.ChannelColumnInfo"%>
<%@ page import="com.saas.biz.productclassMgr.Productclass"%>
<jsp:useBean id="bean" class="com.saas.biz.newsMgr.NewsInfo" scope="page" />
<%
	String news_id = "", title = "", content = "", news_type = "", class_type = "";
	ChannelColumnInfo channel = new ChannelColumnInfo();
	if (request.getParameter("news_id") != null) 
	{
		news_id = request.getParameter("news_id");
		ArrayList newsList = bean.genOneNews(news_id);
		if (newsList != null && newsList.size() > 0) 
		{
			HashMap map = (HashMap) newsList.get(0);
			if (map.get("title") != null) {
				title = map.get("title").toString();
			}
			if (map.get("content") != null) {
				content = map.get("content").toString();
			}	
			if (map.get("class_type") != null) 
			{
				news_type = map.get("class_type").toString();
		//ArrayList list = new Productclass().genUpclassByClassId(news_type);
		//if (list != null && list.size() > 0) {
			//HashMap claMap = (HashMap) list.get(0);
			//if (claMap.get("class_name") != null) {
				//class_type = claMap.get("class_name").toString();
			//}
		//}
		
			}
		}
	}
	String type = "";
	if (request.getParameter("class_type") != null) {
		type = request.getParameter("class_type");
	}
	class_type = channel.getChName(type);
	
	
	String idx = news_id;

%>
<html>
	<head>
		<title>电子商务</title>
		<link href="/style/layout.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="/js/public_b2b.js"></script>
		<script language="JavaScript">
   		function clickSel(val,valId){
			if(val=='0'){
				document.getElementById(valId).value = '1';
			}else{
				document.getElementById(valId).value = '0';
			}
		}
 	 	function Check_Value(){
		  if(document.getElementById("class_type").value=="" || document.getElementById("class_type").value==null){
				alert("请选择信息分类！");
				document.getElementById("class_type").focus();
				return false;
		  }
		  if(document.getElementById("title").value.replace(/\s*/g,"")=="" || document.getElementById("title").value.replace(/\s*/g,"") ==null){
				alert("请填写新闻的标题！");
				document.getElementById("title").focus();
				return false;
			}
			var str=content.getText();
			str=str.replace(/\s*/g,""); 
			if(str == ""  ){
				alert("请填写新闻的内容！");
				return false;
			}
			if( str.length > 4000){
				 alert( "证书说明字数应少于4000字" );
				 return false;	
			}
		document.getElementById('contents').value = document.getElementById('one').value + document.getElementById('two').value + document.getElementById('three').value;
	    return true;
	}
	function ShowColor(){
			var fcolor=showModalDialog("color.htm?ok",false,"dialogWidth:106px;dialogHeight:110px;status:0;dialogTop:"+(window.event.clientY+120)+";dialogLeft:"+(window.event.clientX));
			if(fcolor!=null && fcolor!="undefined") document.newform.title_color.value = fcolor;
		}
</script>
	</head>
	<body>

		<form name="newform" action=/doTradeReg.do method="post">
			<table width="800" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td height="30">
					</td>
				</tr>
				<tr>
					<td background="/admin/images/content_03.gif" height="43" width="156" align="center">
						<font size="2"><b>修改信息</b> </font>
					</td>
					<td background="/admin/images/content_04.gif" align="right">&nbsp;
						
					</td>
					<td width="8">
						<img src="/admin/images/content_06.gif">
					</td>
				</tr>
			</table>
			<table width=800 border="0" cellspacing="1" cellpadding="1" align="center">
				<tr>
					<td>
						<table width="796" border="0" align="center" cellpadding="0" cellspacing="0">
							<tr class="u4">
								<td width="76" height="28" align="left" class=c4 id="d0" onclick="javascript:secBoard(0)">
									常规参数
								</td>
								<td width="76" height="28" align="left" class=c3 id="d1" onclick="javascript:secBoard(1)">
									文章内容
								</td>
								<td>&nbsp;
									
								</td>
							</tr>
						</table>
						<!--01-->
						<jsp:include flush="true" page="/admin/cms/modiInfolist.jsp">
							<jsp:param name="news_id" value="<%=news_id%>" />
							<jsp:param name="class_id" value="<%=news_type%>" />
						</jsp:include>
						<!--02-->
						<table width="796" border=0 align="center" cellpadding=1 cellspacing=1 bgcolor="#DEEDFD" id="bo1" style="display: none">
							<tr>
								<td class="u1">
									频道列表：
								</td>
								<td width="85%" align=left style="background-color:#ffffff; color:#000000;  font-size:12px;">
									<iframe marginWidth="0" marginHeight="0" src="displayClassName.jsp?class_type=<%=type%>" frameborder=0 scrolling=no width=600 height="510"></iframe>
									<input name="news_id" type="hidden" value=<%=news_id%>>
									<input name="subject_tag" type="hidden" value=0>
									<input name="news_type" type="hidden" value="<%=news_type%>" id="news_type">
								</td>
							</tr>
							<tr>
								<td class="u1">
									频道名称：
								</td>
								<td style="background-color:#ffffff; color:#000000;  font-size:12px;" align=left>
									<div>
										<input name="class_type" type="text" id="class_type" size=20 maxlength=70 value="<%=class_type%>">
									</div>
								</td>
							</tr>
							<tr>
								<td class="u1">
									信息内容：
								</td>
								<td style="background-color:#ffffff; color:#000000;  font-size:12px;" align=left>
									<div>
										<textarea name="content" style=display:none>
											<%=content%>
										</textarea>
										<iframe ID=content src="/www/ewebeditor/ewebeditor.htm?id=content&style=coolblue&root_id=<%=news_id%>" frameborder=0 scrolling=no width=680 HEIGHT=350></iframe>
									</div>
									输入范围(汉字应少于4000字)
								</td>
							</tr>
						</table>
						<!--选项结束-->
						<script language=javascript>
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

						<table width="796" border=0 align="center" cellpadding=1 cellspacing=1 bgcolor="#DEEDFD">
							<tr>
								<td colspan=4 class="u3">
									<input name="info_id" type="hidden" id="info_id" value="<%=news_id%>">
									<input name="news_id" type="hidden" value="<%=news_id%>">
									<input type="hidden" name="in_date" id="in_date" value="" />
									<input type="hidden" name="idx" value="<%=idx%>">
									<input name="remark" type="hidden" id="remark" value="">
									<input name="trade_type_code" type="hidden" value=0289>
									<input class="xgan" name="bnt" type="submit" value="" onclick="return Check_Value()">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>



