<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.saas.biz.commen.commMethodMgr"%>
<html>
<head>
<title>B2B电子商务后台管理系统</title> 
    <link href="/style/layout.css" rel="stylesheet" type="text/css">
   </head>
<body>	
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <jsp:include page="/inc/top.jsp"/>
	    <tr><!-- 中间 -->
            <td align="center" >        
	         <div id="manager_body"> <!--左边菜单-->
                
                <div id="manager_body_right">
                     <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td>
                                 <%@ include file="cust_List.jsp"%>
                          </td>
                        </tr>
                     </table>
                </div>  <!--右边 主体部分结束  -->
            </div>
            </td>  <!-- 中间 结束 -->  
        </tr>
      </table>
</body>
</html>



