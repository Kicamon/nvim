template <typename T> T gcd(T a, T b)
{
    return b ? gcd(b, a % b) : a;
}
