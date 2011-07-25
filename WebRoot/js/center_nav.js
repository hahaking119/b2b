 
 
 
		function mousePosition(ev)  
		 {  
		 if(ev.pageX || ev.pageY)  
		 {  
		 return {x:ev.pageX, y:ev.pageY};  
		 }  
		 return {  
		 x:ev.clientX + document.body.scrollLeft - document.body.clientLeft,y:ev.clientY + document.body.scrollTop - document.body.clientTop  
		 };  
		 }  
		//弹出方法  
		function showMessageBox(wTitle,content,pos,wWidth)  
		{  
		 closeWindow();  
		 var bWidth=parseInt(document.documentElement.scrollWidth);  
		 var bHeight=parseInt(document.documentElement.scrollHeight);   
		 var mesW=document.createElement("div");  
		 mesW.id="mesWindow";  
		 mesW.className="mesWindow";  
		 mesW.innerHTML="<div class='mesWindowTop'><table width='100%' height='100%' bgcolor='#E3F3F8' cellpadding='0' cellspacing='0'><tr><td><b>"+wTitle+"</b></td><td style='width:1px;'><img src=/img/error.png onclick=closeWindow() style=cursor:hand;/></td></tr></table></div><div style=background-color:white; id='mesWindowContent'>"+content+"</div><div class='mesWindowBottom'></div>";  
		  
		 var styleStr="left:"+(((pos.x-wWidth)>0)?(pos.x-wWidth):pos.x)+"px;top:"+(pos.y)+"px;position:absolute;width:"+wWidth+"px;";  
		 mesW.style.cssText=styleStr;  
		 document.body.appendChild(mesW);  
		}  

		 
 
		//关闭窗口  
		function closeWindow()  
		{   
		 if(document.getElementById('mesWindow')!=null)  
		 {  
		 document.getElementById('mesWindow').parentNode.removeChild(document.getElementById('mesWindow'));  
		 }   
		}  

		function testMessageBox(ev,messContent,title,winWidth)  
		{  
		 var objPos = mousePosition(ev);   
		 showMessageBox(title,messContent,objPos,winWidth); 
		} 