var vm = new Vue({
	el: '#practicing',
	 data () { 
	    return { 
		// 初始字体大小
		fs: 20,
		pdInfo:'',//获取的json数组传给info
		SubjectCode:document.getElementById("SubjectCode").value,
		rootUrl:document.getElementById("rootUrl").value,
		topic:"",
		index:0,
		whetherRight:"",
		optionList:"",
		falseNumber:0,
		trueNumber:0,
		whetherDisabled:false,
		ifShow:false,
    }
	}, mounted () {
		axios.get(this.rootUrl+'/selAllPdBySubjectCode?SubjectCode='+this.SubjectCode).then(allPd=> {	
			this.pdInfo=allPd.data;
		  }); 		 
		  },
	methods:{ 
		btnClick: function(event){
			this.ifShow=false;
			if(event.target.value=="下一题"){
				 this.whetherDisabled=false;
				this.index+=1;			
				if(this.index>=parseInt(this.pdInfo.length)){
					   this.index=parseInt(this.pdInfo.length)-1;
					}
				document.getElementsByClassName("daTiArea")[this.index].style.background="blue";
				if(this.index>=this.pdInfo.length)	this.index=this.pdInfo.length;
				 var obj=this.$refs.pdResult.getElementsByTagName("input");
				 if(obj[0].checked==true||obj[1].checked==true){
					 
					 if(this.whetherRight=="回答错误"){			
							axios.get(this.rootUrl+'/cuoTi/insertCuoTi',{
								params:{
									id:parseInt(this.$refs.userId.value),
									testType:this.pdInfo[this.index].qstyleCode.toLowerCase(),
									QID:this.pdInfo[this.index].qid,
									updateTime:curentTime()
								}
							}); 					
				 }				  
				}
					for(var i = 0; i < obj.length; i++) { 
						obj[i].checked=false;	  
					  }		
			}else if(event.target.value=="上一题"){
				 
				 if(this.index>0)
					 document.getElementsByClassName("daTiArea")[this.index].style.background="white";
            	this.index-=1;
				if(this.index<=-1) this.index=0;	
			}
		  }  ,
		  verifyAnswer: function (event){	
			  this.ifShow=true;
			  var daTiArea=document.getElementsByClassName("daTiArea");
				  if(event.target.value==this.pdInfo[this.index].result){	 
					  daTiArea[this.index].style.background="blue";
						this.whetherRight="回答正确";
						this.trueNumber+=1;			
					}else{
						  daTiArea[this.index].style.background="red";
						  this.falseNumber+=1;
						this.whetherRight="回答错误";
					} 	
			  }  ,
			  pddatiArea:function (event){
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
			testType:this.pdInfo[this.index].qstyleCode.toLowerCase(),
			QID:this.pdInfo[this.index].qid,
			updateTime:curentTime(),
				}				
			}).then(response=> {	
				alert("同学,此题已上传至后台，随后进行研判");
			  }); 
		}
	}
})