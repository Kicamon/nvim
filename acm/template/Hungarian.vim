int e[M],ne[M],h[N],idx;

void add(int a,int b)
{
	e[idx] = b,ne[idx] = h[a],h[a] = idx++;
}

int metch[N];
bool vis[N];

bool Hungarian(int u)
{
	for(int i = h[u];~i;i = ne[i])
	{
		int j = e[i];
		if(!vis[j])
		{
			vis[j] = true;
			if(!metch[j] || Hungarian(metch[j]))
			{
				metch[j] = u;
				return true;
			}
		}
	}
	return false;
}
