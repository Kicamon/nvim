template <class T> struct Binary_Indexed_Tree
{
    int size;
    vector<T> c;
    struct Binary_Indexed_Tree(int n) : c(n + 1)
    {
        size = n;
    };
    void resize(int x)
    {
        size = x;
    }

    int lowbit(int x)
    {
        return x & -x;
    }

    void modify(int x, T d = 1)
    {
        assert(x != 0);
        for (int i = x; i <= size; i += lowbit(i))
            c[i] = c[i] + d;
    }

    T query(int x)
    {
        assert(x <= size);
        T res = 0;
        for (int i = x; i; i -= lowbit(i))
            res = res + c[i];
        return res;
    }
};
