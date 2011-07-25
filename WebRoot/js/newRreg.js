/**
 * 数据检测
 */
var type = "3";
// 检测是否为合法数据
function isNum(str) {
	return (str.search(/^\d+(\.\d+)?$/) != -1);
}
// 设置二级分类
function setSecondClass(val) {
	var up_class_id = val;
	$("rsrv_str1").value = "1";
	Productclass.getProductClassByUpId(up_class_id, type, setSort2);
}
function setSort2(map_data) {
	DWRUtil.removeAllOptions("sort2");
	DWRUtil.addOptions("sort2", map_data);
	$("sort3").style.display = "none";
	$("nextElement").style.display = "none";
	var item = $("sort2").length;
	if (item == 0) {
		$("sort2").style.display = "none";
	} else {
		$("sort2").style.display = "block";
	}
}
// 设置三级分类
function setTherdClass(val) {
	var up_class_id = val;
	$("rsrv_str1").value = "2";
	Productclass.getProductClassByUpId(up_class_id, type, setSort3);
}
function setSort3(map_data) {
	if (map_data != null) {
		DWRUtil.removeAllOptions("sort3");
		DWRUtil.addOptions("sort3", map_data);
		var item = $("sort3").length;
		if (item == 0) {
			$("sort3").style.display = "none";
			$("nextElement").style.display = "none";
		} else {
			$("sort3").style.display = "block";
		}
	}
}
function setTypeName(obj) {
	 var idx=obj.value;
	 $("class_id").value=idx;
	// $("class_name").value=DWRUtil.getText(obj.name);
	// $("count").value=obj.name;
}
// 动态生成下级分类信息
function cretateSelect(index, value) {
	$("nextElement").style.display = "block";
	$("rsrv_str1").value = "3";
	var divId = parseInt(index) + parseInt(1);
	$("index_s").value = index;
	$(index).innerHTML = "<select name=sort" + index + " id=sort" + index
			+ " onchange=cretateSelect(" + divId
			+ ",this.value) size=3  style=width:130px></select><div id="
			+ divId + "></div>";
	DWRUtil.removeAllOptions("sort" + index);
	Productclass.getProductClassByUpId(value, type, setNewSelect);
}
// 回调函数
function setNewSelect(map_data) {
	var id = $("index_s").value;
	DWRUtil.addOptions("sort" + id, map_data);
	var item = $("sort" + id).length;
	if (item == 0) {
		$(id).style.display = "none";
	} else {
		$(id).style.display = "block";
	}
}

var fectureArray = new Array();
fectureArray = ['请选择..'];
function setAreas(city_id) {
	AreaInfo.getAreaByParent(city_id, function(data) {
		DWRUtil.removeAllOptions("city");
		DWRUtil.addOptions("city", fectureArray);
		DWRUtil.addOptions("city", data);
	});
}
function setCitys(prov) {
	var provence = prov;
	AreaInfo.getAreaByParent(provence, function(data) {
		DWRUtil.removeAllOptions("eparchy_code");
		DWRUtil.addOptions("eparchy_code", fectureArray);
		DWRUtil.addOptions("eparchy_code", data);
		DWRUtil.removeAllOptions("city");
		DWRUtil.addOptions("city", fectureArray);
	});
}
