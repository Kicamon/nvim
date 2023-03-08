vector<int> sub(vector<int> a, vector<int> b)
{
    vector<int>c;
    int t = 0;
    for (int i = 0; i < a.size() || t; i++)
    {
        int now = a[i] - t;
        if (i < b.size()) now -= b[i];
        c.push_back((now + 10) % 10);
        if (now < 0) t = 1;
        else t = 0;
    }
    while (c.size() > 1 && c.back() == 0) c.pop_back();
    return c;
}
