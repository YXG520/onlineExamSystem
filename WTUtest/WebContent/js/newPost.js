//getRootUrl()
function getUserComment() {
  return axios.get('/comment/selComment');
}
 
function getBroadcast() {
  return axios.get('/broadcast/selBroadcast');
}
var vm = new Vue({
	el: "#board",
	data: {
		inputMsg: "",
		specificTime:curentTime(),
		rootUrl:getRootUrl(),//该方法来自commonUtils.js
		commentInfo:[],
		start:0,
		end:3,
		pageNumber:1,
		cIndex:0,
		isCommitted:false,
		thumbUpUrl:'',
		thumbDownUrl:'',
		deleteCommentUrl:'',
		userImg:[],
		broadcastInfo:[],
		deleteBroadcastUrl:'',
		broadcastStart:0,
		broadcastEnd:3
	},
	
	mounted(){
		 axios.all([getUserComment(), getBroadcast()])
		  .then(axios.spread((resCommentData,resBroadcastData)=> {	
			  this.commentInfo=resCommentData.data;			
			  this.broadcastInfo=resBroadcastData.data;
				 for(var i=0;i<this.commentInfo.length;i++){
					 if(this.commentInfo[i].users.photo.length>10){
						 this.userImg.push(this.rootUrl+"/customerImages/"+this.commentInfo[i].users.photo); 
					 }else{
						 this.userImg.push(this.rootUrl+"/images/regist/"+this.commentInfo[i].users.photo); 
					 }
					 		 
				 }

		  })); 	
		
		
	},
	methods:{
		getCommentTime:function(){
			//表单是否已经提交标识，默认为false
			         
			              if(this.isCommitted==false){
			                 this.isCommitted = true;//提交表单后，将表单是否已经提交标识设置为true
			                 this.$refs.specificTime.value=curentTime();
			                 return this.isCommitted;//返回true让表单正常提交
			             }else{
			                 return false;//返回false那么表单将不提交
			             }
			
		
		},
		targetPage(event){			
			var pageSize=4;
			var pageLargestNumber= Math.ceil(parseInt(this.commentInfo.length)/parseInt(pageSize));
			if(event.target.value=='首页'){
				this.pageNumber=1;
				this.start=0;
				this.end=3;
				
			}
			if(event.target.value=='下一页'){
			if(this.pageNumber>=pageLargestNumber){
				this.pageNumber=pageLargestNumber;
			}	
			else{
				this.pageNumber+=1;	
				this.start=parseInt(this.end)+1;
				this.end=parseInt(this.pageNumber)*parseInt(pageSize)-1;
			}			
			
			
			}
			if(event.target.value=='上一页'){
				this.pageNumber-=1;
				if(this.pageNumber<=1){
					this.pageNumber=1;
					this.end=3;
					this.start=0
				}else{
					this.end=parseInt(this.start)-1;
					this.start=parseInt(this.pageNumber-1)*parseInt(pageSize);
					
				}
				
				
			}
			if(event.target.value=='尾页'){
				this.pageNumber=pageLargestNumber;
				this.start=parseInt(this.pageNumber-1)*parseInt(pageSize);
				this.end=this.commentInfo.length;
			}
		},
		targeNewstPage(event){			
			var pageSize=4;
			var pageLargestNumber= Math.ceil(parseInt(this.broadcastInfo.length)/parseInt(pageSize));
			if(event.target.value=='首页'){
				this.pageNumber=1;
				this.broadcastStart=0;
				this.broadcastEnd=3;
				
			}
			if(event.target.value=='下一页'){
			if(this.pageNumber>=pageLargestNumber){
				this.pageNumber=pageLargestNumber;
			}	
			else{
				this.pageNumber+=1;	
				this.broadcastStart=parseInt(this.broadcastEnd)+1;
				this.broadcastEnd=parseInt(this.pageNumber)*parseInt(pageSize)-1;
			}			
			
			
			}
			if(event.target.value=='上一页'){
				this.pageNumber-=1;
				if(this.pageNumber<=1){
					this.pageNumber=1;
					this.broadcastEnd=3;
					this.broadcastStart=0
				}else{
					this.broadcastEnd=parseInt(this.broadcastStart)-1;
					this.broadcastStart=parseInt(this.pageNumber-1)*parseInt(pageSize);
					
				}
				
				
			}
			if(event.target.value=='尾页'){
				this.pageNumber=pageLargestNumber;
				this.broadcastStart=parseInt(this.pageNumber-1)*parseInt(pageSize);
				this.broadcastEnd=this.broadcastInfo.length;
			}
		},
		deleteComment:function(event){
			this.cIndex= parseInt(event.target.getAttribute("index")); 			
			this.deleteCommentUrl=this.rootUrl+'/comment/deleteComment?cid='+parseInt(this.commentInfo[this.cIndex].cid);
		},
		
		updateUpComment:function(event){
			this.cIndex= parseInt(event.target.getAttribute("index")); 
			var upNumber= this.commentInfo[this.cIndex].thumbUp;
			if(upNumber==''||upNumber==null){
				upNumber=0;
			}
			else{
				upNumber=parseInt(this.commentInfo[this.cIndex].thumbUp);
			}
			this.thumbUpUrl=this.rootUrl+"/comment/updateComment?thumbUp="+parseInt(upNumber+1)+"&cid="+parseInt(this.commentInfo[this.cIndex].cid);
		},
		updateDownComment:function(event){
			this.cIndex= parseInt(event.target.getAttribute("index")); 
			var downNumber =this.commentInfo[this.cIndex].thumbDown;
			if(downNumber==''||downNumber==null) {
				downNumber=0;
			}
			else {
				downNumber=parseInt(this.commentInfo[this.cIndex].thumbDown);
			}
			this.thumbDownUrl=this.rootUrl+"/comment/updateComment?thumbDown="+parseInt(downNumber+1)+"&cid="+parseInt(this.commentInfo[this.cIndex].cid)
		},
		deleteBroadcast:function(event){
			this.cIndex= parseInt(event.target.getAttribute("index")); 			
			this.deleteBroadcastUrl=this.rootUrl+'/broadcast/deleteBroadcast?broadcastId='+parseInt(this.broadcastInfo[this.cIndex].broadcastId);
		},
		
					}
})
