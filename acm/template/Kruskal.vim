struct Kruskal 
{
	struct node 
	{
		int a,b,c;
		bool operator < (const node &v)
		{
			return c < v.c;
		}
	};
	vint p;
	vector<node> s;
	int size_n,size_m;

	Kruskal(int n,int m):p(n + 1),s(m)
	{
		size_n = n,size_m = m;
		for(int i = 1;i <= n;++i)
			p[i] = i;
	};
	int find(int x)
	{
		if(p[x] != x)
			p[x] = find(p[x]);
		return p[x];
	}

	void Kruskal_int()
	{
		int a,b,c;
		for(int i = 0;i < size_m;++i)
		{
			cin >> a >> b >> c;
			s[i] = {a,b,c};
		}
	}

	void Kruskal_get()
	{
		sort(all(s));
		int res = 0,cnt = 0;
		for(int i = 0;i < size_m;++i)
		{
			int a = s[i].a,b = s[i].b,c = s[i].c;

			a = find(a),b = find(b);
			if(a != b)
			{
				p[a] = b;
				res += c;
				cnt++;
			}
		}
		if(cnt < size_n - 1)
			cout << "impossible" << endl;
		else cout << res << endl;
	}
};
