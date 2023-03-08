struct Topsort
{
	int n,m;
	int e[N],ne[N],h[N],idx;
	int into[N];
	int q[N];

	void add(int a,int b)
	{
		e[idx] = b,ne[idx] = h[a],h[a] = idx++;
	}

	bool topsort()
	{
		int hh = 0,tt = 0;
		for(int i = 1;i <= n;++i)
			if(!into[i]) q[tt++] = i;
		while(hh < tt)
		{
			int t = q[hh++];
			for(int i = h[t];~i;i = ne[i])
			{
				int j = e[i];
				into[j]--;
				if(!into[j])
					q[tt++] = j;
			}
		}
		if(tt == n)
			return true;
		return false;
	}

	void init(int a, int b)
	{
		memset(h,-1,sizeof h);
		n = a,m = b;
		while(m--)
		{
			cin >> a >> b;
			add(a,b);
			into[b]++;
		}
		bool f = topsort();
	}
};
