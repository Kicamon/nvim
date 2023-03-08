vector<int> mul(vector<int>a, vector<int> b)
{
	vector<int >ans;
	for (int i = 0; i < a.size(); i++)
	{
		int t = 0;
		vector<int>n;
		for (int j = 0; j < i; j++)n.push_back(0);//列竖式中要往前移一位，这里通过在数的后边加0来实现，由于数是倒过来
		for (int j = 0; j < b.size() || t; j++)	  //的，就在它的左边加0。
		{
			if(j < b.size())t += a[i] * b[j];
			n.push_back(t % 10);
			t /= 10;
		}
		ans = add(ans, n);//add为高精度加法
	}
	return ans;
}
