<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">&nbsp; 
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.saas.biz.saleMgr.*"%>
<%@ page import="com.saas.biz.newsMgr.*"%>
<%@ page import="com.saas.biz.AreaInfoMgr.*"%>
<%@ page import="com.saas.biz.custMgr.*"%>
<%@ page import="com.saas.biz.infoListMgr.*"%>
<%@ page import="com.saas.biz.channelMgr.*"%>
<jsp:useBean id="tools" class="com.saas.biz.commen.PageTools" scope="page" />
<%@ page import="java.util.*"%>
<%
	String key="",pro="",city="",part="",precision="",type="";
	if(request.getParameter("param1")!=null){
		key = request.getParameter("param1");
	}
	if(request.getParameter("param2")!=null){
		pro = request.getParameter("param2");
	}
	if(request.getParameter("param3")!=null){
		city = request.getParameter("param3");
	}
	if(request.getParameter("param4")!=null){
		part = request.getParameter("param4");
	}
	if(request.getParameter("param5")!=null){
		precision = request.getParameter("param5");
	}
	if(request.getParameter("param6")!=null){
		type = request.getParameter("param6");
	}
	String iStart = "1";
	if(request.getParameter("iStart")!=null){
		iStart = request.getParameter("iStart");
	}
	
	AreaInfo area = new AreaInfo();
	String pro_name = "";
	if(pro != null)
		pro_name = area.getAreaName(pro);
	else
		pro_name = "";
	String city_name = "";
	if(city != null)
		city_name = area.getAreaName(city);
	else
		city_name = "";
	//out.print("key="+key+"pro="+pro+"city="+city+"part="+part+"precision="+precision);
	SupplyInfo info = new SupplyInfo();
	ArrayList list = new ArrayList();
	int counter = 0;
	String pageTools = "";
	if(precision.equals("0")){
		list = info.getSearchSaleInfo(Integer.valueOf(iStart).intValue(),30,key,pro_name,city_name,Integer.parseInt(part),type);
		counter = info.getSearchSaleInfo(key,pro,city,Integer.parseInt(part),type);
		pageTools = tools.getGoogleToolsBar(counter,"supply.jsp?param1=" + key + "&param2=" + pro + "&param3=" + city + "&param4=" + part + "&param6=" + type + "&iStart=", Integer.parseInt(iStart) , 30);
	}else if(precision.equals("1")){
		list = info.getSearchSaleList(Integer.valueOf(iStart).intValue(),30,key,pro_name,city_name,Integer.parseInt(part),type);
		counter = info.getSearchSaleList(key,pro,city,Integer.parseInt(part),type);
		pageTools = tools.getGoogleToolsBar(counter,"supply.jsp?param1=" + key + "&param2=" + pro + "&param3=" + city + "&param4=" + part + "&param6=" + type + "&iStart=", Integer.parseInt(iStart) , 30);
	}
%>
<link rel="stylesheet" type="text/css" href="/templates/wood/style/supply.css" />
<div id="main">	
		<table width="98%" border="0" align="center" cellpadding="8" cellspacing="0">
        <tr>
          <td width="16%" class="list_right_cp_lmt">��ƷͼƬ</td>
          <td width="46%" class="list_right_cp_lmt">��˾/��Ӫ��Ʒ������</td>
          <td width="12%" class="list_right_cp_lmt">��Ӧ����</td>
          <td class="list_right_cp_lmt">��������</td>
          <td width="14%" class="list_right_cp_lmt">��ϵ��ʽ</td>
        </tr>
        <%	
        	if(list != null && list.size() > 0){ 
        		for(int i = 0;i < list.size();i++){
        		String sale_unit ="",sale_id ="",title ="",sale_addr ="",publish_date ="";
        		HashMap map = (HashMap)list.get(i);
        		if(map.get("sale_unit")!=null){sale_unit = map.get("sale_unit").toString();}
        		if(map.get("sale_id")!=null){sale_id = map.get("sale_id").toString();}
        		if(map.get("title")!=null){title = map.get("title").toString();}
        		if(map.get("sale_addr")!=null){sale_addr = map.get("sale_addr").toString();}
        		if(map.get("publish_date")!=null){
        			publish_date = map.get("publish_date").toString();
        			if(publish_date.length()>10)
        				publish_date = publish_date.substring(0,10);
        		}
        		String filePath = "";
        		filePath = new NewsInfo().getCustAttachPath( sale_id, "0");
        		String phone = "";
        		phone = new Custinfo().getPhoneById(sale_unit);
        		
        		InfoList infoList = new InfoList();
        		ChannelInfo chanInfo = new ChannelInfo();
        		String chId = "",save_dir = "";
        		chId = infoList.getChannelCh_idByInfo(sale_id);
        		if(!chId.equals("")) {
        			save_dir = chanInfo.getSaveDir(chId);
        		}
        		String link_url = "/"+ save_dir + "/d/content-"+sale_id+".html";
        		
        %>
        <tr>
          <td class="list_right_cp_xian"><a href="<%=link_url%>"><img src="<%=filePath%>" border=0 width=100 height=75></a></td>
          <td class="list_right_cp_xian">
				  <span class="span"><a href="<%=link_url%>"><%=title%></a></span></br>
				  <font></font></br>
				  <div class="button" style="float:left; margin-right:5px;"><a href="<%=link_url%>">��Ʒ��Ϣ</a></div> <div class="button" style="float:left;"><a href="/inc/include/InterimPages.jsp?cust_id=<%=sale_unit%>" target="_blank">��ϵ��ʽ</a></div>
				  </td>
          <td class="list_right_cp_xian"><%=sale_addr%></td>
          <td class="list_right_cp_xian"><%=publish_date%></td>
          <td class="list_right_cp_xian"><%=phone%></td>
        </tr>
        <%
        		}
        	} 
        %>
		</table>
  <div class="cplist_page"><%=pageTools%></div>
</div>



