
var contextPath=getRootUrl();

var vm=new Vue({
	  el: '#forms',
	  data () { 
	    return { 
	      forUsername:"",
	      info: null,
	      forMail:"",
	      forMounted:"",
	      error:"",
	      usernameExist:"",
	      mailExist:"",
	      rootUrl:document.getElementById("rootUrl").value,
	      num: null,
	      imgUrl: '',
	    }
	  }, 
	  mounted () {
		  this.forMounted=function(){
			  axios.get(this.rootUrl+'/checkCodeForMail', {
				    params: {
				    	 username:this.forUsername,
			             mail:this.forMail
				    }
				  })
	 		    .then(response=> { 
	 		    	this.info=response.data;
	 		    	 if(this.info!="") alert(this.info);
	 		    })
	 		    .catch(function (error) {
	 		      console.log(error);
	 		    });
		  }	 		 
	  },
	  methods:{
		btnCheckClick:function (event){		
		var flag=doCodes("mail","getCode",120);
		if(flag==true){
			this.forMounted();	
		}				
		  },
		  ifSame(){
		if(matchStr("password","passwordsure")==false){
			alert("密码前后不一致")
		}
		  },
		  judgeLength(){
			  if(judgeLength("password")<5){
				  alert("密码长度不能小于6位")
			  }
		  },
		  ifNotNullStr:function(){
		    var forName= document.getElementById("forms").getElementsByClassName("isNull");
	 		var flag=notNullStr(forName); 		
			  if(flag==false){
	 			alert("注册内容不能为空");
	 		}else{
	 			
	 			document.getElementById("forms").submit();
	 		}
	 		 },
		mailIfExist:function (event){
			let flag= checkemail("mail");
 			if(flag==false){
 				alert("请输入正确格式的邮箱");
 			}else{
 				axios.get(this.rootUrl+'/user/mailIfExist', {
				    params: {
				     mail:this.forMail
				    }
				  })
	 		    .then(response=> { 
	 		    	 if(response.data!="")  this.mailExist="该邮箱已被注册";
	 		    	 else this.mailExist="";
	 		    })
	 		    .catch(function (error) {
	 		      console.log(error);
	 		    });
 			}	 		
		  },
		usernameIfExist:function (event){
			axios.get(this.rootUrl+'/user/usernameIfExist', {
			    params: {
			    	username:this.forUsername
			    }
			  })
 		    .then(response=> { 
 		    	 if(response.data!="")  this.usernameExist="该用户名已被使用";
 		    	 else this.usernameExist="";
 		    })
 		    .catch(function (error) {
 		      console.log(error);
 		    });
			
			  },
			  //随机切换系统图片
			  getNum(){
				 	this.num = Math.ceil(Math.random()*20);//0-10随机数	 	
				 	var randomImgUrl = this.rootUrl+"/images/regist/img"+this.num+".jpg";
				 	this.$refs.accountImg.setAttribute('src', randomImgUrl);
				 	let filename = "img"+this.num+".jpg"; 
				 	this.$refs.getfilename.value=""; 				 
				 	this.$refs.setfilename.innerText = filename;
				 	//this.$refs.systemPicUrl.value = randomImgUrl;
				 	this.$refs.systemPicUrl.value=filename;
				 },
				//头像图片预览
					uploadImg(e){
						let file = e.target.files[0];
						let filename = file.name;
						let fileSize = file.size;					
			        		//限制图片的大小
							if(fileSize>600*1024){
							alert('上传的图片的大于600K,请重新选择,或者选择系统为您分配的图片');
							this.$refs.getfilename.value='';
			        		}else{
								let url = '';
								var reader = new FileReader();
								reader.readAsDataURL(file);
								let that = this;
								reader.onload = function(e){
									url = this.result.substring(this.result.indexOf(',')+1);
									that.imgUrl = 'data:img/png;base64,'+url;
									that.$refs.accountImg.setAttribute('src', that.imgUrl);
							
								}
								let filevalue = this.$refs.getfilename.value
								filevalue = filename;
								console.log(filename);
								this.$refs.setfilename.innerText = filename;
							
			        		}
			        			        	
					},
	  }
	}) 
