int e[M], ne[M], w[M], h[N], idx;

void add(int a, int b, int c)
{
    e[idx] = b, ne[idx] = h[a], w[idx] = c, h[a] = idx++;
}

int dist[N];
bool vis[N];

int dijkstra(int start, int end)
{
    memset(dist, 0x3f, sizeof dist);
    dist[start] = 0;
    priority_queue<array<int, 2>, vector<array<int, 2>>, greater<array<int, 2>>> q;
    q.push({0, start});
    while (!q.empty())
    {
        array<int, 2> t = q.top();
        q.pop();

        if (vis[t[1]])
            continue;
        vis[t[1]] = true;

        for (int i = h[t[1]]; ~i; i = ne[i])
        {
            int j = e[i];
            if (dist[j] > dist[t[1]] + w[i])
            {
                dist[j] = dist[t[1]] + w[i];
                q.push({dist[j], j});
            }
        }
    }

    if (dist[end] == 0x3f3f3f3f)
        return -1;
    return dist[end];
}
