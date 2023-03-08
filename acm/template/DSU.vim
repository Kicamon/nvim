template <class T> struct DSU
{
    int pa[N], num[N];
    int size;
    void init(int x)
    {
        size = x;
        for (int i = 1; i <= size; ++i)
            pa[i] = i;
    }
    int find(int x)
    {
        if (pa[x] != x)
            pa[x] = find(pa[x]);
        return pa[x];
    }
};
