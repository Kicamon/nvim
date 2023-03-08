template <class T = long long> struct CRT
{
    T exgcd(T a, T b, T &x, T &y)
    {
        if (!b)
        {
            x = 1, y = 0;
            return a;
        }

        T d = exgcd(b, a % b, y, x);
        y -= a / b * x;
        return d;
    }

    long long crt(int n, long long *a, long long *m)
    {
        bool flag = true;
        for (int i = 1; i < n; ++i)
        {
            long long k1, k2;
            long long d = exgcd(a[i - 1], a[i], k1, k2);
            if ((m[i] - m[i - 1]) % d)
            {
                flag = false;
                break;
            }
            k1 *= (m[i] - m[i - 1]) / d;
            long long t = a[i] / d;
            k1 = (k1 % t + t) % t;
            m[i] = a[i - 1] * k1 + m[i - 1];
            a[i] = abs(a[i - 1] / d * a[i]);
        }
        if (flag)
            return (m[n - 1] % a[n - 1] + a[n - 1]) % a[n - 1];
        else
            return -1LL;
    }
};
