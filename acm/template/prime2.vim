template <class T> struct Prime2
{
    int primes[50010], _primes[N];
    int cnt, _cnt;
    bool vis[N];

    void prime(int n)
    {
        for (int i = 2; i <= n; ++i)
        {
            if (!vis[i])
                primes[cnt++] = i;
            for (int j = 0; primes[j] * i <= n; ++j)
            {
                vis[(ll)i * primes[j]] = true;
                if (i % primes[j] == 0)
                    break;
            }
        }
    }

    Prime2()
    {
        prime(50000);
    }

    void init(int l, int r) // 筛取l~r范围内的质数
    {
        memset(vis, 0, sizeof vis);
        memcpy(_primes, primes, sizeof primes);
        _cnt = cnt;
        for (int i = 0; i < _cnt; ++i)
        {
            ll p = _primes[i];
            for (ll j = max(p * 2, (l + p - 1) / p * p); j <= r; j += p)
                vis[j - l] = true;
        }

        _cnt = 0;
        for (int i = 0; i <= r - l; ++i)
        {
            if (!vis[i] && i + l >= 2)
                _primes[_cnt++] = i + l;
        }
    }
};
