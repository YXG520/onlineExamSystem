var contextPath=document.getElementById("rootUrl").value;
var  SubjectCode=document.getElementById("SubjectCode").value;
document.write("<script language=javascript src='"+contextPath+"/js/commonUtils.js'></script>");
function getData(url,chapter,subjectCode) {
	  return axios.get(contextPath+'/'+url+'?Chapter='+chapter+'&SubjectCode='+subjectCode);
	} 
var vm = new Vue({
	el: '#bigBody',
	data() { 
	    return { 
		// 初始字体大小
		fs: 20,
		// 开始答题按钮的v-show值
		startBtn: 0,
		// 选题题目的数组
		questions:[],
		
		// 题目的索引值
		i:0,
		index:this.i+1,
		options:[],
		// 单选题的选项数组
		oneQueOpt: [],
		
		// 多选题的选项数组
		twoQueOpt:[],
		
		// 判断题的选项数组
		threeQueOpt:[],

		// 正确答案数组
		answers:[],
		
		checkValue:"",
		// 分钟初始值
		minutes:40,
		// 秒钟初始值
		seconds:0,
		// 计时器
		time: "",
		// 得分
		score: 0,
		// 空题的个数
		ending: 0,
		// 记录错题的index
		mistakes:[],
		// “上下一题”按钮的显示与隐藏的值
		previous: false,
		nextBtn: true,
		// 用户选项的存放数组
		checkOptions: [],
		str1:"",// 1. 单选题题目
	    str2:"",// 2. 多选题题目
	    str3:"",// 3. 判断题题目
	    index:0,
	    // 1. 单选题选项数组
	    dxOptions:[],
	    // 2. 多选题选项数组
	    ddOptions:[],
	    // 1. 多选题答案
	    ddResult:[],
	    // 1. 单选题结果
	    dxResult:[],
	    // 判断题答案
	    pdResult:[],
	    totalInfo:[],
	    mistakesInfoArray:[],
	    mistakesInfoStr:'',
	    pdUrl:"",
	    dxUrl:"",
	    ddUrl:"",
	    chapterIndex:1,
	    totalLength:0,
	    pdLength:0,
	    ddLength:0,
	    dxLength:0,
	    chapterAction:'',
	    info:[],
	    ifShowAnswer:false,
	    ifShow:false,
	    ifShowCheckBtn:false,
	    clickNumber:1,
	    btnContent:"查看答案"
	    }},
	mounted () {
	    	this.chapterAction=function(chapter,subjectCode){
			//	alert(subjectCode+chapter);
				 axios.all([getData("chapter/selPdByChapter",chapter,subjectCode), getData("chapter/selDxByChapter",chapter,subjectCode),
					 getData("chapter/selDdByChapter",chapter,SubjectCode)])
				  .then(axios.spread((randomPd25, randomDx60,randomDd15)=> {
					  this.info=randomDx60.data.concat(randomDd15.data,randomPd25.data);
					  this.chapterIndex=chapter;
					  this.str1=new Array(randomDx60.data.length);
					  this.str2=new Array(randomDd15.data.length);
					  this.str3=new Array(randomPd25.data.length);	
					  this.dxResult=new Array(randomDx60.data.length);
					  this.ddResult=new Array(randomDd15.data.length);
					  this.pdResult=new Array(randomPd25.data.length);	
					  // 将答案取出分别放到三个数组里
					  this.dxResult=  this.getSomething(randomDx60.data,"result");
					  this.ddResult=  this.getSomething(randomDd15.data,"result");
					  this.pdResult=  this.getSomething(randomPd25.data,"result");
					
					  //求题目总数
					  this.pdLength=parseInt(this.pdResult.length);
					  this.ddLength=parseInt(this.ddResult.length);
					  this.dxLength=parseInt(this.dxResult.length);
					  this.totalLength=parseInt(parseInt(this.dxResult.length)+parseInt(this.ddResult.length)+parseInt(this.pdResult.length));
					  for(var i=0;i<this.totalLength;i++){
						  this.checkOptions.push("");
					  }		
					  // 将标题取出分别放到三个数组里
					  this.str1=  this.getSomething (randomDx60.data,'topic');
					  this.str2=  this.getSomething (randomDd15.data,'topic');
					  this.str3=  this.getSomething (randomPd25.data,'topic');
					 
					  // 将单选和多选的选项取出分别放到二个数组里
					  this.dxOptions=  this.getSomething (randomDx60.data,'optionList');
					  this.ddOptions=  this.getSomething (randomDd15.data,'optionList');
					  this.totalInfo=randomDx60.data.concat(randomDd15.data,randomPd25.data);
				  })); 	
			}
	    	this.chapterAction(1,SubjectCode);
	 
		  },
	methods:{
		dynamicAction(chapter,subjectCode){			
			/*
			 * 点击左边的下拉框初始化状态
			 * */
			for (var i=0;i<this.info.length;i++){
				this.$refs.queNum.getElementsByTagName("li")[i].style.background="white";
				this.$refs.queNum.getElementsByTagName("li")[i].style.color="black"
			}
			this.startBtn=0;//
			this.i=0;
			//chapterAction为向后端发送请求
			this.chapterAction(chapter,subjectCode);
			
			// 从后台拿到题目、选项和答案
			this.setQuestions();
			this.setOptions();
			this.setAnswers();
			// 第一次调用optionLists()
			this.optionLists();
		},
		startBtnValue(){
			// 开始按钮的相关值设定
			this.startBtn = 1;
		},
		
		// 点击开始按钮时调用的函数
		clickStartBtn(){
			this.i=0;
			// 让“开始答题”按钮隐藏
			this.startBtnValue();
			// 从后台拿到题目、选项和答案
			this.setQuestions();
			this.setOptions();
			this.setAnswers();
			// 第一次调用optionLists()
			this.optionLists();
			
			
		},


		// 根据后台返回的数据得到题目、选项和答案,需调用
		getSomething (data,field){
			var output = [];
			for(var i= 0; i <data.length; i++) {	
				output.push(data[i][field]);
			}
			return output; 
		},




		// 练习题数据的上传到data
		setQuestions(){
				this.questions = this.str1.concat(this.str2, this.str3);
		},

		// 页面上题目的内容设置 重点是参数i,需要调用
		theQuestion(){
			if(this.i <= this.totalLength-1){
				this.$refs.queblockcont.innerText = this.questions[this.i];
			}
//				else{
//				this.$refs.queblockcont.innerText = "";
//			}
		},
		

		// 题目选项的数据上传到data
		setOptions(){
		this.options = this.dxOptions.concat(this.ddOptions);	
		},

		// 把某一题的选项值单独拿出来
		optionLists(){
			if(this.i <=(this.dxLength-1)){
				// 单选
				var check1 = this.options[this.i];
				this.oneQueOpt = eval(check1);
			} else if(this.i >=this.dxLength && this.i <=(this.dxLength+this.ddLength-1)){
				// 多选
				var check2 = this.options[this.i];
				this.twoQueOpt = eval(check2);
			} else if(this.i >=(this.dxLength+this.ddLength) && this.i <=(this.totalLength-1)){
				// 判断
				this.threeQueOpt = ['对', '错'];
			} else {
				console.log("i超出了题目的索引，这是optionLists()")
			}
			
		},
		
		

		// 把相应章节的题的全部答案存放在data的answer数组里
		setAnswers(){
						 
			this.answers = this.dxResult.concat(this.ddResult, this.pdResult);
		},




		// 清空input:check
		deleteChecked(w){
			for(let g = 0; g < w.length; g++){
				w[g].checked = false;
			}

		},
		showAnswerbtn(){
			this.clickNumber+=1;
			this.clickNumber%2==0?this.btnContent="不看答案":this.btnContent="查看答案";
			this.ifShowAnswer=!this.ifShowAnswer;
		},
		// 单选题和判断获取用户的选择，并且存放在checkOptions数组内
		getCheckOption(e,event){
			
			var checkval = this.$refs.answerSelect.getElementsByTagName("input");			
			this.checkChangeClassName();
			for(let v =0; v<checkval.length; v++){
				if(v != e){
					checkval[v].checked = false;
				}else{
					// 把用户输入的选项单独拿出来存放
					this.checkValue = checkval[v].value;
					this.checkOptions[this.i] = this.checkValue;
					this.checkValue = "";
				}
			}

		},

		// 多选题获取用户的选择，并且存放在checkOptions数组内
		getCheckOptionMul(){
			var checkval = this.$refs.answerSelect.getElementsByTagName("input");
			this.checkChangeClassName();
			for(let r = 0; r < checkval.length; r++){
				if(checkval[r].checked){
					this.checkValue += checkval[r].value;
				}
			}
			this.checkOptions[this.i] = this.checkValue;
			this.checkValue = "";
		},


		// 对比正确答案,算出分数
		getSore(){
			for(let n = 0; n < this.checkOptions.length; n++){
				
				if(this.checkOptions[n]===this.answers[n]){
					this.score +=1;
					
				}else{
					// mistakes数组里添加错题的索引值
					this.mistakes.push(n);
					if(this.checkOptions[n]!=""&&this.checkOptions[n]!=null){
						this.mistakesInfoArray.push({id:1,testType:this.totalInfo[n].qstyleCode.toLowerCase(),QID:this.totalInfo[n].qid,updateTime:curentTime()});		
						 axios.get(contextPath+'/cuoTi/insertCuoTi',{
						 params:{
								 id:parseInt(this.$refs.userId.value),
								 testType:this.totalInfo[n].qstyleCode.toLowerCase(),
								 QID:this.totalInfo[n].qid,
								 updateTime:curentTime()
						 }
						 });
					}	
				}
			
				
			}
			
		},


		// 做完题目加样式
		checkChangeClassName(){
			//this.$refs.queNum.getElementsByTagName("li")[this.i].className += " bli";		
			this.$refs.queNum.getElementsByTagName("li")[this.i].style.background="#4B81A3";
			this.$refs.queNum.getElementsByTagName("li")[this.i].style.color="#F1FBFB";
		
		},
		
		// 改变字体大小
		fontsizeb(){
			this.fs += 2;
		},
		fontsizes(){
			this.fs -= 2;
		},

		// 标记样式显示
		mark(){
			//this.$refs.queNum1.getElementsByTagName("li")[this.i].id = "cli";
			this.$refs.queNum.getElementsByTagName("li")[this.i].style.background="yellow";
			this.$refs.queNum.getElementsByTagName("li")[this.i].style.color="blue";
				
		},
		
		// 点击答题卡回到相应相应的题目
		goToClickedQuestion(g, e){
			if(this.questions!=null&&this.questions!=''){
				this.startBtn=1;	
			}
			if (g == 1){
				this.i = e;
			} else if(g == 2){
				this.i = this.dxLength + e;
				
			} else{
				this.i = this.dxLength+this.ddLength + e;
				
			}
			//遍历并重置input
			var checkval = this.$refs.answerSelect.getElementsByTagName("input");
			this.deleteChecked(checkval);
			//如果点击下一题是在之前已经做过的，在checkOptions数组里有数据，直接拿到之前做过的选项,选项不清空
			var checkedOpt = this.checkOptions[this.i];
			if(checkedOpt != ""){
				//取出之前的选择，令checked = true;
				this.checkOpts(checkedOpt, checkval);
			}
			this.theQuestion();
			this.optionLists();
		},

		checkOpts(z, x){
					for(var q = 0; q < z.length; q++){
						let t = z.substr(q, 1);
						console.log(t);
						if(t === 'A'){
							x[0].checked = true;
						}else if(t === 'B'){
							x[1].checked = true; 
						}else if(t === 'C'){
							x[2].checked = true;
						}else if(t === 'D'){
							x[3].checked = true;
						}else if(t ==='Y'){
							x[0].checked = true;
						}else if(t === 'N'){
							x[1].checked = true;
						}
					}
					
				},

		
		// 下一题
		next(){
			
			if(this.i < this.totalLength){
				this.i += 1;

				var checkval = this.$refs.answerSelect.getElementsByTagName("input");
				//str表示改题目用户所选择的多选答案
				var  str = "";				
				  for(var i = 0; i < checkval.length; i++) { 
					  if(checkval[i].checked){ 
						  str +=checkval[i].value; 
				 }  // 这里是数字之间的空格
				  }
				if(str!=this.totalInfo[this.i].result&&str!=''){
					axios.get(contextPath+'/cuoTi/insertCuoTi',{
						params:{
							id:parseInt(this.$refs.userId.value),
							testType:this.totalInfo[this.i].qstyleCode.toLowerCase(),
							QID:this.totalInfo[this.i].qid,
							updateTime:curentTime()
						}
					}).then(res=>{
					}); 
				
				}
				this.deleteChecked(checkval);
				// 如果点击下一题是在之前已经做过的，在checkOptions数组里有数据，直接拿到之前做过的选项,选项不清空
				var checkedOpt = this.checkOptions[this.i];
				if(checkedOpt != ""){
					console.log(checkedOpt);
					// 取出之前的选择，令checked = true;
					this.checkOpts(checkedOpt, checkval);
				}
				this.checkValue = "";
				
			} else{
				 this.i=this.totalLength-1;
			}
			this.theQuestion();	
			this.optionLists();	

			
		},
		// 上一题
		before(){
			this.i -=1;
			// 清空input:checked
			var checkval = this.$refs.answerSelect.getElementsByTagName("input");
			this.deleteChecked(checkval);
			if(this.i <this.totalLength){
				// 让“上一题”按钮消失
				if(this.i <= 0){
					//this.previous = false;
					this.i=0;
				}
				// 如果点击上一题是在之前已经做过的，直接拿到之前做过的选项,选项不清空,
				var  checkedOpt = this.checkOptions[this.i];
				if(checkedOpt != ""){
					// 取出之前的选择，令checked = true;
					this.checkOpts(checkedOpt, checkval);
				}

			}
			// 题目和选项值的重新设置
			this.theQuestion();
			this.optionLists();	
		},
		
		
		submit(){
			// 需要弹出框,加上按钮点击事件,点击确定则显示分数的页面,若是取消,则返回做题的页面.
			this.ending = 1;
		},
		clickCancel(e){
			this.ending = e;
		},
		clickYes(){
			// 点击确认说明提交答题卡
			// 1.隐藏弹出框
			this.clickCancel();
			// 2.获得分数
			this.getSore();
			// 3.显示有分数的界面
			this.startBtn = 2;
			// 4.改变答错题目答题卡题号的样式
			if(this.mistakes.length >0){
				for(let t = 0; t < this.mistakes.length; t++){
					let misLi = this.mistakes[t];
					//this.$refs.queNum.getElementsByTagName("li")[misLi].id = "mli";
					this.$refs.queNum.getElementsByTagName("li")[misLi].style.background= "#F66353";
					this.$refs.queNum.getElementsByTagName("li")[misLi].style.color= "#F1FBFB";
					
				};
			}
			
		},
		submitMistakenQ (){
			axios.get(contextPath+'/cuoTi/insMisQuestion',{
				params:{
			testType:this.info[this.i].qstyleCode.toLowerCase(),
			QID:this.info[this.i].qid,
			updateTime:curentTime(),
				}				
			}).then(response=> {	
				alert("同学,此题已上传至后台，随后进行研判");
			  }); 
		}
		
	},
})