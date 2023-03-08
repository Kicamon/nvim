template <class T> struct Get_uler
{
    vector<int> primes;
    int phi[N];
    bool vis[N];

    void get_uler(int n)
    {
        phi[1] = 1;
        for (int i = 2; i <= n; ++i)
        {
            if (!vis[i])
            {
                phi[i] = i - 1;
                primes.push_back(i);
            }
            for (int j = 0; primes[j] * i <= n; ++j)
            {
                int t = primes[j] * i;
                vis[t] = true;
                if (i % primes[j] == 0)
                {
                    phi[t] = primes[j] * phi[i];
                    break;
                }
                phi[t] = phi[i] * (primes[j] - 1);
            }
        }
    }
};
