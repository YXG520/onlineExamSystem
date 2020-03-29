var contextPath=document.getElementById("rootUrl").value;
var  SubjectCode=document.getElementById("SubjectCode").value;
function getRandomPd25(subjectCode) {
	  return axios.get(contextPath+'/selRandomPd25BySubjectCode?SubjectCode='+subjectCode);
	} 
function getRandomDx60(subjectCode) {
	  return axios.get(contextPath+'/selRandomDx60BySubjectCode?SubjectCode='+subjectCode);
	}
function getRandomDd15(subjectCode) {
		  return axios.get(contextPath+'/selRandomDd15BySubjectCode?SubjectCode='+subjectCode);
	}


var vm = new Vue({
	el: '#practicing',
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
		checkOptions: ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""],
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
	    info:[],
	    ifShowAnswer:false,
	    clickNumber:1,
	    btnContent:"查看答案"

	    }},
	mounted () {// this.$refs.SubjectCode.value
		 axios.all([getRandomPd25(SubjectCode), getRandomDx60(SubjectCode),
			 getRandomDd15(SubjectCode)])
		  .then(axios.spread((randomPd25, randomDx60,randomDd15)=> {
			  this.info=randomDx60.data.concat(randomDd15.data,randomPd25.data);
			  this.str1=new Array(60);
			  this.str2=new Array(15);
			  this.str3=new Array(25);	
			  this.dxResult=new Array(60);
			  this.ddResult=new Array(15);
			  this.pdResult=new Array(25);	
			  // 将答案取出分别放到三个数组里
			  this.dxResult=  this.getSomething(randomDx60.data,"result");
			  this.ddResult=  this.getSomething(randomDd15.data,"result");
			  this.pdResult=  this.getSomething(randomPd25.data,"result");
			 
			  // 将标题取出分别放到三个数组里
			  this.str1=  this.getSomething (randomDx60.data,'topic');
			  this.str2=  this.getSomething (randomDd15.data,'topic');
			  this.str3=  this.getSomething (randomPd25.data,'topic');
			 
			  // 将单选和多选的选项取出分别放到二个数组里
			  this.dxOptions=  this.getSomething (randomDx60.data,'optionList');
			  this.ddOptions=  this.getSomething (randomDd15.data,'optionList');
			  this.totalInfo=randomDx60.data.concat(randomDd15.data,randomPd25.data);				

		  })); 		 
		  },
	methods:{
		startBtnValue(){
			// 开始按钮的相关值设定
			this.startBtn = 1;
		},
		
		// 点击开始按钮时调用的函数
		clickStartBtn(){
			// 让“开始答题”按钮隐藏
			this.startBtnValue();
			// 开始倒计时
			this.countTime();
			// 从后台拿到题目、选项和答案
			this.setQuestions();
			this.setOptions();
			this.setAnswers();
			// 第一次调用optionLists()
			this.optionLists();
			
			
		},


		// 根据后台返回的数据得到题目、选项和答案,需调用
		getSomething (data,field){
			console.log(data[0][field]);
			var output = [];
			for(var i= 0; i <data.length; i++) {	
				output.push(data[i][field]);
			}
			return output; 
		},




		// 练习题数据的上传到data
		setQuestions(){
			/*
			 * 以下注释为测试数据
			 */
			// 调用getSomething();设置相关参数即可拿到str
			// 1. 单选题题目
			// var str1 = '["aaaaaaaa", "bbbbbbbb", "ccccccc", "ddddddd",
			// "eeeeeee", "fffffffff","gggggggg", "hhhhhhhhh", "asaaw",
			// "assvete", "aaaaaaaa", "bbbbbbbb", "ccccccc", "ddddddd",
			// "eeeeeee", "fffffffff","gggggggg", "hhhhhhhhh", "asaaw",
			// "assvete", "aaaaaaaa", "bbbbbbbb", "ccccccc", "ddddddd",
			// "eeeeeee", "fffffffff","gggggggg", "hhhhhhhhh", "asaaw",
			// "assvete", "aaaaaaaa", "bbbbbbbb", "ccccccc", "ddddddd",
			// "eeeeeee", "fffffffff","gggggggg", "hhhhhhhhh", "asaaw",
			// "assvete", "aaaaaaaa", "bbbbbbbb", "ccccccc", "ddddddd",
			// "eeeeeee", "fffffffff","gggggggg", "hhhhhhhhh", "asaaw",
			// "assvete", "aaaaaaaa", "bbbbbbbb", "ccccccc", "ddddddd",
			// "eeeeeee", "fffffffff","gggggggg", "hhhhhhhhh", "asaaw",
			// "assvete"]';
			// var partoneque = eval(str1);
			
			// 2.多选题题目
			// var str2 = '["得蝴蝶瓦好的", "当年黑u我和我", "内科外科蝶舞hi复合物", "呢威威hi文化氛围户外",
			// "那我呢我爸问我的", "得蝴蝶瓦好的", "当年黑u我和我", "内科外科蝶舞hi复合物", "呢威威hi文化氛围户外",
			// "那我呢我爸问我的", "得蝴蝶瓦好的", "当年黑u我和我", "内科外科蝶舞hi复合物", "呢威威hi文化氛围户外",
			// "那我呢我爸问我的"]';
			// var parttwoque = eval(str2);
			
			// 3.判断题题目
			// var str3 = '["cnskdhfiiwe", "dewhiwcbw", "djehrwnycrnq3",
			// "dercwrwncwhwo", "djicmrwocr3n8", "cnskdhfiiwe", "dewhiwcbw",
			// "djehrwnycrnq3", "dercwrwncwhwo", "djicmrwocr3n8", "cnskdhfiiwe",
			// "dewhiwcbw", "djehrwnycrnq3", "dercwrwncwhwo", "djicmrwocr3n8",
			// "cnskdhfiiwe", "dewhiwcbw", "djehrwnycrnq3", "dercwrwncwhwo",
			// "djicmrwocr3n8", "cnskdhfiiwe", "dewhiwcbw", "djehrwnycrnq3",
			// "dercwrwncwhwo", "djicmrwocr3n8" ]';
			// var partthreeque = eval(str3);

			// 三个数组合并，存储数据在questions
			// this.questions = partoneque.concat(parttwoque, partthreeque);
			this.questions = this.str1.concat(this.str2, this.str3);
		},

		// 页面上题目的内容设置 重点是参数i,需要调用
		theQuestion(){
			if(this.i <= 99){
				this.$refs.queblockcont.innerText = this.questions[this.i];
			}
// else{
// this.$refs.queblockcont.innerText = "";
// }
		},
		

		// 题目选项的数据上传到data
		setOptions(){
			/*
			 * 以下注释为测试数据
			 */
			// 1. 单选题的选项
			// var options1 = this.getSomething(radomDX60.data,
			// "optionList");//数组里面是60个字符串数组
		// var options1 = ["['sdsfwefe', 'dfewfewfe', 'deffgtrhtth',
		// 'dsdsgrhtrtgrhreh']", "['fsrgeeg', 'regerey', 'feeere',
		// 'feeeweyew']", "['hdsghh', 'aaqrwhyj', 'gdyuyjufdgd',
		// 'sewawqewrrth4resfe']", "['sefreigrgb', 'bufewfuefbe',
		// 'niewfigvdjfk', 'chegwfygwefuewf']", "['sdsfwefe', 'dfewfewfe',
		// 'deffgtrhtth', 'dsdsgrhtrtgrhreh']", "['fsrgeeg', 'regerey',
		// 'feeere', 'feeeweyew']", "['hdsghh', 'aaqrwhyj', 'gdyuyjufdgd',
		// 'sewawqewrrth4resfe']", "['sefreigrgb', 'bufewfuefbe',
		// 'niewfigvdjfk', 'chegwfygwefuewf']", "['sdsfwefe', 'dfewfewfe',
		// 'deffgtrhtth', 'dsdsgrhtrtgrhreh']", "['fsrgeeg', 'regerey',
		// 'feeere', 'feeeweyew']", "['hdsghh', 'aaqrwhyj', 'gdyuyjufdgd',
		// 'sewawqewrrth4resfe']", "['sefreigrgb', 'bufewfuefbe',
		// 'niewfigvdjfk', 'chegwfygwefuewf']", "['sdsfwefe', 'dfewfewfe',
		// 'deffgtrhtth', 'dsdsgrhtrtgrhreh']", "['fsrgeeg', 'regerey',
		// 'feeere', 'feeeweyew']", "['hdsghh', 'aaqrwhyj', 'gdyuyjufdgd',
		// 'sewawqewrrth4resfe']", "['sefreigrgb', 'bufewfuefbe',
		// 'niewfigvdjfk', 'chegwfygwefuewf']", "['sdsfwefe', 'dfewfewfe',
		// 'deffgtrhtth', 'dsdsgrhtrtgrhreh']", "['fsrgeeg', 'regerey',
		// 'feeere', 'feeeweyew']", "['hdsghh', 'aaqrwhyj', 'gdyuyjufdgd',
		// 'sewawqewrrth4resfe']", "['sefreigrgb', 'bufewfuefbe',
		// 'niewfigvdjfk', 'chegwfygwefuewf']", "['sdsfwefe', 'dfewfewfe',
		// 'deffgtrhtth', 'dsdsgrhtrtgrhreh']", "['fsrgeeg', 'regerey',
		// 'feeere', 'feeeweyew']", "['hdsghh', 'aaqrwhyj', 'gdyuyjufdgd',
		// 'sewawqewrrth4resfe']", "['sefreigrgb', 'bufewfuefbe',
		// 'niewfigvdjfk', 'chegwfygwefuewf']", "['sdsfwefe', 'dfewfewfe',
		// 'deffgtrhtth', 'dsdsgrhtrtgrhreh']", "['fsrgeeg', 'regerey',
		// 'feeere', 'feeeweyew']", "['hdsghh', 'aaqrwhyj', 'gdyuyjufdgd',
		// 'sewawqewrrth4resfe']", "['sefreigrgb', 'bufewfuefbe',
		// 'niewfigvdjfk', 'chegwfygwefuewf']", "['sdsfwefe', 'dfewfewfe',
		// 'deffgtrhtth', 'dsdsgrhtrtgrhreh']", "['fsrgeeg', 'regerey',
		// 'feeere', 'feeeweyew']", "['hdsghh', 'aaqrwhyj', 'gdyuyjufdgd',
		// 'sewawqewrrth4resfe']", "['sefreigrgb', 'bufewfuefbe',
		// 'niewfigvdjfk', 'chegwfygwefuewf']", "['sdsfwefe', 'dfewfewfe',
		// 'deffgtrhtth', 'dsdsgrhtrtgrhreh']", "['fsrgeeg', 'regerey',
		// 'feeere', 'feeeweyew']", "['hdsghh', 'aaqrwhyj', 'gdyuyjufdgd',
		// 'sewawqewrrth4resfe']", "['sefreigrgb', 'bufewfuefbe',
		// 'niewfigvdjfk', 'chegwfygwefuewf']", "['sdsfwefe', 'dfewfewfe',
		// 'deffgtrhtth', 'dsdsgrhtrtgrhreh']", "['fsrgeeg', 'regerey',
		// 'feeere', 'feeeweyew']", "['hdsghh', 'aaqrwhyj', 'gdyuyjufdgd',
		// 'sewawqewrrth4resfe']", "['sefreigrgb', 'bufewfuefbe',
		// 'niewfigvdjfk', 'chegwfygwefuewf']", "['sdsfwefe', 'dfewfewfe',
		// 'deffgtrhtth', 'dsdsgrhtrtgrhreh']", "['fsrgeeg', 'regerey',
		// 'feeere', 'feeeweyew']", "['hdsghh', 'aaqrwhyj', 'gdyuyjufdgd',
		// 'sewawqewrrth4resfe']", "['sefreigrgb', 'bufewfuefbe',
		// 'niewfigvdjfk', 'chegwfygwefuewf']", "['sdsfwefe', 'dfewfewfe',
		// 'deffgtrhtth', 'dsdsgrhtrtgrhreh']", "['fsrgeeg', 'regerey',
		// 'feeere', 'feeeweyew']", "['hdsghh', 'aaqrwhyj', 'gdyuyjufdgd',
		// 'sewawqewrrth4resfe']", "['sefreigrgb', 'bufewfuefbe',
		// 'niewfigvdjfk', 'chegwfygwefuewf']", "['sdsfwefe', 'dfewfewfe',
		// 'deffgtrhtth', 'dsdsgrhtrtgrhreh']", "['fsrgeeg', 'regerey',
		// 'feeere', 'feeeweyew']", "['hdsghh', 'aaqrwhyj', 'gdyuyjufdgd',
		// 'sewawqewrrth4resfe']", "['sefreigrgb', 'bufewfuefbe',
		// 'niewfigvdjfk', 'chegwfygwefuewf']", "['sdsfwefe', 'dfewfewfe',
		// 'deffgtrhtth', 'dsdsgrhtrtgrhreh']", "['fsrgeeg', 'regerey',
		// 'feeere', 'feeeweyew']", "['hdsghh', 'aaqrwhyj', 'gdyuyjufdgd',
		// 'sewawqewrrth4resfe']", "['sefreigrgb', 'bufewfuefbe',
		// 'niewfigvdjfk', 'chegwfygwefuewf']", "['sdsfwefe', 'dfewfewfe',
		// 'deffgtrhtth', 'dsdsgrhtrtgrhreh']", "['fsrgeeg', 'regerey',
		// 'feeere', 'feeeweyew']", "['hdsghh', 'aaqrwhyj', 'gdyuyjufdgd',
		// 'sewawqewrrth4resfe']", "['sefreigrgb', 'bufewfuefbe',
		// 'niewfigvdjfk', 'chegwfygwefuewf']", ];
			// 2.多选题的"optionList"
			// var options2 = this.getSomething(radomDX15.data, "optionList");
		// var options2 = ["['fgththt', 'dewrrrrrrrrssr', 'gfegreyt',
		// 'kujfgswqref']", "['sefreigrgb', 'bufewfuefbe', 'niewfigvdjfk',
		// 'chegwfygwefuewf']", "['fgththt', 'dewrrrrrrrrssr', 'gfegreyt',
		// 'kujfgswqref']", "['sefreigrgb', 'bufewfuefbe', 'niewfigvdjfk',
		// 'chegwfygwefuewf']", "['fgththt', 'dewrrrrrrrrssr', 'gfegreyt',
		// 'kujfgswqref']", "['sefreigrgb', 'bufewfuefbe', 'niewfigvdjfk',
		// 'chegwfygwefuewf']", "['fgththt', 'dewrrrrrrrrssr', 'gfegreyt',
		// 'kujfgswqref']", "['sefreigrgb', 'bufewfuefbe', 'niewfigvdjfk',
		// 'chegwfygwefuewf']", "['fgththt', 'dewrrrrrrrrssr', 'gfegreyt',
		// 'kujfgswqref']", "['sefreigrgb', 'bufewfuefbe', 'niewfigvdjfk',
		// 'chegwfygwefuewf']", "['fgththt', 'dewrrrrrrrrssr', 'gfegreyt',
		// 'kujfgswqref']", "['sefreigrgb', 'bufewfuefbe', 'niewfigvdjfk',
		// 'chegwfygwefuewf']", "['fgththt', 'dewrrrrrrrrssr', 'gfegreyt',
		// 'kujfgswqref']", "['sefreigrgb', 'bufewfuefbe', 'niewfigvdjfk',
		// 'chegwfygwefuewf']", "['fgththt', 'dewrrrrrrrrssr', 'gfegreyt',
		// 'kujfgswqref']" ];
			// 数组合并，存放数据在options
			this.options = this.dxOptions.concat(this.ddOptions);	
		},

		// 把某一题的选项值单独拿出来
		optionLists(){
			if(this.i <=59){
				// 单选
				var check1 = this.options[this.i];
				this.oneQueOpt = eval(check1);
			} else if(this.i >59 && this.i <=74){
				// 多选
				var check2 = this.options[this.i];
				this.twoQueOpt = eval(check2);
			} else if(this.i >74 && this.i <=99){
				// 判断
				this.threeQueOpt = ['对', '错'];
			}
			
		},
		
		

		// 把100个题的全部答案存放在data的answer数组里
		setAnswers(){
			/*
			 * 以下注释为测试数据
			 */
			// var oneAnswer = this.getSomething(randomDX60.data, "result");
			// var oneAnswer =
			// ['A','D','C','A','C','D','A','B','B','B','A','D','C','A','C','D','A','B','B','B','A','D','C','A','C','D','A','B','B','B','A','D','C','A','C','D','A','B','B','B','A','D','C','A','C','D','A','B','B','B','A','D','C','A','C','D','A','B','B','B',];
			// var twoAnswer = this.getSomething(randomDX15, "result");
			// var twoAnswer = ['ABCD', 'ABC', 'BCD', 'AD', 'BC', 'ABD', 'CD',
			// 'ABCD', 'ABC', 'BCD', 'AD', 'BC', 'ABD', 'CD', 'ABC'];
			// var threeAnswer = this.getSomething(randomPD25, 'result');
			// var threeAnswer = ['Y', 'N', 'Y', 'Y', 'Y', 'Y', 'N', 'Y', 'Y',
			// 'Y', 'Y', 'N', 'Y', 'Y', 'Y', 'Y', 'N', 'Y', 'Y', 'Y', 'Y', 'N',
			// 'Y', 'Y', 'Y'];
			// 合并三个数组，存放数据在Answers
			 
			this.answers = this.dxResult.concat(this.ddResult, this.pdResult);
		},




		// 清空input:check
		deleteChecked(w){
			for(let g = 0; g < w.length; g++){
				w[g].checked = false;
			}

		},

		// 单选题和判断获取用户的选择，并且存放在checkOptions数组内
		getCheckOption(e){
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
		showAnswerbtn(){
			this.clickNumber+=1;
			this.clickNumber%2==0?this.btnContent="不看答案":this.btnContent="查看答案";
			this.ifShowAnswer=!this.ifShowAnswer;
		},

		// 对比正确答案,算出分数
		getSore(){
			for(let n = 0; n < this.checkOptions.length; n++){
				if(this.checkOptions[n]===this.answers[n]){
					this.score +=1;
					
				}else{
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
					}					}
			
				
			}
			/*
			 * 试图将100个错题的相关信息传送给后台 但是失败了
			 */
			
		},


		// 做完题目加样式
		checkChangeClassName(){
			this.$refs.queNum.getElementsByTagName("li")[this.i].className += " bli";			
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
			this.$refs.queNum1.getElementsByTagName("li")[this.i].id = "cli";
		},
		
		// 点击答题卡回到相应相应的题目
		goToClickedQuestion(g, e){
			if(this.questions!=null&&this.questions!=''){
				this.startBtn=1;	
			}
			
			if (g == 1){
				this.i = e;
			} else if(g == 2){
				this.i = 60 + e;
				
			} else{
				this.i = 75 + e;
				
			}
			// 遍历并重置input
			var checkval = this.$refs.answerSelect.getElementsByTagName("input");
			this.deleteChecked(checkval);
			// 如果点击下一题是在之前已经做过的，在checkOptions数组里有数据，直接拿到之前做过的选项,选项不清空
			var checkedOpt = this.checkOptions[this.i];
			if(checkedOpt != ""){
				// 取出之前的选择，令checked = true;
				this.checkOpts(checkedOpt, checkval);
			}
			this.theQuestion();
			this.optionLists();
		},

		checkOpts(z, x){
					for(var q = 0; q < z.length; q++){
						console.log(q);
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
			
			if(this.i <= 99){
				
				
				// 遍历并重置input
				var checkval = this.$refs.answerSelect.getElementsByTagName("input");
				this.deleteChecked(checkval);
				// 如果点击下一题是在之前已经做过的，在checkOptions数组里有数据，直接拿到之前做过的选项,选项不清空
				var checkedOpt = this.checkOptions[this.i];
				if(checkedOpt != ""){
					// 取出之前的选择，令checked = true;
					this.checkOpts(checkedOpt, checkval);
				}
				this.checkValue = "";
				this.i += 1;
			} else{
				this.i=99;
				
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
			if(this.i <=99){
				// 让“上一题”按钮消失
				if(this.i <= 0){
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
		
		// 倒计时40分钟
		countTime(){
				this.time = window.setInterval( ()=>{
				var _this = this;
				// 预设秒钟的字符串型,方便<10时正规格式显示在页面上
				var s = "59";
				if (_this.seconds === 0 && _this.minutes !== 0) {
					_this.seconds = 59;
					_this.minutes -= 1;
				} else if (_this.minutes === 0 && _this.seconds === 0) {
					_this.seconds = 0;
					window.clearInterval(time);
				} else {
					_this.seconds -= 1;
					if (_this.seconds < 10) {
						s = "0" + _this.seconds;
					} else{
						s = _this.seconds;
					}
				}
				_this.$refs.retime.innerText = "剩余时间 : " + _this.minutes + ":" + s;
			}, 1000);
			
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
					this.$refs.queNum.getElementsByTagName("li")[misLi].id = "mli";
				};
			}
			
		},submitMistakenQ (){
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