vector<int> div(vector<int> A, int b,int& r)
{
	vector<int>C;
	r = 0;
	for (int i = A.size() - 1; i >= 0; i--)
	{
		r = r * 10 + A[i];
		C.push_back(r / b);
		r = r % b;
	}
	reverse(C.begin(), C.end());
	while (C.size() > 1 && C.back() == 0)C.pop_back();
	return C;
}
