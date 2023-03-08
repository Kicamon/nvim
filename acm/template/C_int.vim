template <class T> struct C
{
    T qmi(T a, T b, T p)
    {
        T res = 1;
        while (b)
        {
            if (b & 1)
                res = (ll)res * a % p;
            b >>= 1;
            a = (ll)a * a % p;
        }
        return res;
    }

    T fct[N], infct[N];

    void init()
    {
        fct[0] = infct[0] = 1;
        for (int i = 1; i < N; ++i)
        {
            fct[i] = (ll)fct[i - 1] * i % mod;
            infct[i] = (ll)infct[i - 1] * qmi(i, mod - 2, mod) % mod;
        }
    }

    void get(T a, T b) // a为底
    {
        printf("%d\n", (ll)fct[a] * infct[b] % mod * infct[a - b] % mod);
    }
};
