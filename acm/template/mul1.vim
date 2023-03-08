vector<int> mul(vector<int>a, int b)
{
	vector<int>ans;
	int t = 0;
	for (int i = 0; i < a.size() || t; i++)
	{
		if(i < a.size())t += a[i] * b;
		ans.push_back(t % 10);
		t /= 10;
	}
	return ans;
}
