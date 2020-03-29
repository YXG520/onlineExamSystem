var vm = new Vue({
	el: '#practicing',
	 data () { 
	    return { 
		// 初始字体大小
		fs: 20,
		DxInfo:null,
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
		totalInfoArray:[],
		infoArray:[]
			}
	}, mounted () {
		axios.get(this.rootUrl+'/selAllDxBySubjectCode?SubjectCode='+this.SubjectCode).then(allDx=> {		
			this.DxInfo=allDx.data;
			this.optionList=JSON.parse(this.DxInfo[0].optionList);
		  }); 		 
		  },
	methods:{ 
		btnClick :function(event){
			var that =this;
			this.ifShow=false;		
			if(event.target.value=="下一题"){
			   this.index+=1;
			   if(this.index>=parseInt(this.DxInfo.length)){
				   this.index=parseInt(this.DxInfo.length)-1;
				}
			    document.getElementsByClassName("daTiArea")[this.index].style.background="blue";	
				this.whetherDisabled=false;	
								
				 var obj=this.$refs.dxResult.getElementsByTagName("input");
				
				 if(obj[0].checked==true||obj[1].checked==true||obj[2].checked==true||obj[3].checked==true){					 
					 if(this.whetherRight=="回答错误"){			
							axios.get(this.rootUrl+'/cuoTi/insertCuoTi',{
								params:{
									id:parseInt(this.$refs.userId.value),
									testType:this.DxInfo[this.index].qstyleCode.toLowerCase(),
									QID:this.DxInfo[this.index].qid,
									updateTime:curentTime()
								}
							}); 
					
				 }
				  
				}
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
			this.optionList=JSON.parse(this.DxInfo[this.index].optionList);
		  }  ,
		  verifyAnswer: function (event){	
			  this.ifShow=true;
			  this.whetherDisabled=true;
				  if(event.target.value==this.DxInfo[this.index].result){	 					 
						this.whetherRight="回答正确";
						this.trueNumber+=1;			
					}else{
						document.getElementsByClassName("daTiArea")[this.index].style.background="red";
						  this.falseNumber+=1;
						this.whetherRight="回答错误";
						
					} 	
			  }  ,
			  datiArea:function (event){
				  this.index= parseInt(event.target.getAttribute("index")); 
				  this.ifShow=false;
				  this.optionList=JSON.parse(this.DxInfo[this.index].optionList);
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
			testType:this.DxInfo[this.index].qstyleCode.toLowerCase(),
			QID:this.DxInfo[this.index].qid,
			updateTime:curentTime(),
				}				
			}).then(response=> {	
				alert("同学,此题已上传至后台，随后进行研判");
			  }); 
		}
		
	}
})
