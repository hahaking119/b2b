<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.buildhtml.*"%>
<%@ page import="com.saas.biz.commen.config"%>
<%@ page import="com.saas.intf.InfoIntf"%>
<%@ page import="com.saas.intf.ChannelIntf"%>
<%
	
	config configFile = new config();
	configFile.init();
	String rootpath = configFile.getString( "ecms_path" );
	String savepath = configFile.getString( "templates_save_path" );
	String index_temp = "",default_page = "";
	String cust_id ="",save_dir="";
	if( session.getAttribute("SESSION_CUST_ID") != null )
	{
		cust_id = session.getAttribute("SESSION_CUST_ID").toString();
		save_dir = savepath + cust_id;
	}
	
	if (request.getParameter("index_temp") != null)
	{
		index_temp = request.getParameter("index_temp");
	}
	if (request.getParameter("default_page") != null)
	{
		default_page = request.getParameter("default_page");
	}
	String code = "";
	if (request.getParameter("code") != null)
	{
		code = request.getParameter("code");
	}
	String showEnd = "none";
	if(code.equals("1"))
	{
		showEnd = "block";
	}	
	  
	
%>
<html>
	<head>
		<title>������ҳ</title>
		<link href="/style/layout1.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="/js/prototype.js"></script>
		<script type="text/javascript">
		  function check_Value()
		  {
				if($F("index_temp") =="" || $F("index_temp")==null)
				{
				  alert("��ѡ����ҳģ�壡");
				  $("index_temp").focus();
				  return false;
				}
		    	document.getElementById("proDiv").style.display = "block";
		    	document.getElementById("proDiv1").style.display = "none";
		    	document.getElementById("proDiv").style.display = "block";
				document.getElementById("proDiv").innerHTML = "<img src=/images/wait.gif border=0><font size=3>����������Ŀ............</font>";
		    	document.createForm.submit();
		    	return true;
		   }
		</script>
	</head>
	<body>
		<form name="createForm" id="createForm" action="createIndex.jsp" method="post" target="_self">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
			<tr>
				<td>
					<table width=100% border=0 cellpadding=1 cellspacing=1 align=center bgcolor="#98D9A2">
					<tr>
					<td class="u1" width="15%">
						ѡ����ҳģ�壺
					</td>
					<td class="u2" width="85%">
						<div class="ping1">
							<input type="text" id="index_temp" name="index_temp" value="" size="40" maxlength="100" />
							<input type="button" onClick="open('/member/channelMgr/filelist.jsp?id=index_temp','file','height=400,width=400,toolbar=0,status=0,scroll=yes')" value="���"/>	
						</div>
					</td>
					</tr>
					<tr   style="display:none">
						<td class="u1" width="15%">
							��ҳλ�ã�
						</td>
						<td class="u2" width="85%">
							<div class="ping1">
								<input type="text" name="save_dir" id="save_dir" maxlength="100" value="" />
							</div>
						</td>
					</tr>
					<tr style="display:none">
						<td class="u1" width="15%">
							Ĭ��ҳ��
						</td>
						<td class="u2" width="85%">
							<div class="ping1">
								<input name="default_page" type="text" id="default_page" value="index.html" size="30" maxlength="100">
							</div>
						</td>
					</tr>
					<tr>
						<td class="u3" colspan="2">
							<input name="code" type="hidden" value="1" id="code">
							<input name="submit" type="submit" value="������ҳhtml" onclick="return check_Value()">
						</td>
					</tr>
				</table>
				<table width=100% border=0 cellpadding=1 cellspacing=1 align=center bgcolor="#98D9A2">
					<tr>
						<td>
							<div id="proDiv" style="display: none;"><img src="/images/wait.gif" border="0"><font size="3">����������ҳ............</font></div>
							<div id="proDiv1" style="display: <%=showEnd%>;">
								<font size="3">������ҳ����............
								<a href="/<%=save_dir + "/" + default_page%>" target="_blank" style="cursor: hand;"><font size="3">Ԥ��...</font></a></br>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<%    
									if( !index_temp.equals("") )
									{
										CustCreateIndex cindex = new CustCreateIndex();
										cindex.CreateIndex( cust_id, index_temp, save_dir, default_page );
									
								}
							%>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</form>
	</body>
</html>

