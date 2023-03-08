int l = 0, r = len;
while (l < r)
{
    int mid = l + r >> 1;
    if (a[mid] < x)
        l = mid + 1;
    else
        r = mid;
}
