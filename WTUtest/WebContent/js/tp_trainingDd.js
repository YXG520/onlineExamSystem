
var vm = new Vue({
	el: '#practicing',
	 data () { 
	    return { 
		// 初始字体大小
		fs: 20,
		info:[],
		dxInfo:"",
		SubjectCode:document.getElementById("SubjectCode").value,
		rootUrl:document.getElementById("rootUrl").value,
		pdResult:"",// pd代表判断表，dd代表多选表，dx代表单选表
		topic:"",
		index:0,
		whetherRight:"",
		optionList:"",
		falseNumber:0,
		trueNumber:0,
		whetherDisabled:false,
		ifShow:false
		
			}
	}, mounted () {	
		axios.get(this.rootUrl+'/selAllDdBySubjectCode?SubjectCode='+this.SubjectCode).then(allDd=> {		
			this.info=allDd.data;
			if(this.info==null||this.info==''){
					alert("题库中暂时无此类题目")
			}else{
				this.optionList=JSON.parse(this.info[0].optionList);	
			}
			
		  }).catch(function (error) {
			    console.log(error);
		  });		 
		  },
	methods:{ 
		btnClick: function(event){
			this.ifShow=false;
			if(event.target.value=="下一题"){
			   this.index+=1;
			   if(this.index>=this.info.length)	this.index=this.info.length-1;
			    document.getElementsByClassName("daTiArea")[this.index].style.background="blue";	
				this.whetherDisabled=false;				
				var  obj = document.getElementsByClassName("ddRadio");
				for(var i = 0; i < obj.length; i++) { 
					obj[i].checked=false;	  
				  }
			}else if(event.target.value=="上一题"){
				 this.whetherDisabled=true;
				 if(this.index>0)
				 document.getElementsByClassName("daTiArea")[this.index].style.background="white";
				this.index-=1;
				if(this.index<=-1) this.index=0;	
			}
			this.optionList=JSON.parse(this.info[this.index].optionList);
		  }  ,
		  verifyAnswer: function (){	
			  this.ifShow=true;
			  this.whetherDisabled=true;
			 // 获取多项选择radio中被选中的项以及值
			//	var  obj = document.getElementsByClassName("ddRadio");
				var  obj=this.$refs.ddResult.getElementsByTagName("input");	
				var  str = "";				
				  for(var i = 0; i < obj.length; i++) { 
					  if(obj[i].checked){ 
						  str +=obj[i].value; 
				 }  // 这里是数字之间的空格
				  }
				  if(str==this.info[this.index].result) {
					  this.whetherRight="回答正确";
					  document.getElementsByClassName("daTiArea")[this.index].style.background="blue";
					  this.trueNumber+=1;
				  }else{
					  this.whetherRight="回答错误";
					  document.getElementsByClassName("daTiArea")[this.index].style.background="red";
					  this.falseNumber+=1;
					  
					  var  obj=this.$refs.ddResult.getElementsByTagName("input");
					  if(obj[0].checked==true||obj[1].checked==true||obj[2].checked==true||obj[3].checked==true){					 
							 if(this.whetherRight=="回答错误"){			
									axios.get(this.rootUrl+'/cuoTi/insertCuoTi',{
										params:{
											id:parseInt(this.$refs.userId.value),
											testType:this.info[this.index].qstyleCode.toLowerCase(),
											QID:this.info[this.index].qid,
											updateTime:curentTime()
										}
									}); 
							
						 }
						  
						}
				  }			 	
			  }  ,
			  datiArea:function (event){
				this.index= parseInt(event.target.getAttribute("index")); 
				this.ifShow=false;
			  },
			  markQuestion : function (event){
				  var daTiArea=document.getElementsByClassName("daTiArea");
				  daTiArea[this.index].style.background="yellow";
				  
			  },
		// 改变字体大小
		fontsizeb(){
			this.fs += 4;
		},
		fontsizes(){
			this.fs -= 4;
		},
		submitMistakenQ (){
			
			axios.get(this.rootUrl+'/cuoTi/insMisQuestion',{
				params:{
			testType:this.info[this.index].qstyleCode.toLowerCase(),
			QID:this.info[this.index].qid,
			updateTime:curentTime(),
				}				
			}).then(response=> {	
				alert("同学,此题已上传至后台，随后进行研判");
			  }); 
		}
		
	}
})
