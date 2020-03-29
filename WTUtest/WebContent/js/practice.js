function getRandomPd25(SubjectCode) {
	  return axios.get('selRandomPdByPdSubjectCode2?SubjectCode='+SubjectCode);
	} 
function getRandomDx60(SubjectCode) {
	  return axios.get('selRandomDx60BySubjectCode?SubjectCode='+SubjectCode);
	}
function getRandomDd15(SubjectCode) {
		  return axios.get('selRandomDd15BySubjectCode?SubjectCode='+SubjectCode);
	}

var vm = new Vue({
	el: '#practicing',
	 data () { 
	    return { 
		partone:[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60],
		parttwo:[61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85],
		partthree:[86,87,88,89,90,91,92,93,94,95,96,97,98,99,100],
		// 初始字体大小
		fs: 20,
		select:['A','B','C','D'],
		judge:['对','错'],
		pdInfo:null,//获取的json数组传给info
		ddInfo:null,
		dxInfo:null,
		SubjectCode:"SX",
		pdResult:"",//pd代表判断表，dd代表多选表，dx代表单选表
		topic:"",
		index:0,
		whetherRight:"",
		optionList:"",
		optionList2:["aa","bb","ccc","sss"],
		optionA:"",
		optionB:"",
		optionC:"",
		optionD:"",
		whetherChecked:true
			}
	}, mounted () {
		 axios.all([getRandomPd25(this.SubjectCode), getRandomDx60(this.SubjectCode),
			 getRandomDd15(this.SubjectCode)])
		  .then(axios.spread((randomPd25, randomDx60,randomDd15)=> {	
			this.topic=randomPd25.data[this.index].topic;
			this.pdInfo=randomPd25.data;
			this.dxInfo=randomDx60.data;
			this.ddInfo=randomDd15.data;
		  })); 		 
		  },
	methods:{ 
		btnClick: function(event){
			var that=this;
			if(event.target.value=="下一题"){
				this.index+=1;
				if(this.index>=99)	this.index=99;
			}else if(event.target.value=="上一题"){
				this.index-=1;
				if(this.index<=-1) this.index=0;	
			}
			
			if(this.index<=24){//因为index是从0开始的，所以第25道题目下标为24
				this.topic=this.pdInfo[this.index].topic;
			}
			else if(this.index>=25&&this.index<=84){
			this.topic=this.dxInfo[this.index-24].topic;
			this.optionList=JSON.parse(this.dxInfo[this.index-24].optionList);
			this.optionA=this.optionList[0];
			this.optionB=this.optionList[1];
			this.optionC=this.optionList[2];
			this.optionD=this.optionList[3];
			} 
			else if(this.index>=85){
				this.topic=this.ddInfo[this.index-84].topic;
				this.optionList=JSON.parse(this.ddInfo[this.index-84].optionList);
				this.optionA=this.optionList[0];
				this.optionB=this.optionList[1];
				this.optionC=this.optionList[2];
				this.optionD=this.optionList[3];
			}
		  }  ,
		  verifyAnswer: function (event){
			  if(this.index<=24){
				  if(event.target.value==this.pdInfo[this.index].result){
						this.whetherRight="回答正确";			
					}else{
						this.whetherRight="回答错误";
					} 
			  }else if(this.index>=25&&this.index<=84){
				  if(event.target.value==this.dxInfo[this.index-24].result){
						this.whetherRight="回答正确";			
					}else{
						this.whetherRight="回答错误";
					} 
			  }else{
				  
				  //获取多项选择radio中被选中的项以及值
					var  obj = document.getElementsByClassName("ddRadio");
					var  str = "";
					  for(i = 0; i < obj.length; i++) { 
						  if(obj[i].checked){ 
							  str +=obj[i].value; 
					 }  //这里是数字之间的空格
					  }
					  if(str==this.dxInfo[this.index-84].result){  
						  this.whetherRight="回答正确";	
					  }else{
						  this.whetherRight="回答错误";
						  
					  }
			  }
				
			  }  ,
			  datiArea: function (event){
				  if(event.target.parentElement.className="oul_pd"){
					this.index= event.target.index; 
				  }
				  else if(event.target.parentElement.className="oul_dx"){
					this.index= event.target.index+24; 
				  }else if(event.target.parentElement.className="oul_dd"){
					this.index= event.target.index+84; 
				  }
			  },
			  markQuestion : function (event){
				  if(this.index<=24){
					  var oliPd=document.getElementsByClassName("oliPd");
					  oliPd[this.index].style.background="yellow";
				  }	 
				  else  if(this.index>=25&&this.index<=84){
					  var oliPd=document.getElementsByClassName("oliDx");
					  oliPd[this.index-24].style.background="yellow";
				  }	
				  else if(this.index>=85){
					  var oliPd=document.getElementsByClassName("oliDd");
					  oliPd[this.index-84].style.background="yellow";
				  }	
			  },
		// 改变字体大小
		fontsizeb(){
			this.fs += 4;
		},
		fontsizes(){
			this.fs -= 4;
		},
		// 标记样式显示
		mark(){	
		}
	}
})