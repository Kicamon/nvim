template <class T> struct Lucass
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

    int C(int a, int b, int p)
    {
        if (b > a)
            return 0;
        int ans = 1;
        for (int i = 1, j = a; i <= b; ++i, --j)
        {
            ans = (ll)ans * j % p;
            ans = (ll)ans * qmi(i, p - 2, p) % p;
        }
        return ans;
    }

    int lucass(ll a, ll b, int p)
    {
        if (a < p && b < p)
            return C(a, b, p);
        return (ll)C(a % p, b % p, p) * lucass(a / p, b / p, p) % p;
    }
};
