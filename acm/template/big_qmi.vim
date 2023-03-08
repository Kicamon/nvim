template<class T> struct BIG_QMI
{
	T qmi(T a, T b, T p)
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

	void get_pow(int a,string b,int p)
	{
		long long ans = 1;
		for(int i = (int)b.size() - 1;~i;--i)
		{
			ans = ans * qmi(a,b[i] - '0',p) % p;
			a = qmi(a,10,p);
		}
		cout << ans << endl;
	}
};
