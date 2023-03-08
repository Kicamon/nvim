template <typename T> T qmi(T a, T b, T p)
{
    T res = 1;
	a %= p;
    while (b)
    {
        if (b & 1)
            res = (long long)res * a % p;
        b >>= 1;
        a = (long long)a * a % p;
    }
    return res;
}
