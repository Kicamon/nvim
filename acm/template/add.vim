vector<int> add(vector<int> a, vector<int> b)
{
	if (a.size() < b.size()) return add(b, a);
	vector<int>c;

	int t = 0;
	for (int i = 0; i < a.size() || t; i++)
	{
		if (i < a.size())
		{
			t += a[i];
			if (i < b.size()) t += b[i];
		}
		c.push_back(t % 10);
		t /= 10;
	}

	return c;
}
