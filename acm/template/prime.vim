void prime(int n)
{
    vis[0] = vis[1] = 1;
    for (int i = 2; i <= n; i++)
    {
        if (!vis[i])
            primes.push_back(i);
        for (int j = 0; primes[j] * i <= n; j++)
        {
            vis[primes[j] * i] = 1;
            if (i % primes[j] == 0)
                break;
        }
    }
}
