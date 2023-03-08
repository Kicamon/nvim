template <typename T> T C(T a, T b)
{
    T res = 1;
    for (T i = a, j = 1; j <= b; --i, ++j)
        res = res * i / j;
    return res;
}
