
var vm=new Vue({
	el:"#showArea",
	data() { 
	    return {
		info:"",
		optionList:[],
		userId:document.getElementById("userId").value,
		start:0,
		end:2,
		pageNumber:1,
		commentInfo:[],
		rootUrl:document.getElementById("rootUrl").value,
	}
	    },
	mounted(){

		axios.get(this.rootUrl+'/cuoTi/selByUserIdInRecord',{
			params:{
				id:parseInt(this.userId),
			}
		}).then(response=>{
			this.info=response.data;
			this.commentInfo=response.data;
			if(this.info!=null&&this.info!=''){
				for(var i=0;i<this.info.length;i++){
					this.optionList.push(JSON.parse(this.info[i].optionList));
					
				}
			}else{
				alert("在此科目上，您暂时还没有产生任何错题集，快去刷题吧");
			}
			
			
		
		  }).catch(function (error) {
			    console.log(error);
		  });
		  
	},
	methods:{
		targetPage(event){			
			var pageSize=3;
			var pageLargestNumber= Math.ceil(parseInt(this.commentInfo.length)/parseInt(pageSize));
			console.log(pageLargestNumber)
			if(event.target.value=='首页'){
				this.pageNumber=1;
				this.start=0;
				this.end=2;
				
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
					this.end=2;
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
		
	}
})
