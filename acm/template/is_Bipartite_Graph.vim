int color[N];
int e[M],ne[M],h[N],idx;

void add(int a,int b)
{
	e[idx] = b,ne[idx] = h[a],h[a] = idx++;
}

bool dfs(int u,int c)
{
	color[u] = c;
	for(int i = h[u];~i;i = ne[i])
	{
		int j = e[i];
		if(!color[j])
		{
		    if(!dfs(j,3 - c))
		        return 0;
		}
		else if(color[j] == c) 
			return false;
	}
	return true;
}
