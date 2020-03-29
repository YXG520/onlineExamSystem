var vm=new Vue({
	    	el:'#searchArea',
		 data () { 
		    return { 
		    	QStyleCode:"",
		    	optionList:"",
		    	pdResult:"",
		    	dxResult:"",
		    	ddResult:"", 
		    	pdTopic:"",
		    	dxTopic:"",
		    	ddTopic:"",
		    	keyword:"",
		    	rootUrl:document.getElementById("rootUrl").value,
		   	    subjectCode:document.getElementById("subjectCode").value,
		    	info:"",
		  		    }
		    },
		    methods:{
		    	
		    	btnClick: function(event){
		    this.keyword=this.$refs.keyword.value;
		    		axios.get(this.rootUrl+"/selTiMu?QStyleCode="+this.QStyleCode+"&SubjectCode="+this.subjectCode+"&Topic="+this.keyword)
		    		.then(res=>{
		    			this.info=res.data;
		    			if(this.info[0].qstyleCode=="PD"){
		    				
		    				this.pdResult=res.data[0].result;
		    			}
		    			else if(this.info[0].qstyleCode=="DX"){
		    				this.dxResult=res.data[0].result;
		    			}else if(this.info[0].qstyleCode=="DD"){    
		    				this.ddResult=res.data[0].result;
		    			}	
		    		  }).catch(function (error) {
		    			    console.log(error);
		    		  });	
		    	}
		    }}
		    )