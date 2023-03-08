struct Floyd
{
	const int inf = 0x3f3f3f3f;
	int g[N][N];
	int size;
	Floyd(int n)
	{
		size = n;
		for(int i = 1;i <= size;++i)
			for(int j = 1;j <= size;++j)
				if(i == j)
					g[i][j] = 0;
				else 
					g[i][j] = inf;
	}

	void change(int a,int b,int c)
	{
		g[a][b] = min(g[a][b],c);
	}

	void floyd()
	{
		for(int k = 1;k <= size;++k)
			for(int i = 1;i <= size;++i)
				for(int j = 1;j <= size;++j)
					g[i][j] = min(g[i][j],g[i][k] + g[k][j]);
	}
};
