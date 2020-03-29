
	
//使用ajax加载数据字典,生成select
//参数1: 数据字典类型 (dict_type_code)
//参数2: 将下拉选项放入的标签id
//参数3: 生成下拉选项时,select标签的name属性值
//参数4: 需要回显时,选中哪个option
function loadSelect(typecode, positionId, selectname) {

	var path = '/website/basedict/findBycode';
	// 1 创建select对象,将name属性指定
	var $select = $('<select name=' + selectname
			+ ' class="layui-input" ></select>');
	// 2 添加提示选项
	$select.append($("<option value=''>请选择</option>"));
	// 3 使用jquery 的ajax 方法,访问后台Action
	$.post(path, {
		dict_type_code : typecode
	}, function(data) {
		// 遍历
		// 4 返回json数组对象,对其遍历
		$.each(data, function(i, json) {
			// 每次遍历创建一个option对象
			var $option = $("<option value='" + json['bid'] + "' >"
					+ json["dict_item_name"] + "</option>");
			// 添加到select对象
			$select.append($option);
		});
		// 5 将组装好的select对象放入页面指定位置，重新渲染
		$("#" + positionId).append($select);
		var form = layui.form;
		form.render();
	}, "json");
}
