// 线段树的信息
const int N = 2e5 + 10,mod = 1e9 + 7;
int a[N];
struct info // 存储线段树的值
{
	int size;
	int num;
};

struct tag // 存储线段树的懒标记
{
	int add;
	int mul;
};

struct Node // 线段树
{
	info val;
	tag lazy;
}tr[N << 2];
int st_size; // 线段树的总区间大小

// 线段树的具体操作
info operator + (const info &l,const info &r) // pushup的操作
{
	info c;
	c.size = l.size + r.size;
	c.num = (1ll * l.num + r.num) % mod;
	return c;
}

info operator + (const info &v,const tag &t) // pushdown时，对子节点info的操作
{
	info c;
	c.size = v.size;
	c.num = (1ll * v.num * t.mul + 1ll * v.size * t.add) % mod;
	return c;
}

tag operator + (const tag &ts,const tag &tp) // pushdown时，对子节点tag的操作
{
	tag c;
	c.add = (1ll * ts.add * tp.mul + tp.add) % mod;
	c.mul = 1ll * ts.mul * tp.mul % mod;
	return c;
}

void pushup(int u)
{
	tr[u].val = tr[u << 1].val + tr[u << 1 | 1].val;
}

void pushdown(int u)
{
	Node &t = tr[u],&l = tr[u << 1],&r = tr[u << 1 | 1];
	l.val = l.val + t.lazy,l.lazy = l.lazy + t.lazy;
	r.val = r.val + t.lazy,r.lazy = r.lazy + t.lazy;
	t.lazy = {0,1};
}

void build(int u = 1, int l = 1, int r = st_size)
{
	if (l == r)
	{
		tr[u] = {r - l + 1, a[l], 0, 1};
		return;
	}
	tr[u] = {r - l + 1, 0, 0, 1};
	int mid = l + r >> 1;
	build(u << 1, l, mid), build(u << 1 | 1, mid + 1, r);
	pushup(u);
}

void modify(int u, int l, int r,tag c, int pl = 1, int pr = st_size)
{
	if (l <= pl && pr <= r)
	{
		tr[u].val = tr[u].val + c;
		tr[u].lazy = tr[u].lazy + c;
		return;
	}
	pushdown(u);
	int mid = pl + pr >> 1;
	if (l <= mid)
		modify(u << 1, l, r, c, pl, mid);
	if (r > mid)
		modify(u << 1 | 1, l, r, c, mid + 1, pr);
	pushup(u);
}

int query(int u, int l, int r, int pl = 1, int pr = st_size)
{
	if (l <= pl && pr <= r)
		return tr[u].val.num;
	int mid = pl + pr >> 1;
	pushdown(u);
	int res = 0;
	if (l <= mid)
		res = (1ll * res + query(u << 1, l, r, pl, mid)) % mod;
	if (r > mid)
		res = (1ll * res + query(u << 1 | 1, l, r, mid + 1, pr)) % mod;
	return res;
}
