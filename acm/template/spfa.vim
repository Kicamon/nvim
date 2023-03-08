bool vis[N];
int dist[N];
int spfa(int start,int end)
{
	memset(dist,0x3f,sizeof dist);	
	dist[start] = 0;

	queue<int>q;
	q.push(start);
	vis[start] = true;
	while(!q.empty())
	{
		int t = q.front();
		q.pop();
		vis[t] = false;
		for(int i = h[t];~i;i = ne[i])
		{
			int j = e[i];
			if(dist[j] > dist[t] + w[i])
			{
				dist[j] = dist[t] + w[i];
				if(!vis[j])
				{
					q.push(j);
					vis[j] = true;
				}
			}
		}
	}
	
	return dist[end];
}
