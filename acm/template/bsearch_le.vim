int l = 0, r = len;
while (l < r)
{
    int mid = l + r + 1 >> 1;
    if (a[mid] <= x)
        l = mid;
    else
        r = mid - 1;
}
