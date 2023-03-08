int e[M],ne[M],w[M],h[N],idx;

void add(int a,int b,int c)
{
	e[idx] = b,ne[idx] = h[a],w[idx] = c,h[a] = idx++;
}
