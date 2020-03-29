//引用commonUtils.js文件
var contextPath=document.getElementById("rootUrl").value;
document.write("<script language=javascript src='"+contextPath+"/js/commonUtils.js'></script>");


//发送请求	

	var vm=	new Vue({
	 	  el: '#login-form',
	 	  data () { 
	 	    return { 
	 	      sendCheckCode:"",
	 	      info: null,
	 	      forMounted:"",
	 	      rootUrl:document.getElementById("rootUrl").value,
	 	    }
	 	  },
	 	  mounted () {
	 		  this.forMounted=function(){
	 			  axios.get(this.rootUrl+'/checkCodeForMail', {
	 				    params: {
	 				    	mail:this.sendCheckCode
	 				    }
	 				  })
	 				  .then(function (response) { 
	 			 		      this.info=response.data;
	 			 		      alert(info);
	 			 		      console.log(info); 
	 			 		    })
	 			 		    .catch(function (error) { 
	 			 		      console.log(error);
	 			 		    });
	 		  }	 		 
	 	  },
	 	  methods:{
	 		 checkBtnClick:function (event){ 
	 			 doCodes("username","getCode",120);
	 			 this.forMounted();
	 		  }  ,
	 		 matchStr:function(event) {
	 			var inputs=document.getElementsByTagName("input");
	 			if(inputs[0].value===""||inputs[1].value===""){
	 				alert("输入框不能为空");
	 			}else{
	 				document.getElementById('login-form').submit();
	 			}
	 		 },
	 		 checkemails:function(){
	 			 checkemail("username");
	 		 }
	 	  }
	 	}) 
		
