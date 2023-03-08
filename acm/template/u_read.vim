int read(){
	int f=1,k=0;//f是正负号,k用来将字符转换成数字
	char c=getchar();//读入一个字符 
	//非数字 
	while(c<'0'||c>'9'){//读到空格后
		c=getchar();//读入空格等。 
	}
	//数字 
	while(c>='0'&&c<='9'){
		k=k*10+c-'0';
		c=getchar();//一位一位读入数字 
	}
	return f*k;
}
