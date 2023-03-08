int read(){
	int f=1,k=0;
	char c=getchar();//读入一个字符 
	//非数字 
	while(c<'0'||c>'9'){//读到空格后
		if(c=='-') //读到负数 
		f=-1;//保留负号 
		c=getchar();//两个功能：读取负号后面的数字或者读入空格等。 
	}
	//数字 
	while(c>='0'&&c<='9'){
		k=k*10+c-'0';
		c=getchar();//一位一位读入数字 
	}
	return f*k;
}
