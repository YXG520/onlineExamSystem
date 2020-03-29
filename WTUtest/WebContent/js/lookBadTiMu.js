
var vm = new Vue({
	el: "#page_content",
	data: {
		specificTime:curentTime(),
		rootUrl:document.getElementById("rootUrl").value,
		commentInfo:[],
		start:0,
		end:7,
		pageNumber:1,
		pageSize:8,
		cIndex:0,
		isCommitted:false,
		updateMaoBinUrl:"",
		pageInfo:[],
		deleteTiMuUrl:""
	},
	created(){
		//留言的json数据包括 1.用户头像的文件 2.用户名 3.提交的留言内容  4.点击提交按钮时的时间(有固定格式) 5.点赞数  6.踩数
		//公告的json数据包括  1.标题  2.简单介绍 3.时间
		
	},
	mounted(){
	//	window.location.href=this.rootUrl+'/cuoTi/findFKofMaoBing'
		axios.get(this.rootUrl+'/cuoTi/findFKofMaoBing')
		  .then(response => { 
			  this.pageInfo=response.data;
		  })
		  .catch(function (error) {
		    console.log(error);
		  });	
	},
	methods:{
		
		targetPage(event){
			
			
			var pageLargestNumber= Math.ceil(parseInt(this.pageInfo.length)/parseInt(this.pageSize));
			console.log(pageLargestNumber)
			if(event.target.innerText=='首页'){
				this.pageNumber=1;
				this.start=0;
				this.end=7;
				
			}
			if(event.target.innerText=='下一页'){
			if(this.pageNumber>=pageLargestNumber){
				this.pageNumber=pageLargestNumber;
			}	
			else{
				this.pageNumber+=1;	
				this.start=parseInt(this.end)+1;
				this.end=parseInt(this.pageNumber)*parseInt(this.pageSize)-1;
			}			
			
			}
			if(event.target.innerText=='上一页'){
				this.pageNumber-=1;
				if(this.pageNumber<=1){
					this.pageNumber=1;
					this.end=7;
					this.start=0
				}else{
					this.end=parseInt(this.start)-1;
					this.start=parseInt(this.pageNumber-1)*parseInt(this.pageSize);
					
				}
				
				
			}
			if(event.target.innerText=='尾页'){
				this.pageNumber=pageLargestNumber;
				this.start=parseInt(this.pageNumber-1)*parseInt(this.pageSize);
				this.end=this.pageInfo.length;
			}
		},
		
		deleteTiMu:function(event){
			this.cIndex= parseInt(event.target.getAttribute("index"));		
			this.deleteTiMuUrl=this.rootUrl+'/cuoTi/deleteMaoBinRecord?mid='+parseInt(this.pageInfo[this.cIndex].misQuestion.mid);
			
		},
		updateMaoBin:function(event){
			this.cIndex= parseInt(event.target.getAttribute("index")); 
		    var optionlist=	(this.pageInfo[this.cIndex].optionList).replace("[",'');
			 optionlist=	optionlist.replace("]",'');
			this.updateMaoBinUrl=this.rootUrl+"/view/adminjsp/updateMaoBing.jsp?qstyleCode="
			+this.pageInfo[this.cIndex].qstyleCode+"&subjectCode="+this.pageInfo[this.cIndex].subjectCode+"&qid="+this.pageInfo[this.cIndex].qid
			+"&topic="+this.pageInfo[this.cIndex].topic+"&result="+this.pageInfo[this.cIndex].result+"&optionList="+optionlist
			+"&updateTime="+this.pageInfo[this.cIndex].updateTime+"&chapter="+this.pageInfo[this.cIndex].chapter+"&difficulty="+this.pageInfo[this.cIndex].difficulty;
			//event.target.setAttribute("href",this.updateMaoBinUrl)	;
		},
		updateDownComment:function(event){
			this.cIndex= parseInt(event.target.getAttribute("index")); 
			var downNumber =this.pageInfo[this.cIndex].thumbDown;
			if(downNumber==''||downNumber==null) {
				downNumber=0;
			}
			else {
				downNumber=parseInt(this.pageInfo[this.cIndex].thumbDown);
			}
			this.thumbDownUrl=this.rootUrl+"/comment/updateComment?thumbDown="+parseInt(downNumber+1)+"&cid="+parseInt(this.pageInfo[this.cIndex].cid)
		},
		
					}
})
