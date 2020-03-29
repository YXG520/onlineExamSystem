
var vm = new Vue({
	el:"#index",
	data(){
		return { 
		show: false,
		logining:false,
		Across: true,
		Acrossa: false,
		forMounted:"",
		username:"",
		password:"",
		returnInfo:null,
		subjectCode:"",
		code:"",
		photoSrc:"",
		subject:"",
		mail:"",
		rootUrl:document.getElementById("rootUrl").value,
		isCommitted:false
		}
	},
	methods:{
		changeImg(event){
			var randomNumber=Math.ceil(Math.random()*100);
			//this.$refs.codeImg.setAttribute("src","validcodeForLogin?num="+parseInt(randomNumber));
			this.$refs.codeImg.setAttribute("src",this.rootUrl+"/code/validcodeForLogin?num="+parseInt(randomNumber));
		},
		stopRefresh:function(){
			//表单是否已经提交标识，默认为false
			         
			              if(this.isCommitted==false){
			                 this.isCommitted = true;//提交表单后，将表单是否已经提交标识设置为true
			                return this.isCommitted;//返回true让表单正常提交
			             }else{
			                 return false;//返回false那么表单将不提交
			             }
			
		
		},
		btnClick:function (event){
			var input= document.getElementById("loginForm").getElementsByTagName("input");
			var select= document.getElementById("loginForm").getElementsByTagName("select");			
			for(var i=0;i<input.length;i++){
				 if(select[0].value!=''&&input[i].value!=''){
					// this.forMounted();
					 document.getElementById("loginForm").submit();
				 }else{
					 alert("信息不许为空");
					 break;
				 }
				}
			
		  }  ,
		  cannotSee:function(event){
			 
			event.target.setAttribute("src","validcodeForLogin?date="+12); 
			 alert("aaa")
			//return false;
		  },
		
		gologin(){
			this.logining = !this.logining;
		},
		changecross(){
			this.Across = !this.Across;
			this.Acrossa = !this.Acrossa;
		},
		nologin(){
			this.logining = false
		},
		goToDetail(idName){
			document.getElementById(idName).scrollIntoView({ block: 'start', behavior: 'smooth' });
		},
		
	}
})
